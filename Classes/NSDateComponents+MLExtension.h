//
//  NSDateComponents+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateComponents (MLExtension)
- (NSDate *)toDate;
- (NSString *)toString;
- (NSString *)toStringWithFormat:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
