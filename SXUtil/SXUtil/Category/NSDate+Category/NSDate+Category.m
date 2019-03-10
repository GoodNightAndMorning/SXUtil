//
//  NSDate+Category.m
//  SXUtil
//
//  Created by zsx on 2019/3/10.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)
/**
 NSDate转时间戳
 
 @return 时间戳
 */
-(NSTimeInterval)toInterval {
    return [self timeIntervalSince1970];
}
/**
 时间戳转NSDate
 
 @param interval 时间戳
 @return NSDate
 */
+(NSDate *)toDateFromInterval:(NSTimeInterval)interval {
    return [NSDate dateWithTimeIntervalSince1970:interval];
}
/**
 NSDate转格式化时间字符串
 
 @param formatterType 0:"yyyy-MM-dd HH:mm",1:"yyyy-MM-dd",2:"HH:mm",3:"yyyy-MM-dd HH:mm:ss"
 @return 格式化时间字符串
 */
-(NSString *)toFormatterString:(int)formatterType {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:[NSDate getFormatter:formatterType]];
    NSString *formatterStr = [format stringFromDate:self];
    return formatterStr;
}
/**
 格式化字符串转NSDate
 
 @param formatterString 格式化字符串
 @param type 0:"yyyy-MM-dd HH:mm",1:"yyyy-MM-dd",2:"HH:mm",3:"yyyy-MM-dd HH:mm:ss"
 @return NSDate
 */
+(NSDate *)toDateFromFormatterString:(NSString *)formatterString withType:(int)type {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:[NSDate getFormatter:type]];
    NSDate *date = [format dateFromString:formatterString];
    
    return date;
}
/**
 插入一段时间戳
 
 @param interval 时间戳，单位秒
 @return nNSDate
 */
-(NSDate *)insertInterval:(NSTimeInterval)interval {
    
    NSDate *date = [NSDate dateWithTimeInterval:interval sinceDate:self];
    
    return date;
}
+(NSString *)getFormatter:(int)type {
    NSString *formatter = @"";
    switch (type) {
        case 0:
            formatter = @"yyyy-MM-dd HH:mm";
            break;
        case 1:
            formatter = @"yyyy-MM-dd";
            break;
        case 2:
            formatter = @"HH:mm";
            break;
        case 3:
            formatter = @"yyyy-MM-dd HH:mm:ss";
            break;
        default:
            break;
    }
    
    return formatter;
}
@end
