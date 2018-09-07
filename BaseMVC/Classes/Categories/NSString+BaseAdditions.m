//
//  NSString+Additions.m
//  MobileCRM
//
//  Created by wangweishun on 7/22/14.
//  Copyright (c) 2014 wangweishun. All rights reserved.
//

#import "NSString+BaseAdditions.h"

@implementation NSString (BaseAdditions)



+ (NSString *)UUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    return (__bridge_transfer NSString *)uuid;
}

/*****
 * 检测字符串是否为空或全为空格
 */
- (BOOL)textIsAllSpace
{
    BOOL isSpace = YES;
    
    if(self == nil || [self isEqualToString:@""]){
        isSpace = YES;
    }else if([self isEqual:[NSNull null]]){
        isSpace = YES;
    }else{
        //是否全为空格
        NSString *string = [NSString stringWithFormat:@"%@",self];
        
        for (NSInteger i=0; i<[string length]; i++) {
            NSString *subString = [string substringWithRange:NSMakeRange(i, 1)];
            if (![subString isEqualToString:@" "]) {
                isSpace = NO;
                break;
            }

        }
    }
    return isSpace;
}



+ (BOOL)isHaveValue:(NSString *)string {
    if (string == nil || string == NULL) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    string = [NSString stringWithFormat:@"%@",string];
    if ([string rangeOfString:@"<null>"].length > 0) {
        NSMutableString *mString = [NSMutableString stringWithFormat:@"%@",string];
        
        [mString deleteCharactersInRange:[mString rangeOfString:@"<null>"]];
        if (mString.length == 0 || [mString textIsAllSpace]) {
            return NO;
        }
    }
    
    if ([string rangeOfString:@"(null)"].length > 0) {
        NSMutableString *mString = [NSMutableString stringWithFormat:@"%@",string];
        
        [mString deleteCharactersInRange:[mString rangeOfString:@"(null)"]];
        if (mString.length == 0 || [mString textIsAllSpace]) {
            return NO;
        }
    }
    
    
    if ([string rangeOfString:@"null"].length > 0) {
        NSMutableString *mString = [NSMutableString stringWithFormat:@"%@",string];

        [mString deleteCharactersInRange:[mString rangeOfString:@"null"]];
        if (mString.length == 0 || [mString textIsAllSpace]) {
            return NO;
        }
    }
    
    if ([string rangeOfString:@"NULL"].length > 0) {
        NSMutableString *mString = [NSMutableString stringWithFormat:@"%@",string];
        
        [mString deleteCharactersInRange:[mString rangeOfString:@"NULL"]];
        if (mString.length == 0 || [mString textIsAllSpace]) {
            return NO;
        }
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    if ([string textIsAllSpace]) {
        return NO;
    }
    
    return YES;
}

+ (NSString *)judgmentString:(NSString *)string {
    if ([self isHaveValue:string]) {
        return string;
    }
    return @"";
}



+ (BOOL)isContainsEmoji:(NSString *)originString {
    NSString *string = [NSString stringWithFormat:@"%@",originString];
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}


- (BOOL)isNumber{
    NSString *regex = @"^[0-9]*$";
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

- (BOOL)isChinese{
    NSString *regex = @"^[\u4E00-\u9FA5]*$";
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

+ (BOOL)judgeNameLegal:(NSString *)pass{
    BOOL result = false;
    // 判断长度大于8位后再接着判断是否同时包含数字和字符
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{0,50}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    return result;
}

- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


- (BOOL)isMobile{
    
    if (self.length != 11) {
        return NO;
    }
    
    if (!self.isNumber) {
        return NO;
    }
    
    if (![[self substringToIndex:1] isEqualToString:@"1"]) {
        return NO;
    }
    
    return YES;
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"/^0?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/";
    //    NSString *phoneRegex = @"^1[0-9]{10}$";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    //    if (mobile.length > 0) {
    //        return YES;
    //    }
    //    return NO;
}


- (BOOL)isIDNumber{
    
    if (self.length == 18) {
  
        
        if ([self substringToIndex:17].isNumber) {
            if ([self substringFromIndex:17].isNumber || [[self substringFromIndex:17] isEqualToString:@"x"] || [[self substringFromIndex:17] isEqualToString:@"X"]) {
                return YES;
            }
        }
    }
    
    
    
    return NO;
}

//+ (CGFloat)decimalCalculation:(NSNumber *)firstObj, ... NS_REQUIRES_NIL_TERMINATION{
//
//    NSMutableArray* arrays = [NSMutableArray array];
//    //VA_LIST 是在C语言中解决变参问题的一组宏
//    va_list argList;
//
//    if (firstObj) {
//        [arrays addObject:firstObj];
//        // VA_START宏，获取可变参数列表的第一个参数的地址,在这里是获取firstObj的内存地址,这时argList的指针 指向firstObj
//        va_start(argList, firstObj);
//        // 临时指针变量
//        id temp;
//        // VA_ARG宏，获取可变参数的当前参数，返回指定类型并将指针指向下一参数
//        // 首先 argList的内存地址指向的fristObj将对应储存的值取出,如果不为nil则判断为真,将取出的值房在数组中,并且将指针指向下一个参数,这样每次循环argList所代表的指针偏移量就不断下移直到取出nil
//        while ((temp = va_arg(argList, id))) {
//            [arrays addObject:temp];
//            NSLog(@"%@",arrays);
//        }
//
//    }
//    // 清空列表
//    va_end(argList);
////    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",contentModel.discount]];
////    decNumber = [decNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10"]];
//
//
//    NSDecimalNumber *allNumber = [NSDecimalNumber decimalNumberWithString:@"1.0"];
//    for (NSNumber *number in arrays){
//        allNumber = [allNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",[number doubleValue]]]];
//    }
//
//    return [allNumber doubleValue];
//
//}




@end
