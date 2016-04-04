//
//  HomeCollectionViewCell.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/27.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicInfo.h"

typedef NS_ENUM(NSInteger,HomeCollectionViewCellButtonType){
    Tag=0,       //tag
    Chat,      //私聊
    Comment,   //评论
    Star       //star
};

@class HomeCollectionViewCell;
@protocol HomeCollectionViewCellDelegate <NSObject>

/**
 点击了某个按钮
 
 - parameter cell:     cell
 - parameter button:   按钮
 - parameter btnType:  按钮类型
 - parameter topiInfo: 数据模型
 */
- (void)homeCollectionViewCell:(HomeCollectionViewCell *)cell didClickButton:(UIButton *)button withButtonType:(HomeCollectionViewCellButtonType)btnType withTopicInfo:(TopicInfo*)topicInfo;
@end


@interface HomeCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) id<HomeCollectionViewCellDelegate> delegate;
@property (nonatomic,strong) TopicInfo *topicInfo;

@end
