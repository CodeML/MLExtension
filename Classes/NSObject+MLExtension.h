//
//  NSObject+KMRuntime.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KMRuntime)
@property (nonatomic, readonly, strong) NSArray *propertyArray;
@property (nonatomic, readonly, copy) NSString *className;

- (void)sendMethod:(id)target selector:(NSString *)selector;
@end

NS_ASSUME_NONNULL_END
