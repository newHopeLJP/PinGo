//
//  TabBar.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/13.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBar;

@protocol TabBarDelegate <NSObject>

/**
 点击了某个按钮
 
 - parameter tabBar: tabBar
 - parameter index:  按钮index
 */
-(void)tabBar:(TabBar*)tabBar didClickButton:(NSInteger) index;

@end




@interface TabBar : UITabBar

@property (nonatomic,weak) id<TabBarDelegate> aDelegate;

@end
