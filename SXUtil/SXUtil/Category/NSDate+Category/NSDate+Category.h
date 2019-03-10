//
//  NSDate+Category.h
//  SXUtil
//
//  Created by zsx on 2019/3/10.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

/**
 NSDate转时间戳

 @return 时间戳
 */
-(NSTimeInterval)toInterval;

/**
 时间戳转NSDate

 @param interval 时间戳
 @return NSDate
 */
+(NSDate *)toDateFromInterval:(NSTimeInterval)interval;

/**
 NSDate转格式化时间字符串

 @param formatterType 0:"yyyy-MM-dd HH:mm",1:"yyyy-MM-dd",2:"HH:mm",3:"yyyy-MM-dd HH:mm:ss"
 @return 格式化时间字符串
 */
-(NSString *)toFormatterString:(int)formatterType;

/**
 格式化字符串转NSDate

 @param formatterString 格式化字符串
 @param type 0:"yyyy-MM-dd HH:mm",1:"yyyy-MM-dd",2:"HH:mm",3:"yyyy-MM-dd HH:mm:ss"
 @return NSDate
 */
+(NSDate *)toDateFromFormatterString:(NSString *)formatterString withType:(int)type;

/**
 插入一段时间戳

 @param interval 时间戳，单位秒
 @return nNSDate
 */
-(NSDate *)insertInterval:(NSTimeInterval)interval;
@end

