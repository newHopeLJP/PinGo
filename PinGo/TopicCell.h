//
//  TopicCell.h
//  PinGo
//
//  Created by 新新希冀 on 16/4/2.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicInfo.h"

@interface TopicCell : UITableViewCell

@property (nonatomic,copy) NSString *headerViewText;
@property (nonatomic,copy) NSArray<TopicInfo *> *phontoInfoList;


@end
