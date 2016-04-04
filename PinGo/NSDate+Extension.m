//
//  NSDate+Extension.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/21.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+(NSDateFormatter *)formatterWithStyle:(NSString *)style{
    NSDateFormatter *formatter=kDateFormatter;
    formatter.locale=[NSLocale currentLocale];
    formatter.dateFormat=style;
    return formatter;
}



/**
 根据时间戳返回日期
 
 - parameter stamp: 时间戳字符串
 
 - returns: 日期
 */
+(NSDate *)dateWithTimeStamp:(NSString *)stamp{
    NSTimeInterval interval=[stamp doubleValue];
    return  [NSDate dateWithTimeIntervalSince1970:interval/1000.0];
}


/**
 根据日期返回字符串格式
 
 - returns: 日期字符串
 */
-(NSString *)stringWithStyle:(NSString *)style{
    NSDateFormatter *formatter=[NSDate formatterWithStyle:style];
    return [formatter stringFromDate:self];
}


/**
 根据时间判断是否是今年
 
 - returns: ture of false
 */
-(BOOL)isThisYear{
    NSCalendar *calendar=kCalendar;
    NSCalendarUnit unit=NSCalendarUnitYear;
    NSDateComponents *nowCmps=[calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *dCmps=[calendar components:unit fromDate:self];
    return nowCmps.year==dCmps.year;
}


/**
 根据时间判断是否是今天
 
 - returns: true of false
 */
-(BOOL)isToday{
    NSCalendar *calendar=kCalendar;
    NSCalendarUnit unit=NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents *nowCmps=[calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *dCmps=[calendar components:unit fromDate:self];
    return nowCmps.day==dCmps.day&&nowCmps.month==dCmps.month&&nowCmps.year==dCmps.year;
}


/**
 根据时间判断是否是昨天
 
 - returns: true of false
 */
-(BOOL)isYestoday{
    return [kCalendar components:NSCalendarUnitDay fromDate:[self dateFormat] toDate:[[NSDate date] dateFormat] options:NSCalendarMatchStrictly].day==1;
}

-(NSDate *)dateFormat{
    NSDateFormatter *formatter=[NSDate formatterWithStyle:@"yyyy-MM-dd"];
    NSString *dateStr=[formatter stringFromDate:self];
    return [formatter dateFromString:dateStr];
}

-(NSDateComponents *)componentsDeltaWithNow{
    return [kCalendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self toDate:[NSDate date] options:NSCalendarMatchStrictly];
}


@end
