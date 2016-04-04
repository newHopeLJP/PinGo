//
//  DiscoverHeaderView.h
//  PinGo
//
//  Created by 新新希冀 on 16/4/2.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Banner.h"

@class DiscoverHeaderView;
@protocol DiscoverHeaderViewDelegate <NSObject>

/**
 点击了某个按钮
 
 - parameter headerView:   view
 - parameter button: 按钮
 */
- (void)discoverHeaderView:(DiscoverHeaderView *)discoverHeaderView  didClickButton:(UIButton *)button;

@end

@interface DiscoverHeaderView : UIView

@property (nonatomic,copy) NSArray<Banner *> *bannerList;

- (void)scrollImage;
- (void)stopScrollImage;
+ (DiscoverHeaderView *)loadFromNib;

@end
