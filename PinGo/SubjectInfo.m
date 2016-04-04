//
//  SubjectInfo.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/30.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "SubjectInfo.h"
#import "User.h"

@implementation SubjectInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        if (dict.count>0) {
            
            for (NSString *keyName in dict) {
                if ([keyName isEqualToString:(@"imageUrl2")]) {
                    [self setValue:dict[keyName] forKey:@"imageUrl"];
                    continue;
                }
                if ([keyName isEqualToString:@"imageUrl"]) {
                    continue;
                }
                [self setValue:dict[keyName] forKey:keyName];
            }
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (void)fetchSubjectInfoWithSubjectID:(NSInteger)subjectID completion:(SubjectInfoCompletion)completion{
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    
    NSString *urlStr=@"http://api.impingo.me/subject/getSubject?peerID=6EDEE890B4E5&os=ios&userID=1404034&sessionToken=cce76093c4&channelID=App%20Store&productID=com.joyodream.pingo&version=3.7&sysVersion=9.2.1&subjectID=343887&sessionID=e5c8c1b3e8153e78ab&versionCode=15&key=FD86BF9762791F118EE6E5CDB501B756";
    NSURL *url=[NSURL URLWithString:urlStr];
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dictOrigin=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dictData=dictOrigin[@"data"];
        
        NSDictionary *dict0=dictData[@"subjectInfo"];
        if (dict0) {
            NSMutableArray *managerUserList=[NSMutableArray new];
            for (NSDictionary *dict1 in dict0[@"managerUserInfoList"]) {
                User *user=[[User alloc]initWithDict:dict1];
                [managerUserList addObject:user];
            }
            completion([[SubjectInfo alloc] initWithDict:dict0],managerUserList);
        }else{
            completion(nil,nil);
        }
        
        if (error) {
            NSLog(@"%@",[error description]);
        }
        
    }];
    
    [dataTask resume];
    
    
    }

+ (void)fetchSubjectInfoList:(SubjectInfoListCompletion)completion{
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    
    NSString *urlStr=@"http://api.impingo.me/subject/listSubjectCategory?peerID=6EDEE890B4E5&os=ios&userID=1404034&sessionToken=cce76093c4&channelID=App%20Store&productID=com.joyodream.pingo&version=3.7&sysVersion=9.2.1&sessionID=e5c8c1b3e8153e78ab&versionCode=15&key=3E21B8BF085CC3287E84A534EACA9DD7";
    
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //TODO:数据为空以及请求失败处理
        
        NSDictionary *dictOrigin=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *realData=dictOrigin[@"data"];
        NSMutableArray *subjectInfoListArray=[NSMutableArray new];
        for (NSDictionary *dict0 in realData[@"subjectCategoryList"]) {
            NSMutableArray *subjectInfoList=[NSMutableArray new];
            for (NSDictionary *dict in dict0[@"subjectInfoList"]) {
                SubjectInfo *subjectInfo=[[SubjectInfo alloc]initWithDict:dict];
                [subjectInfoList addObject:subjectInfo];
            }
            [subjectInfoListArray addObject:subjectInfoList];
            
        }
        completion(subjectInfoListArray);
        
        if (error) {
            NSLog(@"%@",[error description]);
        }
        
    }];
    [dataTask resume];

}

@end
