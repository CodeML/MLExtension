//
//  UIFont+MLExtension.m
//  iKnowschool
//
//  Created by apple on 2019/6/13.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UIFont+MLExtension.h"

@implementation UIFont (MLExtension)
+ (UIFont *)FONT10 {
    return [UIFont systemFontOfSize:10];
}

+ (UIFont *)FONT12 {
    return [UIFont systemFontOfSize:12];
}

+ (UIFont *)FONT14 {
    return [UIFont systemFontOfSize:14];
}

+ (UIFont *)FONT16 {
    return [UIFont systemFontOfSize:16];
}

+ (UIFont *)FONT18 {
    return [UIFont systemFontOfSize:18];
}

+ (UIFont *)FONT20 {
    return [UIFont systemFontOfSize:20];
}

+ (UIFont *)FONT20_B {
    return [UIFont boldSystemFontOfSize:20];
}

+ (UIFont *)FONT28_B {
    return [UIFont boldSystemFontOfSize:28];
}

+ (UIFont *)FONT30_B {
    return [UIFont boldSystemFontOfSize:30];
}

+ (UIFont *)FONT18_B {
    return [UIFont boldSystemFontOfSize:18];
}

+ (UIFont *)FONT16_B {
    return [UIFont boldSystemFontOfSize:16];
}

+ (UIFont *)FONT14_B {
    return [UIFont boldSystemFontOfSize:14];
}

+ (UIFont *)FONT12_B {
    return [UIFont boldSystemFontOfSize:12];
}

+ (UIFont *)FONT10_B {
    return [UIFont boldSystemFontOfSize:10];
}

+ (UIFont * _Nonnull (^)(CGFloat size, UIFontWeight weight))font {
    return ^id(CGFloat size, UIFontWeight weight){
        return [UIFont systemFontOfSize:size weight:weight];;
    };
}

+ (UIFont * _Nonnull (^)(CGFloat size))size {
    return ^id(CGFloat size){
        return [UIFont systemFontOfSize:size];
    };
}

+ (UIFont * _Nonnull (^)(CGFloat size))bold {
    return ^id(CGFloat size){
        return [UIFont boldSystemFontOfSize:size];
    };
}
@end
