//
//  FamousType.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/20.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamousType : NSObject

@property (nonatomic,assign) NSUInteger typeID;
@property (nonatomic,copy) NSString *typeName;
@property (nonatomic,assign) NSUInteger isPrimary;
@property (nonatomic,assign) NSUInteger isOfficial;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
