//
//  SubjectInfo.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/30.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SubjectInfo,User;

typedef void(^SubjectInfoListCompletion)(NSArray<NSArray<SubjectInfo *> *> *subjectInfoListArray);
typedef void(^SubjectInfoCompletion)(SubjectInfo *subjectInfo,NSArray<User *> *managerUserList);

@interface SubjectInfo : NSObject

@property (nonatomic,copy) NSString *subjectID;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *posterUrl;
@property (nonatomic,assign) NSInteger topicCnt;
@property (nonatomic,assign) NSInteger userCnt;
@property (nonatomic,assign) NSInteger isFavo;
@property (nonatomic,assign) NSInteger incTopicCnt;
@property (nonatomic,assign) NSInteger isActivity;
@property (nonatomic,copy) NSString *activityTitle;
@property (nonatomic,copy) NSString *activityUrl;
@property (nonatomic,assign) NSInteger activityUrlType;
@property (nonatomic,assign) NSInteger isOfficial;
@property (nonatomic,assign) NSInteger readCnt;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (void)fetchSubjectInfoList:(SubjectInfoListCompletion)completion;

+ (void)fetchSubjectInfoWithSubjectID:(NSInteger)subjectID completion:(SubjectInfoCompletion) completion;

@end
