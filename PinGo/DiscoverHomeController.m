//
//  DiscoverHomeController.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/2.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "DiscoverHomeController.h"
#import "TopMenu.h"

@interface DiscoverHomeController ()<TopMenuDelegate>
@property (weak, nonatomic) IBOutlet UIView *topicContainerView;
@property (weak, nonatomic) IBOutlet UIView *discoverContainerView;

@property (strong,nonatomic) TopMenu *topMenu;

@end

@implementation DiscoverHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView=self.topMenu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TopMenu *)topMenu{
    if (!_topMenu) {
        _topMenu=[TopMenu loadFromNib];
        _topMenu.showText=@[@"话题",@"广场"];
        _topMenu.delegate=self;
    }
    return _topMenu;
}

- (void)topMenu:(TopMenu *)topeMenu didClickButton:(NSUInteger)index{
    self.discoverContainerView.hidden=index==0?NO:YES;
    self.topicContainerView.hidden=!self.discoverContainerView.hidden;
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
