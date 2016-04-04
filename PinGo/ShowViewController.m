//
//  ShowViewController.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/15.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)btnCloseClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
