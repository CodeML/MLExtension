//
//  NSString+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSString+MLExtension.h"
#import "NSDate+MLExtension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MLExtension)

- (NSString *)md5 {
    const char *cStr = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

- (NSString *)removeSpace {
    return [self remove:@" "];
}

- (NSString *)remove:(NSString *)str {
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}

- (NSDictionary *)toDict {
    if (!self.length) {
        return @{};
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return @{};
    }
    return dic;
}

- (NSString *)toLink {
    return [NSString stringWithFormat:@"<a href='%@' style='color: #5B6A91; text-decoration: none; font-size: 16'> %@ </a>", self, self];
}

- (NSString *)toHTMLStr {
    NSMutableString *html = [NSMutableString stringWithString:@"<span style='color: #333333; font-size: 14'>"];
    
    NSString *str = self.copy;
    
    NSString *new = self.copy;
    while (YES) {
        NSString *link = [str from:@"{" to:@"}"];
        
        NSArray *array = [link componentsSeparatedByString:@"|"];
        
        if (link.length) {
            NSString *linkStr = [NSString stringWithFormat:@"<a href='%@' style='color: #5B6A91; text-decoration: none; font-size: 14'> %@ </a>", array.firstObject, array.lastObject];
            
            str = [str from:@"}"];
            
            new = [new stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}", link] withString:linkStr];
        }else{
            break;
        }
    }
    [html appendString:new];
    [html appendString:@"<span>"];
    return html;
}

- (NSAttributedString *)toLinkHtmlString {

    NSString *str = self;
    str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    str = [str stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc]init];
    par.alignment = NSTextAlignmentJustified;
    
    NSDictionary *dic = @{NSParagraphStyleAttributeName : par, NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone),
                          NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:dic documentAttributes:nil error:nil];
    
    return attrStr;
}

- (NSAttributedString *)htmlString {
    
    NSString *str = self;
    str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    str = [str stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[[NSString stringWithFormat:@" %@", str] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    return attributedString;
}

- (NSString *)from:(NSString *)from to:(NSString *)to options:(NSStringCompareOptions)mask {
    NSString *oldStr = self.copy;
    if (from.length) {
        NSRange start = [oldStr rangeOfString:from];
        if (start.location != NSNotFound) {
            oldStr = [oldStr substringFromIndex:start.location + start.length];
        }
    }

    if (to.length) {
        NSRange end = [oldStr rangeOfString:to options:mask];
        if (end.location != NSNotFound) {
            oldStr = [oldStr substringToIndex:end.location];
        }
    }
    return oldStr.length == self.length ? @"" : oldStr;
}

- (NSString *)from:(NSString *)from to:(NSString *)to {
    return [self from:from to:to options:NSLiteralSearch];
}

- (NSString *)from:(NSString *)from {
    return [self from:from to:@"" options:NSLiteralSearch];
}

- (NSString *)toTimeBefore {
    if (self.isTimeStamp) {
        return [NSString nowWithTimeInterval:self.integerValue];
    }
    return @"";
}

- (NSTimeInterval)serverTimeToTimeInterval {
    return [self toDateWithFormat:@"yyyy-MM-dd HH:mm:ss"].timeIntervalSince1970;
}

+ (NSString *)nowWithTimeInterval:(NSTimeInterval)oldTime {
    if (oldTime > 1000000000000) {
        oldTime /= 1000;
    }
    // 计算现在距1970年多少秒
    NSTimeInterval currentTime = NSDate.date.timeIntervalSince1970;
    
    // 计算现在的时间和发布消息的时间时间差
    NSTimeInterval timeDiffence = currentTime - oldTime;

    // 根据秒数的时间差的不同，返回不同的日期格式
    if (timeDiffence <= 60) {
        return @"刚刚";
    }else if (timeDiffence <= 3600){
        return [NSString stringWithFormat:@"%.0f 分钟前",timeDiffence / 60];
    }else if (timeDiffence <= 86400){
        return [NSString stringWithFormat:@"%.0f 小时前",timeDiffence / 3600];
    }else if (timeDiffence <= 604800){
        return [NSString stringWithFormat:@"%.0f 天前",timeDiffence / 3600 /24];
    }else{
        // 返回具体日期
        return [NSDate dateWithTimeIntervalSince1970:oldTime].toString;
    }
}

- (NSMutableAttributedString *)changeFont:(UIFont *)font rangeCount:(NSInteger)count {
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:self];
    if (self.length < count) { return attrStrM; }
    [attrStrM addAttribute:NSFontAttributeName value:font range:NSMakeRange(self.length - count, count)];
    return attrStrM;
}

- (NSMutableAttributedString *)changeFont:(UIFont *)font range:(NSString *)range {
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:self];
    if (!range) { return attrStrM; }
    [attrStrM addAttribute:NSFontAttributeName value:font range:[self rangeOfString:range?:@""]];
    return attrStrM;
}

- (NSMutableAttributedString *)changeFonts:(NSArray <UIFont *> *)fonts ranges:(NSArray <NSString *> *)ranges {
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:self];
    if (fonts.count != ranges.count) {
        return attrStrM;
    }
    for (int i = 0; i < fonts.count; i++) {
        [attrStrM addAttribute:NSFontAttributeName value:fonts[i] range:[self rangeOfString:ranges[i]]];
    }
    return attrStrM;
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color range:(NSString *)range {
    
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:self];
    if (!range) { return attrStrM; }
    [attrStrM addAttribute:NSForegroundColorAttributeName value:color range:[self rangeOfString:range]];
    return attrStrM;
}

- (NSMutableAttributedString *)changeColors:(NSArray <UIColor *> *)colors ranges:(NSArray <NSString *> *)ranges {
    
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:self];
    if (colors.count != ranges.count) {
        return attrStrM;
    }
    for (int i = 0; i < colors.count; i++) {
        [attrStrM addAttribute:NSForegroundColorAttributeName value:colors[i] range:[self rangeOfString:ranges[i]]];
    }
    return attrStrM;
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color font:(UIFont *)font range:(NSString *)range {
    
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:self];
    if (!range) { return attrStrM; }
    [attrStrM addAttribute:NSForegroundColorAttributeName value:color range:[self rangeOfString:range]];
    [attrStrM addAttribute:NSFontAttributeName value:font range:[self rangeOfString:range?:@""]];
    return attrStrM;
}

- (NSString *)toUTF8String {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)to64String {
    NSData *data64 = [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedDataWithOptions:0];
    return [[NSString alloc] initWithData:data64 encoding:NSUTF8StringEncoding];
}

- (NSAttributedString *)toLRStr {
    NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc]init];
    par.alignment = NSTextAlignmentJustified;
    
    NSDictionary *dic = @{NSParagraphStyleAttributeName : par, NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    
    return [[NSAttributedString alloc] initWithString:self attributes:dic];
}

- (NSAttributedString *)addRedStar {
    NSString *str = [NSString stringWithFormat:@"%@*", self];
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStrM addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:[str rangeOfString:@"*"]];
    return attrStrM;
}

////通讯编码
//- (NSString *)URLEncodedString {
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *result = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                              (CFStringRef) self,
//                                                              NULL,
//                                                              CFSTR("!*'();:@&=+$,/?%#[] "),
//                                                              enc));
//
//    return result;
//}
////通讯解码
//- (NSString *)URLDecodedString {
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *result = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
//                                                                              (CFStringRef) self,
//                                                                              CFSTR(""),
//                                                                              enc));
//    return result;
//}

- (NSString *)firstLetter {
    NSString *py = self.toPinyin;
    NSString *letter = @"";
    if (py.length > 1) {
        letter = [py substringToIndex:1];
    }else if (py.length == 1) {
        letter = py;
    }else{
        return @"";
    }
    return letter.uppercaseString;
}

- (NSString *)toPinyin {
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString *)toDateString:(NSString *)format {
    NSTimeInterval oldTime = self.integerValue;
    if (oldTime > 1000000000000) {
        oldTime /= 1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:oldTime];
    return [date toStringWithFormat:format];
}

- (NSDate *)toDate {
    if ([self containsString:@":"] && [self containsString:@"-"]) {
        return [self toDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if ([self containsString:@"-"]) {
        return [self toDateWithFormat:@"yyyy-MM-dd"];
    }else{
        return NSDate.date;
    }
}

- (NSDate *)toDateWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:format];

    return [dateFormatter dateFromString:self];
}

+ (NSString *)fileSize:(double)byte {
    NSInteger index = 0;

    NSArray *tokens = @[@"bytes", @"KB", @"MB", @"GB", @"TB", @"PB", @"EB", @"ZB", @"YB"];
    
    while (byte > 1024) {
        byte /= 1024.0f;
        index++;
    }

    return [NSString stringWithFormat:@"%.2f %@",byte, tokens[index]];
}

#pragma mark - matching
- (BOOL)isURL {
    return [self containsString:@"https://"] || [self containsString:@"http://"];
}

- (BOOL)isEmail {
      NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
      NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
      return [emailTest evaluateWithObject:self];
}

- (BOOL)isMobile {
    if (self.length != 11) {
        return NO;
    } else {
        /**
         * 中国移动：China Mobile
         * 134(0-8)、135、136、137、138、139、
         * 147、150、151、152、157、158、159、
         * 172、178、182、183、184、187、188、198
         */
        NSString * CM = @"^1(3[5-9]|47|5[0-2,7-9]|7[28]|8[23478]|98)\\d{8}|(134[0-8])\\d{7}$";
        /**
         * 中国联通：China Unicom
         * 130、131、132、145、155、156、166、175、176、185、186
         */
        NSString * CU = @"^1((3[0-2]|45|5[56]|66|7[56]|8[56]))\\d{8}$";
        /**
         * 中国电信：China Telecom
         * 133、149、153、173、177、180、181、189、191、199
         */
        NSString * CT = @"^1((33|49|53|7[37]|8[019]|9[19]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else {
            return NO;
        }
    }
    
}

- (BOOL)isPassword {
    NSString *pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isUserName {
    NSString *pattern =@"^[a-zA-Z\u4E00-\u9FA5]{1,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

- (BOOL)isInt {
    NSString *pattern = @"^[0-9]\\d*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isIdNumber{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isVcoed {
    NSString *pattern = @"^[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese {
    for(int i = 0; i < self.length; i++) {
        int c = [self characterAtIndex:i];
        if(c >= 0x4e00 && c <= 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isEnglish_Chinese {
    NSString *match = @"(^[a-zA-Z\u4e00-\u9fa5➋➌➍➎➏➐➑➒]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isTimeStamp {
    NSString *pattern =@"^[0-9]{13}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)integerStringAdd:(NSInteger)value {
    return [NSString stringWithFormat:@"%li", self.integerValue + value];
}

- (NSString *)integerStringSub:(NSInteger)value {
    return [NSString stringWithFormat:@"%li", self.integerValue - value];
}

//实现
- (BOOL)isEmoji {
    if (self.length < 2) return NO;

    static NSCharacterSet *_variationSelectors;
    _variationSelectors = [NSCharacterSet characterSetWithRange:NSMakeRange(0xFE00, 16)];

    if ([self rangeOfCharacterFromSet: _variationSelectors].location != NSNotFound)
    {
        return YES;
    }
    const unichar high = [self characterAtIndex:0];
    // Surrogate pair (U+1D000-1F9FF)
    if (0xD800 <= high && high <= 0xDBFF)
    {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        // Not surrogate pair (U+2100-27BF)
    }
    else
    {
        return (0x2100 <= high && high <= 0x27BF);
    }
}

- (NSString *)noEmoji {
    //去除表情规则
    //  \u0020-\\u007E  标点符号，大小写字母，数字
    //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
    //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
    //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
    //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
    //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
//     注：对照表 http://blog.csdn.net/hherima/article/details/9045765

    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];

    NSString* result = [expression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];

    return result;
}

/** *  判断字符串中是否包含非法字符 *
 @param content 需要判断的字符串 *
 @return Yes: 包含；No: 不包含 */
- (BOOL)hasIllegalCharacter:(NSString *)content{
    // 特殊字符
    NSString *str = @"[^%@#^*&¥'~=$<>`\x22]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

- (NSInteger)compareVersion:(NSString *)version {

    if (!self && !version) {
        return 0;
    }
    
    if (!self && version) {
        return -1;
    }
    
    if (self && !version) {
        return 1;
    }
    
    // 获取版本号字段
    NSArray *v1Array = [self componentsSeparatedByString:@"."];
    NSArray *v2Array = [version componentsSeparatedByString:@"."];
    // 取字段最大的，进行循环比较
    NSInteger bigCount = (v1Array.count > v2Array.count) ? v1Array.count : v2Array.count;
    
    for (int i = 0; i < bigCount; i++) {
        // 字段有值，取值；字段无值，置0。
        NSInteger value1 = (v1Array.count > i) ? [[v1Array objectAtIndex:i] integerValue] : 0;
        NSInteger value2 = (v2Array.count > i) ? [[v2Array objectAtIndex:i] integerValue] : 0;
        if (value1 > value2) {
            return 1;
        } else if (value1 < value2) {
            return -1;
        }
    }
    return 0;
}

- (NSString *)replaceAsterisk:(NSInteger)start lenght:(NSInteger)lenght {
    NSRange range = NSMakeRange(start, lenght);
    return [self stringByReplacingCharactersInRange:range withString:@"*"];
}

- (NSString *)removeltgt {
    NSString *temp = self;
    temp = [temp stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    temp = [temp stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

    temp = [temp stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    temp = [temp stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    temp = [temp stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    temp = [temp stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    return temp;
}

- (NSAttributedString *)colorString:(NSString *)str color:(UIColor *)color {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:[self rangeOfString:str]];
    return attrStr;
}

- (NSAttributedString *)addImage:(UIImage *)img bounds:(CGRect)bounds index:(NSInteger)index {
    if (self.length == 0) {
        return [NSAttributedString new];
    }
    
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = img;
    attch.bounds = bounds;
    
    NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attrStrM insertAttributedString:attrStr atIndex:index];
    return attrStrM;
}

- (NSAttributedString *)addImage:(NSString *)img size:(CGFloat)WH {
    if (self.length == 0) {
        return [NSAttributedString new];
    }
    return [self addImage:[UIImage imageNamed:img] bounds:CGRectMake(0, -3, WH, WH) index:self.length - 1];
}

- (NSString *)priceString {
    return [[NSDecimalNumber decimalNumberWithString:self] priceString];
}

- (BOOL)isNotEmpty {
    if (!self.length) {
        return NO;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if(!trimedString.length) {
            return NO;
        } else {
            return YES;
        }
    }
}
@end
