//
//  ImageCarouselView.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/1.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "ImageCarouselView.h"
#import "ImageCarouselCell.h"

#define kCellReuseIdentifier @"imageCarouselCell"


@interface ImageCarouselView ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic,assign) NSInteger numberOfSections;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ImageCarouselView

- (void)setBannerList:(NSArray *)bannerList{
    _bannerList=bannerList;
    
    [self.collectionView reloadData];
    if (bannerList.count<=1) {
        self.collectionView.scrollEnabled=NO;
        self.numberOfSections=1;
    }else{
        self.collectionView.scrollEnabled=YES;
        self.numberOfSections=100;
        
        [self collectionViewScrollToCenter];
        [self startTimer];
    }
    if (bannerList) {
        self.pageControl.numberOfPages=bannerList.count>0?bannerList.count:0;
    }else{
        self.pageControl.numberOfPages=0;
    }
    self.pageControl.currentPage=0;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
//     [self.collectionView registerClass:[ImageCarouselCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCarouselCell" bundle:nil] forCellWithReuseIdentifier:kCellReuseIdentifier];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layout.itemSize=self.bounds.size;
}


- (void)collectionViewScrollToCenter{
    if (self.bannerList) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.numberOfSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

- (void)scrollImage{
    CGFloat offsetX=self.collectionView.contentOffset.x;
    CGFloat toOffsetX=offsetX+CGRectGetWidth(self.collectionView.bounds);
    if (toOffsetX<self.collectionView.contentSize.width) {
        [self.collectionView setContentOffset:CGPointMake(toOffsetX, 0) animated:YES];
    }else{
        [self collectionViewScrollToCenter];
    }
}


- (void)startTimer{
    if (!self.timer) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer=nil;
}

+ (ImageCarouselView *)loadFromNib{
    return [[NSBundle mainBundle] loadNibNamed:@"ImageCarousel" owner:self options:nil].lastObject;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.bannerList) {
        return self.bannerList.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCarouselCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.banner=self.bannerList[indexPath.item];
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@interface ImageCarouselView (Delegate)<UICollectionViewDelegate>

@end

@implementation ImageCarouselView (Delegate)

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page=(NSInteger)(scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds)+0.5);
    self.pageControl.currentPage=page%self.bannerList.count;
}



@end
