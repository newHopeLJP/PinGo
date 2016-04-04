//
//  Banner.h
//  PinGo
//
//  Created by 新新希冀 on 16/4/1.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,BannerQueryType){
    Subject,
    Square
};

@class Banner;
typedef void(^BannerCompletion)(NSArray<Banner *> *bannerList);


@interface Banner : NSObject

@property (nonatomic,copy) NSString *bannerID;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *jumpUrl;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (void)fetchBannerListWithBannerQueryType:(BannerQueryType)type completion:(BannerCompletion)completion;

@end
