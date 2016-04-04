//
//  User.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/20.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "User.h"
#import "NSString+Age.h"


@implementation User

-(instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        if (dict.count>0) {
            for (NSString *key in dict) {
                if ([key isEqualToString:@"famousTypeInfo"]) {
                    _famousTypeInfo=[[FamousType alloc] initWithDict:dict[key]];
                    continue;
                }
                [self setValue:dict[key] forKey:key];
            }
        }
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSUInteger)age{
    return [self.birthday ageWithStyle:@"yyyy-MM-dd"];
}

-(NSString *)constellation{
    return [self.birthday constellationWithStyle:@"yyyy-MM-dd"];
}



@end
