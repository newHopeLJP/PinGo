//
//  NavigationController.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/13.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationBar.translucent=NO;
    if (self.interactivePopGestureRecognizer) {
        self.interactivePopGestureRecognizer.delegate=nil;
    }
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_red"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
        
    }
    [super pushViewController:viewController  animated:true];
}

-(void)backButtonClick{
    [self popViewControllerAnimated:YES];
}

@end
