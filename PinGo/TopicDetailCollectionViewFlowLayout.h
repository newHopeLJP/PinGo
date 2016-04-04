//
//  TopicDetailCollectionViewFlowLayout.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/30.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicInfo.h"

@interface TopicDetailCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,strong) NSArray<TopicInfo *> *topicInfoList;

@end
