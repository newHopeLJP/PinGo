//
//  Banner.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/1.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "Banner.h"

@implementation Banner

- (instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        if (dict.count>0) {
            [self setValuesForKeysWithDictionary:dict];
        }
    }
    return self;
}

+ (void)fetchBannerListWithBannerQueryType:(BannerQueryType)type completion:(BannerCompletion)completion{
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    
//    NSString *page=type==Subject ? @"subject":@"square";
//    NSString *key=type==Subject ? @"71E9EDFA30D38D95664AF805400324E1" : @"093A511B21DC549B1F31F700C8A0400C";
    
    NSString *subjectStr=@"http://api.impingo.me/banner/listBanner?peerID=6EDEE890B4E5&os=ios&userID=1404034&sessionToken=cce76093c4&channelID=App%20Store&productID=com.joyodream.pingo&version=3.7&sysVersion=9.2.1&page=subject&sessionID=e5c8c1b3e8153e78ab&versionCode=15&key=71E9EDFA30D38D95664AF805400324E1";
    
    NSString *squareStr=@"http://api.impingo.me/banner/listBanner?peerID=6EDEE890B4E5&os=ios&userID=1404034&sessionToken=cce76093c4&channelID=App%20Store&productID=com.joyodream.pingo&version=3.7&sysVersion=9.2.1&page=square&sessionID=e5c8c1b3e8153e78ab&versionCode=15&key=093A511B21DC549B1F31F700C8A0400C";
    
   
    NSString *urlStr=type==Subject?subjectStr:squareStr;
    NSURL *url=[NSURL URLWithString:urlStr];
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error:%@",[error description]);
            completion(nil);
        }else{
            NSDictionary *originDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dataDict=originDict[@"data"];
            NSMutableArray *bannerList=[NSMutableArray new];
            for (NSDictionary *dict in dataDict[@"bannerInfoList"]) {
                Banner *banner=[[Banner alloc]initWithDict:dict];
                [bannerList addObject:banner];
            }
            completion(bannerList);
        }
    }];
    
    [dataTask resume];
    
}

@end
