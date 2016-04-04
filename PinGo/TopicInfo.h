//
//  TopicInfo.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/27.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "SimpleSubjectInfo.h"

//isEnd:是否有更多数据 sortValue:下次获取更多需要的字段
typedef void (^TopicInfoCompletion)(BOOL isEnd,NSString *sortValue,NSArray *topicInfoList);
typedef void (^SquareTopicInfoCompletion)(NSArray *topicInfoList);


@interface TopicInfo : NSObject

@property (nonatomic,copy) NSString *topicID;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *resUrl;
@property (nonatomic,copy) NSString *replyTopicID;
@property (nonatomic,copy) NSString *replyUserID;
@property (nonatomic,copy) NSString *stickerID;
@property (nonatomic,copy) NSString *paperID;
@property (nonatomic,copy) NSString *subjectID;
@property (nonatomic,copy) NSString *subjectTitle;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,strong) User *userInfo;
@property (nonatomic,assign) NSInteger heat;
@property (nonatomic,assign) NSInteger praiseCnt;
@property (nonatomic,assign) NSInteger duration;
@property (nonatomic,copy) NSString *pubTime;
@property (nonatomic,copy) NSString *recvTime;
@property (nonatomic,assign) NSInteger isDiscard;
@property (nonatomic,strong) SimpleSubjectInfo *simpleSubjectInfoList;
@property (nonatomic,copy) NSString *commentCnt;
@property (nonatomic,copy) NSString *beauty;
@property (nonatomic,assign) NSInteger isTop;


- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 获取首页数据列表
 
 - parameter isFollow:      精选 or 关注
 - parameter order:         1 or 0  1:获取最新 0:获取更多
 - parameter sortValue:     获取更多需要的字段
 */
+ (void)fetchTopicInfoListWithIsFollow:(BOOL)isFollow order:(NSInteger)order andSortValue:(NSString *)sortValue completion:(TopicInfoCompletion)completion;

+ (void)fetchTopicInfoListCompletion:(TopicInfoCompletion)completion;

+ (void)fetchSubjectTopicListWithSubjectID:(NSInteger)subjectID completion:(TopicInfoCompletion)completion;

@end
