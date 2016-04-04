//
//  TopicDetailHeaderView.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/30.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectInfo.h"
#import "User.h"


@interface TopicDetailHeaderView : UIView

@property (nonatomic,strong) SubjectInfo *subjectInfo;
@property (nonatomic,copy) NSArray<User *> *users;

+ (TopicDetailHeaderView *)loadFromNib;

@end
