//
//  NSDictionary+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class MLBaseModel, MLBaseCellModel;
@interface NSDictionary (MLExtension)
- (NSString *)toRequest;
- (NSString *)toString;
- (MLBaseCellModel *)toModel;
- (MLBaseModel *)toModel:(NSString *)modelName;
@end

NS_ASSUME_NONNULL_END
