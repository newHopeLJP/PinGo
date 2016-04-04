//
//  VisitorRecord.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/20.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "VisitorRecord.h"
#import "URLs.h"

@interface VisitorRecord()
@property (nonatomic) NSURLSession * session;
@end

@implementation VisitorRecord

-(instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        if (dict.count>0) {
            _user=[[User alloc]initWithDict:dict];
            _visitTime =dict[@"visitTime"];
        }
    }
    return self;
}


+(void)fetchVisitorRecordCompletion:(VisitorRecordCompletion)completion{
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    
    NSString *requestString=[NSString stringWithFormat:@"%@?%@&baseSortValue=0&%@&%@&requestCnt=50&%@&%@&%@&%@&order=1&%@&%@&%@&%@",kVISITOR_RECORD_URL,kAPI_USERID,kAPI_VERSION,kAPI_SYSVERSION,kAPI_PRODUCTID,kAPI_SESSION_TOKEN,kAPI_CHANNELID,kAPI_OS,kAPI_VERSION_CODE,kAPI_PEERID,kAPI_SESSION_ID,kAPI_KEY];
    NSURL *url=[NSURL URLWithString:requestString];
    NSURLRequest * req=[NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:req
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       NSDictionary *jsonObjet=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                       NSDictionary *visitorData=jsonObjet[@"data"];
                                                       NSMutableArray *visitorRecordList=[[NSMutableArray alloc]init];
                                                       for (NSDictionary *dict in visitorData[@"visitUserInfoList"]){
                                                           [visitorRecordList addObject:[[VisitorRecord alloc] initWithDict:dict]];
                                                       }
                                                  
                                                       completion(visitorRecordList);

                                                       if (error) {
                                                           NSLog(@"%@",[error description]);
                                                       }
                                                       
                                                   }];
    [dataTask resume];
    
}
@end
