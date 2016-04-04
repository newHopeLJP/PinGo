//
//  TabBarController.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/13.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TabBarController.h"
#import "TabBar.h"
#import "UIStoryboard+Extension.h"

@interface TabBarController ()<TabBarDelegate>

@property (weak, nonatomic) IBOutlet TabBar *aTabBar;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aTabBar.aDelegate=self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self removeSystemTabbarSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self removeSystemTabbarSubviews];
}

-(void)removeSystemTabbarSubviews{
    for (id v in self.tabBar.subviews) {
        if ([v superclass]==UIControl.self) {
            [v removeFromSuperview];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tabBar:(TabBar *)tabBar didClickButton:(NSInteger)index{
    if (index == 2){
        UIViewController *showVC = [UIStoryboard initialViewController:@"Show"];
        [self presentViewController:showVC animated:YES completion:nil];
        return;
    }else if(index >= 2) {
        index -= 1;
    }
    self.selectedIndex = index;

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
