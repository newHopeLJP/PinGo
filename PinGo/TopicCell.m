//
//  TopicCell.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/2.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TopicCell.h"
#import "SectionHeaderView.h"
#import "PhotoCell.h"

#define kCellReuseIdentifier @"photoCell"

@interface TopicCell ()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (strong,nonatomic) SectionHeaderView *headerView;


@end

@implementation TopicCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    [self.topView addSubview:self.headerView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.headerView.frame=self.topView.bounds;
    });
    
    CGFloat height=CGRectGetHeight(self.collectionView.bounds);
    self.layout.itemSize=CGSizeMake(height, height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHeaderViewText:(NSString *)headerViewText{
    _headerViewText=headerViewText;
    self.headerView.showText=headerViewText;
    
}

- (void)setPhontoInfoList:(NSArray<TopicInfo *> *)phontoInfoList{
    _phontoInfoList=phontoInfoList;
    [self.collectionView reloadData];
}

//MARK: lazy loading
- (SectionHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[SectionHeaderView loadFromNib];
    }
    return _headerView;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.phontoInfoList) {
        return self.phontoInfoList.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.photoInfo=self.phontoInfoList[indexPath.item];
    return cell;
}



@end
