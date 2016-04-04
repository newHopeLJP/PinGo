//
//  SimpleSubjectInfo.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/25.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "SimpleSubjectInfo.h"

@implementation SimpleSubjectInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        if (dict.count>0) {
            [self setValuesForKeysWithDictionary:dict];
        }
    }
    return self;
}

@end
