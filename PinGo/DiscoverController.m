//
//  DiscoverController.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/3.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "DiscoverController.h"
#import "SubjectInfo.h"
#import "DiscoverHeaderView.h"
#import "Banner.h"
#import "DiscoverCell.h"
#import "SectionHeaderView.h"
#import "TopicDetailController.h"


#define kCellReuseIdentifier   @"discoverCell"
#define kSectionHeaderViewReuseIdentifier @"sectionHeaderViewReuseIdentifier"
#define kHeaderViewHeight 174.0

@interface DiscoverController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (copy,nonatomic) NSArray<NSArray<SubjectInfo *> *> *subjectInfoListArray;
@property (strong,nonatomic) DiscoverHeaderView *headerView;

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderViewReuseIdentifier];
    
    self.collectionView.contentInset=UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    [self.collectionView insertSubview:self.headerView atIndex:0];
    
    WS(weakSelf);
    
    [Banner fetchBannerListWithBannerQueryType:Subject completion:^(NSArray<Banner *> *bannerList) {
        if (bannerList) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.headerView.bannerList=bannerList;
            });

        }
    }];
   
    [SubjectInfo fetchSubjectInfoList:^(NSArray<NSArray<SubjectInfo *> *> *subjectInfoListArray) {
        if (subjectInfoListArray) {
            weakSelf.subjectInfoListArray=subjectInfoListArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    }];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    dispatch_async(dispatch_get_main_queue(), ^{
         self.headerView.frame = CGRectMake(0, -kHeaderViewHeight, CGRectGetWidth(self.view.bounds), kHeaderViewHeight);
    });
    CGFloat width = (CGRectGetWidth(self.view.bounds) - 3 * self.layout.minimumInteritemSpacing) * 0.5;
    CGFloat height = width * 3.0 / 4.0;
    self.layout.itemSize = CGSizeMake(width, height);

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.headerView scrollImage];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.headerView stopScrollImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DiscoverHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[DiscoverHeaderView loadFromNib];
    }
    return _headerView;
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.subjectInfoListArray) {
        return self.subjectInfoListArray.count;
    }else{
        return 0;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    NSArray *subjectInfoList=self.subjectInfoListArray[indexPath.section];
    if (subjectInfoList.count>indexPath.item) {
        cell.subjectInfo=subjectInfoList[indexPath.item];
    }
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    SectionHeaderView *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderViewReuseIdentifier forIndexPath:indexPath];
    view.showText = (indexPath.section == 0 ? @"热门话题" : @"推荐话题");
    return view;
}

#pragma mark - Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 40);
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DiscoverCell *cell=sender;
    if (cell) {
        if ([segue.destinationViewController isKindOfClass:[TopicDetailController class]]) {
            TopicDetailController *toVC=segue.destinationViewController;
            toVC.subjectID=cell.subjectInfo.subjectID;
            toVC.title=cell.subjectInfo.title;
        }
    }
}


@end
