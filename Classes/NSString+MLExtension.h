//
//  NSString+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSString (KMExtension)
   //去除表情规则
    //  \u0020-\\u007E  标点符号，大小写字母，数字
    //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
    //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
    //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
    //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
    //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
    // 注：对照表 http://blog.csdn.net/hherima/article/details/9045765
- (NSString *)noEmoji;
/** *  判断字符串中是否包含非法字符 *
 @param content 需要判断的字符串 *
 @return Yes: 包含；No: 不包含 */
- (BOOL)hasIllegalCharacter:(NSString *)content;
//判断是否是emoji表情
- (BOOL)isEmoji;
// 整数
- (BOOL)isInt;
// 是否为url
- (BOOL)isURL;
// 是否为时间戳
- (BOOL)isTimeStamp;
// 手机号 11 位
- (BOOL)isMobile;
// 密码 数字字母组合 6-20 位
- (BOOL)isPassword;
// 用户名 1-20 位
- (BOOL)isUserName;
// 身份证 15 或 18 位
- (BOOL)isIdNumber;
// 验证码 数字 6 位
- (BOOL)isVcoed;
// 纯中文
- (BOOL)isChinese;
// 包含中文
- (BOOL)includeChinese;
// 中英文加系统九宫格
- (BOOL)isEnglish_Chinese;

- (NSString *)md5;

- (NSString *)toUTF8String;
- (NSString *)to64String;
// 左右对其
- (NSAttributedString *)toLRStr;
- (NSString *)toLink;
- (NSString *)toHTMLStr;
- (NSString *)removeltgt;
- (NSAttributedString *)toLinkHtmlString;
- (NSAttributedString *)colorString:(NSString *)str color:(UIColor *)color;

- (NSString *)removeSpace;
- (NSString *)remove:(NSString *)str;

//- (NSString *)URLEncodedString;
//- (NSString *)URLDecodedString;
+ (NSString *)fileSize:(double)byte;
- (NSString *)toPinyin;
- (NSString *)firstLetter;      //文字转拼音的首字母(大写)
- (NSDictionary *)toDict;
- (NSString *)toTimeBefore;
- (NSDate *)toDate;
- (NSDate *)toDateWithFormat:(NSString *)format;
- (NSString *)from:(NSString *)from;
- (NSString *)from:(NSString *)from to:(NSString *)to;
- (NSString *)from:(NSString *)from to:(NSString *)to options:(NSStringCompareOptions)mask;
- (NSString *)toDateString:(NSString *)format;
+ (NSString *)nowWithTimeInterval:(NSTimeInterval)oldTime;
- (NSString *)add:(NSInteger)value;
- (NSTimeInterval)serverTimeToTimeInterval;
- (NSInteger)compareVersion:(NSString *)version;

/// 字符串替换为*号
/// @param start 起始位置
/// @param lenght 替换长度
- (NSString *)replaceAsterisk:(NSInteger)start lenght:(NSInteger)lenght;
@end

NS_ASSUME_NONNULL_END
