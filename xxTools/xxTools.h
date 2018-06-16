//
//  xxTools.h
//  xxTools
//
//  Created by xiekunpeng on 2018/6/16.
//  Copyright © 2018年 xiekunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xxTools : NSObject


//NSString字符串是否为nil或空字符串
+(BOOL) isNSStringEmptyOrNil:(nullable NSString*)nStr;

//去掉NSString首尾的空格
+(nullable NSString*) trim:(nullable NSString*)nStr;

+ (BOOL)string:(nullable NSString*)nStr containsString:(nullable NSString *)subString;

+ (nullable ushort *)NSString2short:(nullable NSString*)str;

//ushort(宽字节（Unicode）)转NSString
+ (nullable NSString*)ushort2NString:(nullable const ushort *)strUshort;

#pragma mark - 验证

//判断指定的字符串是否匹配特定的正则表达式
+ (BOOL)regexMatch:(nonnull NSString *)sourceText withRegex:(nonnull NSString *)regexPattern;

//字符是否只有数字和字母构成
+(BOOL)isNumAndLetters:(nonnull NSString*)str;

//是否为IP地址
+ (BOOL)isIpAddress:(nonnull NSString*)ipStr;

//是否为Url
+ (BOOL)isUrl:(nonnull NSString *)urlStr;

//是否为数字
+ (BOOL)isNumber:(nonnull NSString*)numStr;

//是否为身份证号码
+ (BOOL)isIdentityCarNum:(nonnull NSString*)carNum;

//是否是座机号码
+ (BOOL) isTelePhoneNum:(nonnull NSString*)phoneNum;

//是否为手机号码
+ (BOOL)isMobilePhoneNum:(nonnull NSString*)phoneNum;

//是否可以组成手机号码
+ (BOOL) isRegexMatchMobilePhoneNum:(nonnull NSString *)phoneNum;

//对url进行中文编码
+ (nonnull NSString*)urlEncodingWithStr:(nonnull NSString*)strUrl;

//提取子串
+ (nullable NSString *)getMidString:(nullable NSString*)sourceString leftString:(nullable NSString*)leftStr rightString:(nullable NSString*)rightStrig;

@end
