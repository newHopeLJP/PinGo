//
//  TopicHeaderView.h
//  PinGo
//
//  Created by 新新希冀 on 16/4/1.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Banner.h"

@class TopicHeaderView;
@protocol TopicHeaderViewDelegate <NSObject>

/**
 点击了某个按钮
 
 - parameter headerView:   view
 - parameter button: 按钮
 */
- (void)topicHeaderView:(TopicHeaderView *)topicHeaderView didClickButton:(UIButton *)button;

@end


@interface TopicHeaderView : UIView

@property (nonatomic,copy) NSArray<Banner *> *bannerList;

- (void)scrollImage;
- (void)stopScrollImage;

+ (TopicHeaderView *)loadFromNib;


@end
