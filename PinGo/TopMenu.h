//
//  TopMenu.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/13.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopMenu;
@protocol TopMenuDelegate <NSObject>

/**
 点击了某个按钮
 
 - parameter topMenu: topMenu
 - parameter index:   按钮index
 */
-(void)topMenu:(nonnull TopMenu*)topeMenu didClickButton:(NSUInteger)index;

@end



@interface TopMenu : UIView
@property (nonatomic,weak)id<TopMenuDelegate> delegate;
@property (nonatomic,copy,nonnull)  NSArray<NSString *> *showText;
@property (nonatomic,assign) NSUInteger toIndex;

+(nullable TopMenu*)loadFromNib;
@end
