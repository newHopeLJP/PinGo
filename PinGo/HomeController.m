//
//  HomeController.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/27.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "HomeController.h"
#import "TopMenu.h"
#import "LeftRefreshView.h"
#import "TopicInfo.h"
#import "HomeCollectionViewCell.h"
#import "TopicDetailController.h"

#define kCellReuseIdentifier @"homeCell"
#define kCellInsets     UIEdgeInsetsMake(15, 15, 15, 15)
#define kToTopicDetailSegue  @"home2TopicDetail"

@interface HomeController ()<TopMenuDelegate,HomeCollectionViewCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,assign) BOOL queryFollowData;
@property (nonatomic,copy) NSString *baseSortValue;

@property (strong,nonatomic) TopMenu *topMenu;
@property (strong,nonatomic) LeftRefreshView *leftRefreshView;
@property (nonatomic,copy) NSMutableArray<TopicInfo *> *dataList;
@property (nonatomic,copy) NSMutableArray<TopicInfo *> *topDataList;//“精选”数据
@property (nonatomic,copy) NSMutableArray<TopicInfo *> *followDataList;//“关注”数据


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = self.topMenu;
//    [self.collectionView addSubview:self.leftRefreshView];
    [self.view insertSubview:self.leftRefreshView belowSubview:self.collectionView];
    [self loadData];
    // Do any additional setup after loading the view.
}



- (void)viewWillLayoutSubviews{
    NSInteger width = CGRectGetWidth(self.view.bounds) - kCellInsets.left - kCellInsets.right;
    NSInteger height = CGRectGetHeight(self.view.bounds) - kCellInsets.top - kCellInsets.bottom;
    self.layout.itemSize = CGSizeMake(width, height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    [self loadData:New];
}

- (void)loadData:(QueryMethod)query{
    NSString *sortValue=@"";
    if (query==New) {
        sortValue=@"0";
    }else{
        sortValue=self.baseSortValue;
    }
    WS(weakSelf);
    [TopicInfo fetchTopicInfoListWithIsFollow:self.queryFollowData order:1 andSortValue:sortValue completion:^(BOOL isEnd, NSString *sortValue, NSArray *topicInfoList) {
        if (topicInfoList&&topicInfoList.count>0) {
            weakSelf.baseSortValue=sortValue;
            if (query==New) {
                weakSelf.dataList=[NSMutableArray arrayWithArray:topicInfoList];
            }else{
                [weakSelf.dataList addObjectsFromArray:topicInfoList];
            }
            if (weakSelf.queryFollowData) {
                weakSelf.followDataList=weakSelf.dataList;
            }else{
                weakSelf.topDataList=weakSelf.dataList;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.leftRefreshView endRefresh];
            [weakSelf.collectionView reloadData];
        });
        
    }];
}



- (TopMenu *)topMenu{
    if (!_topMenu) {
        _topMenu=[TopMenu loadFromNib];
        _topMenu.showText=@[@"精选",@"关注"];
        _topMenu.delegate=self;
    }
    return _topMenu;
}

- (LeftRefreshView *)leftRefreshView{
    if (!_leftRefreshView) {
        _leftRefreshView=[[LeftRefreshView alloc]init];
        [_leftRefreshView addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    }
    return _leftRefreshView;
}

- (NSMutableArray<TopicInfo *> *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray new];
    }
    return _dataList;
}

/// “精选”数据
- (NSMutableArray<TopicInfo *> *)topDataList{
    if (!_topDataList) {
        _topDataList=[[NSMutableArray alloc]init];
    }
    return _topDataList;
}

/// “关注”数据
- (NSMutableArray<TopicInfo *> *)followDataList{
    if (!_followDataList) {
        _followDataList=[NSMutableArray new];
    }
    return _followDataList;
}

#pragma mark - UICollectionViewDataSource Impl

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    cell.topicInfo=self.dataList[indexPath.row];
    return cell;
}

#pragma mark - TopMenuDelegate Impl

- (void) topMenu:(TopMenu *)topeMenu didClickButton:(NSUInteger)index{
    self.queryFollowData=index==1?YES:NO;
    if (self.followDataList.count>0) {
        self.dataList=(index==0)?self.topDataList:self.followDataList;
        [self.collectionView reloadData];
    }
    [self loadData];
}

#pragma mark - HomeCollectionViewCellDelegate Impl

- (void)homeCollectionViewCell:(HomeCollectionViewCell *)cell didClickButton:(UIButton *)button withButtonType:(HomeCollectionViewCellButtonType)btnType withTopicInfo:(TopicInfo *)topicInfo{
    switch (btnType) {
        case Tag:
            [self cellDidClickTagButton:topicInfo];
            break;
        case Chat:
            break;
        case Comment:
            break;
        case Star:
            break;
        default:
            break;
    }
}

- (void)cellDidClickTagButton:(TopicInfo *)topicInfo{
    [self performSegueWithIdentifier:kToTopicDetailSegue sender:topicInfo];
}

- (void)cellDidClickChatButton:(TopicInfo *)topicInfo{
    
}

- (void)cellDidClickCommentButton:(TopicInfo *)topicInfo{
    
}

- (void)cellDidClickStarButton:(TopicInfo *)topicInfo{
    
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kToTopicDetailSegue]) {
        TopicDetailController*toVC=[segue destinationViewController];
        TopicInfo *topicInfo=sender;
        toVC.subjectID=topicInfo.subjectID;
        toVC.title=topicInfo.subjectTitle;
        
    }

}


@end
