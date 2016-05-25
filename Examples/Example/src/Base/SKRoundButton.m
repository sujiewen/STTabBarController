//
//  SKRoundButton.m
//  STSecret
//
//  Created by SunJiangting on 14-3-27.
//  Copyright (c) 2014年 Attackers. All rights reserved.
//

#import "SKRoundButton.h"

@implementation SKRoundButton


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        
//        __weak SKRoundButton *weakSelf = self;
//        self.hitTestBlock = ^(CGPoint point, UIEvent *event, BOOL *returnSuper) {
//            CGPoint center = CGPointMake(CGRectGetWidth(weakSelf.bounds) / 2, CGRectGetHeight(weakSelf.bounds) / 2);
//            if (STDistanceBetweenPoints(point, center) <= weakSelf.size.width / 2) {
//                *returnSuper = YES;
//            }
//            return (UIView *)nil;
//        };
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    CGFloat distance2 = ABS((point.x - center.x) * (point.x - center.x) + (point.y - center.y) * (point.y - center.y));
    return sqrtf(distance2) <= self.size.width / 2;
}

- (void)setFrame:(CGRect)frame {
    if (frame.size.width != frame.size.height) {
        frame.size.width = frame.size.height;
    }
    [super setFrame:frame];
    self.layer.cornerRadius = CGRectGetWidth(frame) / 2;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"===Touches");
}

@end
