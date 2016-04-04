//
//  FamousType.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/20.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "FamousType.h"

@implementation FamousType
-(instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        if (dict.count>0) {
            for (NSString *key in dict) {
                if ([key isEqual:@"typeID"]) {
                    NSNumber *num=[NSNumber numberWithInteger:[dict[key] integerValue]];
                    [self setValue:num forKey:key];
                }else{
                    [self setValue:dict[key] forKey:key];
                }
            }
        }
    }
    return self;
}
@end
