//
//  NSString+Age.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "NSString+Age.h"
#import "NSDate+Extension.h"

@implementation NSString (Age)

+(CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font andMaxSize:(CGSize)maxSize{
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

-(NSString*)constellationWithStyle:(NSString *)style{
    if ([self containsString:@"-"]) {
        NSArray<NSString *> *dates=[self componentsSeparatedByString:@"-"];
        if (dates.count==3) {
            return [self constellationWithMonth:[dates[1] integerValue] andDay:[dates[2] integerValue]];
        }
    }
    return nil;
}

-(NSInteger)ageWithStyle:(NSString *)style{
    
    NSDate *date=[[NSDate formatterWithStyle:style] dateFromString:self];
    NSTimeInterval interval=[date timeIntervalSinceNow];
    return abs((int)trunc((interval/(60*60*24))/265));
}

-(NSString *)constellationWithMonth:(NSInteger)month andDay:(NSInteger)day{
    NSString *astroStr=@"摩羯座水瓶座双鱼座白羊座金牛座双子座巨蟹座狮子座处女座天秤座天蝎座射手座摩羯座";
    NSString *astroFormat=@"102123444543";
    NSInteger d=[[astroFormat substringWithRange:NSMakeRange(month-1, 1)] integerValue];
    NSInteger delta=day<(d-(-19))?1:0;
    NSRange range = NSMakeRange(month * 3 -delta* 3, 3);
    return [astroStr substringWithRange:range];
}

-(NSString *)dateStringToStyle:(NSString *)style{
    NSDate *date=[NSDate dateWithTimeStamp:self];
    NSDateComponents *components=[date componentsDeltaWithNow];
    if (components.day<=5) {
        if (components.day<1) {
            return [NSString stringWithFormat:@"%ld小时前",(long)components.hour];
        }else{
            return [NSString stringWithFormat:@"%ld天前",(long)components.day];
        }
    }else{
        return [date stringWithStyle:style];
    }
    return nil;
}


@end
