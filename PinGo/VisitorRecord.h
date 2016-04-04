//
//  VisitorRecord.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/20.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef void (^VisitorRecordCompletion) (NSArray *);

@interface VisitorRecord : NSObject

@property (nonatomic,strong) User *user;
@property (nonatomic,copy) NSString *visitTime;

-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 获取访客记录列表
 
 - parameter completion: 列表
 */
+(void)fetchVisitorRecordCompletion:(VisitorRecordCompletion)completion;

@end
