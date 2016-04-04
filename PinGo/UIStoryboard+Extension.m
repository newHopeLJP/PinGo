//
//  UIStoryboard+Extension.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "UIStoryboard+Extension.h"

@implementation UIStoryboard (Extension)

+(UIViewController *)initialViewController:(NSString *)name{
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:name bundle:nil];
    return [sb instantiateInitialViewController];
}

+(UIViewController *)initialViewControllerWithName:(NSString *)name andIdentifier:(NSString *)identifier{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:name bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}

@end
