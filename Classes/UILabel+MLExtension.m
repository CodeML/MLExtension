//
//  UILabel+Extension.m
//  iKnowschool
//
//  Created by apple on 2019/10/23.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (void)setTextLineSpacing:(CGFloat)lineSpacing {
    
    if (!self.text || lineSpacing < 0.01) return;
    
    NSString *text = self.text;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}
@end
