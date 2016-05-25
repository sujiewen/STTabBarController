//
//  NSObject+STKit.m
//  YYDSocial
//
//  Created by  Sjw on 16/5/24.
//  Copyright © 2016年  Sjw. All rights reserved.
//

#import "NSObject+STKit.h"
#import "objc/runtime.h"

NSValue *STCreateValueFromPrimitivePointer(void *pointer, const char *objCType) {
    // CASE marcro inspired by https://www.mikeash.com/pyblog/friday-qa-2013-02-08-lets-build-key-value-coding.html
#define CASE(ctype)                                                                                                                                  \
if (strcmp(objCType, @encode(ctype)) == 0) {                                                                                                     \
return @((*(ctype *)pointer));                                                                                                               \
}
    CASE(BOOL);
    CASE(char);
    CASE(unsigned char);
    CASE(short);
    CASE(unsigned short);
    CASE(int);
    CASE(unsigned int);
    CASE(long);
    CASE(unsigned long);
    CASE(long long);
    CASE(unsigned long long);
    CASE(float);
    CASE(double);
#undef CASE
    @try {
        return [NSValue valueWithBytes:pointer objCType:objCType];
    }
    @catch (NSException *exception) {
    }
    return nil;
}

BOOL STClassRespondsToSelector(Class class, SEL aSelector) {
    if (!class || !aSelector) {
        return NO;
    }
    Method method = class_getClassMethod(class, aSelector);
    return (method != nil);
}


@implementation NSObject (STKit)
/// 设置全局变量的值,包括private类型的
- (void)setValue:(id)value forVar:(NSString *)varName {
    const char *varNameChar = [varName cStringUsingEncoding:NSUTF8StringEncoding];
    Ivar var = class_getInstanceVariable(self.class, varNameChar);
    if (var) {
        const char *typeEncodingCString = ivar_getTypeEncoding(var);
        if (typeEncodingCString[0] == '@') {
            object_setIvar(self, var, value);
        } else if ([value isKindOfClass:[NSValue class]]) {
            // Primitive - unbox the NSValue.
            NSValue *valueValue = (NSValue *)value;
            if (strcmp([valueValue objCType], typeEncodingCString) != 0) {
                return;
            }
            NSUInteger bufferSize = 0;
            @try {
                // NSGetSizeAndAlignment barfs on type encoding for bitfields.
                NSGetSizeAndAlignment(typeEncodingCString, &bufferSize, NULL);
            }
            @catch (NSException *exception) {
#if DEBUG
                NSLog(@"STKit === %@", exception);
#endif
            }
            if (bufferSize > 0) {
                void *buffer = calloc(1, bufferSize);
                [valueValue getValue:buffer];
                ptrdiff_t offset = ivar_getOffset(var);
                void *pointer = (__bridge void *)self + offset;
                memcpy(pointer, buffer, bufferSize);
                free(buffer);
            }
        }
    }
}

- (id)valueForVar:(NSString *)varName {
    const char *varNameChar = [varName cStringUsingEncoding:NSUTF8StringEncoding];
    Ivar var = class_getInstanceVariable(self.class, varNameChar);
    if (var) {
        const char *type = ivar_getTypeEncoding(var);
        if (type[0] == @encode(id)[0] || type[0] == @encode(Class)[0]) {
            return object_getIvar(self, var);
        } else {
            ptrdiff_t offset = ivar_getOffset(var);
            void *pointer = (__bridge void *)self + offset;
            return STCreateValueFromPrimitivePointer(pointer, type);
        }
    }
    return nil;
}

+ (BOOL)classRespondsToSelector:(SEL)aSelector {
    return STClassRespondsToSelector(self, aSelector);
}

@end