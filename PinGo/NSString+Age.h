//
//  NSString+Age.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Age)

+(CGSize)sizeWithText:(NSString *)text withFont:(UIFont*)font andMaxSize:(CGSize)maxSize;

/**
 根据日期字符串计算年龄
 
 - parameter style: 日期字符串格式
 
 - returns: 年龄
 */
-(NSInteger)ageWithStyle:(NSString *) style;


/**
 根据日期字符串计算星座
 
 - parameter style: 日期字符串格式
 
 - returns: 星座
 */
-(NSString *)constellationWithStyle:(NSString *)style;


/**
 根据时间戳转换显示字符串
 
 - parameter style: 要转换成的格式
 
 - returns: 格式化后的字符串
 */
-(NSString*)dateStringToStyle:(NSString*)style;

@end
