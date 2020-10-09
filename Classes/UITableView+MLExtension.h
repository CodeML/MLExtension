//
//  UITableView+Extension.h
//  iKnowschool
//
//  Created by apple on 2019/5/23.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Extension)
- (void)scrollToBottom:(NSInteger)count;
- (void)scrollToBottom:(NSInteger)count animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
