//
//  NSDate+Extension.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/21.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+(NSDateFormatter *)formatterWithStyle:(NSString *)style;


/**
 根据时间戳返回日期
 
 - parameter stamp: 时间戳字符串
 
 - returns: 日期
 */
+(NSDate *)dateWithTimeStamp:(NSString *)stamp;

/**
 根据日期返回字符串格式
 
 - returns: 日期字符串
 */
-(NSString *)stringWithStyle:(NSString *)style;

/**
 根据时间判断是否是今年
 
 - returns: ture of false
 */
-(BOOL)isThisYear;

/**
 根据时间判断是否是今天
 
 - returns: true of false
 */
-(BOOL)isToday;


/**
 根据时间判断是否是昨天
 
 - returns: true of false
 */
-(BOOL)isYestoday;


-(NSDateComponents *)componentsDeltaWithNow;




@end
