//
//  NSObject+STKit.h
//  YYDSocial
//
//  Created by  Sjw on 16/5/24.
//  Copyright © 2016年  Sjw. All rights reserved.
//

#import <Foundation/Foundation.h>

extern BOOL STClassRespondsToSelector(Class class, SEL aSelector);

@interface NSObject (STKit)

/**
 * @brief 给全局变量赋值/读取
 *
 * @param value  全局变量的新值
 * @param varName  全局变量名称.PS:属性的话记得加下划线 _property
 *
 * @discussion 如果是基本类型的var的话需要将value转换成 void *
 *
 */
- (void)setValue:(id)value forVar:(NSString *)varName;

- (id)valueForVar:(NSString *)varName;

/**
 * @brief 该类是否响应某个selector的类方法
 *
 * @param aSelector 类方法名称。
 *
 * @attention 不要和对象的respondsToSelector:搞混了，这个是对于某个Class的
 */
+ (BOOL)classRespondsToSelector:(SEL)aSelector;

@end
