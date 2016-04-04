//
//  TopicDetatilController.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/30.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TopicDetailController.h"
#import "TopicDetailCollectionViewFlowLayout.h"
#import "TopicDetailHeaderView.h"
#import "SubjectInfo.h"
#import "TopicInfo.h"
#import "TopicDetailCell.h"

#define kCellReuseIdentifier  @"topicDetailCell"
#define kSectionHeaderViewReuseIdentifier @"sectionHeaderViewReuseIdentifier"
#define kHeaderViewHeight       (iPhone4s ? 180.0 : 280.0)

@interface TopicDetailController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet TopicDetailCollectionViewFlowLayout *layout;

@property (strong,nonatomic) TopicDetailHeaderView *headerView;
@property (nonatomic,copy) NSArray *topicInfoList;

@end

@implementation TopicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.contentInset=UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    [self.collectionView insertSubview:self.headerView atIndex:0];
    [self fetchData];
}

- (void)fetchData{
    if (!self.subjectID) {
        return;
    }
    WS(weakSelf);
    NSInteger subjectId=[self.subjectID integerValue];
    [SubjectInfo fetchSubjectInfoWithSubjectID:subjectId completion:^(SubjectInfo *subjectInfo, NSArray<User *> *managerUserList) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.headerView.subjectInfo=subjectInfo;
            weakSelf.headerView.users=managerUserList;
        });
       
    }];
    
    [TopicInfo fetchSubjectTopicListWithSubjectID:subjectId completion:^(BOOL isEnd, NSString *sortValue, NSArray *topicInfoList) {
        if (topicInfoList.count>0) {
            weakSelf.topicInfoList=topicInfoList;
            weakSelf.layout.topicInfoList=topicInfoList;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                 [weakSelf.collectionView reloadData];
            });
            
           
        }
    }];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.headerView.frame=CGRectMake(0, -kHeaderViewHeight, CGRectGetWidth(self.view.bounds), kHeaderViewHeight);
    });

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self settingNavigationBarAlpha:0.0];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self settingNavigationBarAlpha:1.0];
}

- (void)settingNavigationBarAlpha:(CGFloat)alpha{
    UINavigationBar *navigationBar=self.navigationController.navigationBar;
    UIView *bgView=[navigationBar valueForKey:@"_backgroundView"];
    if (bgView) {
        bgView.alpha=alpha;
    }
    CGFloat titleAlpha=alpha>0.8?alpha:0;
    navigationBar.titleTextAttributes=@{NSFontAttributeName:kNavigationBarFont,
                                        NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:titleAlpha]
                                        };
}



- (TopicDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[TopicDetailHeaderView loadFromNib];
    }
    return _headerView;
}

- (NSArray *)topicInfoList{
    if (!_topicInfoList) {
        _topicInfoList=[NSArray new];
    }
    return _topicInfoList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView DataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%s self.topicInfoList.count=%ld",__FUNCTION__,self.topicInfoList.count);
    return self.topicInfoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TopicDetailCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier        forIndexPath:indexPath];
    cell.topicInfo=self.topicInfoList[indexPath.item];
    return cell;
}

#pragma mark - CollectionView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    if (offset.y<=-(kHeaderViewHeight-kNavBarHeight)) {
        [self settingNavigationBarAlpha:0];
    }else{
        [self settingNavigationBarAlpha:(offset.y/(kHeaderViewHeight-kNavBarHeight))];
    }
    
    if (offset.y<kHeaderViewHeight) {
        CGRect frame=self.headerView.frame;
        frame.origin.y=offset.y;
        frame.size.height=-offset.y;
        self.headerView.frame=frame;
    }
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
