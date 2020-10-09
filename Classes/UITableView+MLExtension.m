//
//  UITableView+MLExtension.m
//  iKnowschool
//
//  Created by apple on 2019/5/23.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UITableView+MLExtension.h"

@implementation UITableView (MLExtension)
- (void)scrollToBottom:(NSInteger)count {
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:count - 1 inSection:0];
    [self scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)scrollToBottom:(NSInteger)count animated:(BOOL)animated {
    double delayInSeconds = 0.2f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:count - 1 inSection:0];
        [self scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionTop animated:animated];
    });
}
@end
