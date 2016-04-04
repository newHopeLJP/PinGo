//
//  User.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/20.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamousType.h"

@interface User : NSObject
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *headUrl;
@property (nonatomic,assign) NSUInteger sex;
@property (nonatomic,assign) NSUInteger heat;
@property (nonatomic,assign) NSUInteger praiseCnt;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,assign,readonly) NSUInteger age;//年龄
@property (nonatomic,copy,readonly) NSString *constellation;//星座
@property (nonatomic,copy) NSString *signature;
@property (nonatomic,assign) BOOL isFamous;
@property (nonatomic,copy) NSString *onlineTime;
@property (nonatomic,assign) NSUInteger level;
@property (nonatomic,assign) BOOL isOfficial;
@property (nonatomic,strong) FamousType *famousTypeInfo;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
