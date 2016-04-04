//
//  TopicController.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/1.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TopicController.h"
#import "TopicHeaderView.h"
#import "TopicInfo.h"
#import "TopicCell.h"

#define kCellReuseIdentifier @"topicCell"

@interface TopicController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *tableViewHeaderView;

@property (strong,nonatomic) TopicHeaderView *headerView;
@property (strong,nonatomic) NSArray *headerViewTextList;
@property (strong,nonatomic) NSArray<TopicInfo *> *dataList;

@end

@implementation TopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.headerView=[TopicHeaderView loadFromNib];
    [self.tableViewHeaderView addSubview:self.headerView];
    self.tableView.rowHeight=170.0;
    
    WS(weakSelf);
    
    [Banner fetchBannerListWithBannerQueryType:Square completion:^(NSArray<Banner *> *bannerList) {
        if (bannerList) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.headerView.bannerList=bannerList;
            });
        }
    }];
    
    [TopicInfo fetchTopicInfoListCompletion:^(BOOL isEnd, NSString *sortValue, NSArray *topicInfoList) {
        weakSelf.dataList=topicInfoList;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.headerView) {
        self.headerView.frame=self.tableViewHeaderView.bounds;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: lazy loading
- (NSArray *)headerViewTextList{
    if (!_headerViewTextList) {
        _headerViewTextList=@[@"热门照片",@"附近照片",@"最近照片"];
    }
    return _headerViewTextList;
}

- (NSArray<TopicInfo *> *)dataList{
    if (!_dataList) {
        _dataList=[NSArray new];
    }
    return _dataList;
}

#pragma mark - Tableview Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count>0?self.headerViewTextList.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicCell *cell=[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.headerViewText=self.headerViewTextList[indexPath.section];
    
    // 将所有的数据分成x份 x = headerViewTextList.count
    NSInteger count=self.dataList.count;
    NSInteger num=count/self.headerViewTextList.count;
    
    NSInteger startIndex=indexPath.section*num;
//    NSInteger endIndex=startIndex+num-1;
//    NSRange range=NSMakeRange(startIndex, num);
    cell.phontoInfoList=[self.dataList subarrayWithRange:NSMakeRange(startIndex, num)];
    return cell;
}

#pragma mark - Tableview Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
