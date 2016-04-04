//
//  SimpleSubjectInfo.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/25.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleSubjectInfo : NSObject

@property (nonatomic,copy) NSString *subjectID;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *isOfficial;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
