//
//  ProfileHomeController.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/22.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "ProfileHomeController.h"
#import "IBInspectableView.h"

@interface ProfileHomeController ()
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet IBInspectableImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation ProfileHomeController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.headerView.backgroundColor=kAppearanceColor;
    self.userNameLabel.text=@"wanghong";
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end
