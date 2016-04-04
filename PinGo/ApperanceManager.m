//
//  Initialization.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/13.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "ApperanceManager.h"
#import "UIImage+ColorImage.h"


@implementation ApperanceManager
+(void)initializationAppearance:(UIWindow *)window{
    window.backgroundColor=[UIColor whiteColor];
    UINavigationBar *navBar=[UINavigationBar appearance];
    CGSize navBarSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,64);
    UIImage *navBarImage=[UIImage imageWithColor:kAppearanceColor andSize:navBarSize];
    [navBar setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    navBar.shadowImage=[[UIImage alloc]init];
    navBar.tintColor=[UIColor whiteColor];
    navBar.titleTextAttributes=@{NSFontAttributeName:kNavigationBarFont,
                                 NSForegroundColorAttributeName:[UIColor whiteColor]};
    [UITabBar appearance].translucent=NO;

}
@end
