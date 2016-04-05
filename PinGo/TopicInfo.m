//
//  TopicInfo.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/27.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TopicInfo.h"
#import "URLs.h"

@implementation TopicInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        if (dict.count>0) {
            for (NSString* key in dict) {
                if ([key isEqualToString:@"userInfo"]) {
                    _userInfo=[[User alloc]initWithDict:dict[key]];
                    continue;
                }else if([key isEqualToString:@"simpleSubjectInfoList"]){
                    NSArray *temp=dict[key];
                    if (temp&&temp.count>0) {
                        _simpleSubjectInfoList=[[SimpleSubjectInfo alloc]initWithDict:temp[0]];
                    }
                    
                    continue;
                }
                [self setValue:dict[key] forKey:key];
                }
            }
        }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (void)fetchTopicInfoListCompletion:(TopicInfoCompletion)completion{
    [self fetchTopicInfoListWithIsFollow:NO order:1 andSortValue:@"0" completion:completion];
}

/**
 获取首页数据列表
 
 - parameter isFollow:      精选 or 关注
 - parameter order:         1 or 0  1:获取最新 0:获取更多
 - parameter sortValue:     获取更多需要的字段
 */
+(void)fetchTopicInfoListWithIsFollow:(BOOL)isFollow order:(NSInteger)order andSortValue:(NSString *)sortValue completion:(TopicInfoCompletion)completion{
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    
    NSString *baseUrl=isFollow?kHOME_FOLLOW_TOPIC_LIST_URL:kHOME_TOPIC_LIST_URL;
    NSMutableString *urlStr=[[NSMutableString alloc] init];
    [urlStr appendFormat:@"%@?%@&baseSortValue=%@&%@",baseUrl,kAPI_USERID,sortValue,kAPI_VERSION];
    [urlStr appendFormat:@"&%@&requestCnt=50&%@&%@&%@&%@&order=%ld&%@",kAPI_SYSVERSION,kAPI_PRODUCTID,kAPI_SESSION_TOKEN,kAPI_CHANNELID,kAPI_OS,(long)order,kAPI_VERSION_CODE];
    [urlStr appendFormat:@"&%@&%@&%@",kAPI_PEERID,kAPI_SESSION_ID,kAPI_KEY];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
         
        NSDictionary *jsonObjet=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *topicInfoData=jsonObjet[@"data"];
        NSMutableArray *topicInfoList=[[NSMutableArray alloc]init];
        for (NSDictionary *dict in topicInfoData[@"topicInfoList"]){
            TopicInfo *topic=[[TopicInfo alloc]initWithDict:dict];
            [topicInfoList addObject:topic];
        }
        BOOL isEnd=[topicInfoData[@"isEnd"] integerValue]==1;
        NSString *tempSortValue=topicInfoData[@"sortValue"];
        if (!tempSortValue) {
            tempSortValue=@"0";
        }
        completion(isEnd,tempSortValue,topicInfoList);
        
        }else{
            NSLog(@"%@",[error description]);
            completion(YES,@"0",nil);
        }

        
    }];
    [dataTask resume];
    
}

+(void)fetchSubjectTopicListWithSubjectID:(NSInteger)subjectID completion:(TopicInfoCompletion)completion{
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    
    NSString *urlStr = @"http://api.impingo.me/subject/listSubjectTopic?userID=1404034&baseSortValue=0&version=3.7&sysVersion=9.2.1&requestCnt=20&productID=com.joyodream.pingo&sessionToken=cce76093c4&listType=1&channelID=App%20Store&os=ios&subjectID=343887&versionCode=15&peerID=6EDEE890B4E5&sessionID=e5c8c1b3e8153e78ab&key=B5CADA9605B2C4AADF5069F01CDB7D1C";
    
    
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
        NSDictionary *jsonObjet=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *topicInfoData=jsonObjet[@"data"];
        NSMutableArray *topicInfoList=[[NSMutableArray alloc]init];
        for (NSDictionary *dict in topicInfoData[@"topicInfoList"]){
            TopicInfo *topic=[[TopicInfo alloc]initWithDict:dict];
            [topicInfoList addObject:topic];
        }
        BOOL isEnd=[topicInfoData[@"isEnd"] integerValue]==1;
        NSString *tempSortValue=topicInfoData[@"sortValue"];
        if (!tempSortValue) {
            tempSortValue=@"0";
        }
        completion(isEnd,tempSortValue,topicInfoList);
        
         }else{
            NSLog(@"%@",[error description]);
            completion(YES,@"0",nil);
        }
        
        
    }];
    [dataTask resume];
}

@end

