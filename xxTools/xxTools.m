//
//  xxTools.m
//  xxTools
//
//  Created by xiekunpeng on 2018/6/16.
//  Copyright © 2018年 xiekunpeng. All rights reserved.
//

#import "xxTools.h"
#import <UIKit/UIKit.h>


@implementation xxTools

+(BOOL) isNSStringEmptyOrNil:(nullable NSString*)nStr {
    NSString *myStr = [[self class] trim:nStr];
    return (nil == myStr || 0 == myStr.length) ? YES : NO;
}

+(nullable NSString*) trim:(nullable NSString*)nStr {
    if(nil == nStr) {
        return nil;
    }
    return [nStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)string:(nullable NSString*)nStr containsString:(nullable NSString *)subString {
    if(nil == nStr) {
        return NO;
    }
    if(nil == subString) {
        return YES;
    }
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        NSRange range = [nStr rangeOfString:subString];
        if(range.length > 0){
            return YES;
        }
        return NO;
    }
    return [nStr containsString:subString];
}

+ (nullable ushort *)NSString2short:(nullable NSString*)str {
    if(nil == str)  {
        return NULL;
    }
    return (ushort*)[str cStringUsingEncoding:NSUTF16LittleEndianStringEncoding];
}

+ (nullable NSString*)ushort2NString:(nullable const ushort *)strUshort {
    if (NULL == strUshort) {
        return  nil;
    }
    NSInteger len = [[self class] getBytesLength:strUshort];
    NSString *str = [[NSString alloc] initWithBytes:(void*)strUshort length:len encoding:NSUTF16LittleEndianStringEncoding];
    return str;
}

+(NSUInteger)getBytesLength:(nullable const ushort *)pszStr {
    if (NULL == pszStr)  {
        return  0;
    }
    NSInteger iLen = 0;
    while(*pszStr != 0) {
        ++iLen;
        ++pszStr;
    }
    return iLen * sizeof(ushort);
}


#pragma mark - 验证

+ (BOOL)regexMatch:(nonnull NSString *)sourceText withRegex:(nonnull NSString *)regexPattern {
    if(0 == sourceText.length) {
        return NO;
    }
    NSError *matchError = nil;
    NSRegularExpression *regexExpression = [NSRegularExpression regularExpressionWithPattern:regexPattern
                                                                                     options:0
                                                                                       error:&matchError];
    const NSUInteger matchCount = [regexExpression numberOfMatchesInString:sourceText
                                                                   options:0
                                                                     range:NSMakeRange(0, [sourceText length])];
    return 0 != matchCount;
}

+(BOOL)isNumAndLetters:(nonnull NSString*)str {
    return [[self class] regexMatch:str withRegex:@"^[A-Za-z0-9]+$"];
}

//是否为IP地址
+ (BOOL)isIpAddress:(nonnull NSString*)ipStr {
    return [[self class] regexMatch:ipStr withRegex:@"^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})(\\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})){3}$"];
}

//是否为Url
+ (BOOL)isUrl:(nonnull NSString *)urlStr {
    return [[self class] regexMatch:urlStr withRegex:@"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?"];
}

//是否为数字
+ (BOOL)isNumber:(nonnull NSString*)numStr {
    return [[self class] regexMatch:numStr withRegex:@"^(-)?[0-9]+([.][0-9]+){0,1}$"];
}

//是否为身份证号码
+ (BOOL)isIdentityCarNum:(nonnull NSString*)carNum {
    return [[self class] regexMatch:carNum withRegex:@"^(\\d{14}[[0-9],0-9xX]"];
}

//是否是座机号码
+ (BOOL) isTelePhoneNum:(nonnull NSString*)phoneNum {
    return [[self class] regexMatch:phoneNum withRegex:@"^(\\d{3,4}-)\\d{7,8}$"];
}

//是否为手机号码
+ (BOOL)isMobilePhoneNum:(nonnull NSString*)phoneNum {
    return [[self class] regexMatch:phoneNum withRegex:@"^1[3|4|5|7|8][0-9]\\d{8}$"];
}

+ (BOOL) isRegexMatchMobilePhoneNum:( NSString *)phoneNum {
    if(0 == phoneNum.length) {
        return YES;
    }
    else if(1 == phoneNum.length) {
        return [phoneNum isEqualToString:@"1"];
    }
    else if(2==phoneNum.length) {
        return [[self class] regexMatch:phoneNum withRegex:@"^1[3|4|5|7|8]$"];
    }
    else if(3 == phoneNum.length) {
        return [[self class] regexMatch:phoneNum withRegex:@"^1[3|4|5|7|8][0-9]$"];
    }
    else if(phoneNum.length <=11){
        return [[self class] regexMatch:phoneNum withRegex:@"^1[3|4|5|7|8][0-9]\\d{0,8}$"];
    }
    return NO;
}

+ (NSString*)urlEncodingWithStr:(NSString*)strUrl {
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)strUrl,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
    
}

//提取子串
+ (nullable NSString *)getMidString:(nullable NSString*)sourceString leftString:(nullable NSString*)leftStr rightString:(nullable NSString*)rightStrig {
    NSRange leftRange = [sourceString rangeOfString:leftStr];
    NSRange rightRange = [sourceString rangeOfString:rightStrig];
    if(leftRange.length==0||rightRange.length==0)  {
        return nil;
    }
    
    return  [sourceString  substringWithRange: NSMakeRange(leftRange.location+leftStr.length, rightRange.location - leftRange.location-leftStr.length)];
}
@end
