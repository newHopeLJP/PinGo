//
//  UIStoryboard+Extension.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Extension)

/**
 根据stroyboard名称返回初始控制器
 
 - parameter name: 名称
 
 - returns: 初始控制器
 */
+(UIViewController *)initialViewController:(NSString *)name;
    

/**
 根据stroyboard名称和标示符返回对应的控制器
 
 - parameter name:       名称
 - parameter identifier: 标示符
 
 - returns: 对应的控制器
 */
+(UIViewController *)initialViewControllerWithName:(NSString *)name andIdentifier:(NSString *) identifier;

@end
