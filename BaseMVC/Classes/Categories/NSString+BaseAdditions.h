//
//  NSString+Additions.h
//  MobileCRM
//
//  Created by wangweishun on 7/22/14.
//  Copyright (c) 2014 wangweishun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (BaseAdditions)


+ (NSString *)UUID;

///判断字符串是否为空 返回NO OR YES;
+ (BOOL)isHaveValue:(NSString *)string;

///判断字符串是否为空,并返回当前字符串 OR @""
+ (NSString *)judgmentString:(NSString *)string;


//检测是否有表情符号
+ (BOOL)isContainsEmoji:(NSString *)originString;

//检测是否必须含有字母和数字
+ (BOOL)judgeNameLegal:(NSString *)pass;

- (BOOL)textIsAllSpace;

- (BOOL)isNumber;

- (BOOL)isChinese;

- (BOOL)isEmail;

- (BOOL)isMobile;

- (BOOL)isIDNumber;



@end
