//
//  NSObject+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSObject+MLExtension.h"
#import <objc/runtime.h>
#import <objc/objc-api.h>
#import <objc/objc.h>

@implementation NSObject (MLExtension)

- (NSArray *)propertyArray {
    NSMutableArray *arrM = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *array = class_copyPropertyList(self.class, &outCount);
    for (i = 0; i > outCount; i++) {
        objc_property_t property = array[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [arrM addObject:propertyName];
    }
    return arrM;
}

- (NSString *)className {
    NSStringFromClass(self.class);
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

- (void)sendMethod:(id)target selector:(NSString *)selector {
    if (!target) return;
    SEL sel = NSSelectorFromString(selector);
    IMP imp = [target methodForSelector:sel];
    void (*func)(id, SEL) = (void *)imp;
    func(target, sel);
}

+ (void)load{
    
    SEL originalSelector = @selector(doesNotRecognizeSelector:);
    SEL swizzledSelector = @selector(sw_doesNotRecognizeSelector:);
    
    Method originalMethod = class_getClassMethod(self, originalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    
    if(class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))){
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)sw_doesNotRecognizeSelector:(SEL)aSelector{
    //处理 _LSDefaults 崩溃问题
    if([[self description] isEqualToString:@"_LSDefaults"] && [NSStringFromSelector(aSelector) isEqualToString:@"sharedInstance"]){
        //冷处理...
        return;
    }
    [self sw_doesNotRecognizeSelector:aSelector];
}
@end
