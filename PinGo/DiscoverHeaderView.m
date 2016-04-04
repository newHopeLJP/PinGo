//
//  DiscoverHeaderView.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/2.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "DiscoverHeaderView.h"
#import "ImageCarouselView.h"

@interface DiscoverHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (strong,nonatomic) ImageCarouselView *imageCarouselView;

@end

@implementation DiscoverHeaderView

#pragma mark - view lifecyle
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.topView addSubview:self.imageCarouselView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageCarouselView.frame=self.topView.bounds;
}

- (void)setBannerList:(NSArray<Banner *> *)bannerList{
    _bannerList=bannerList;
    self.imageCarouselView.bannerList=bannerList;
}


- (ImageCarouselView *)imageCarouselView{
    if (!_imageCarouselView) {
        _imageCarouselView=[ImageCarouselView loadFromNib];
    }
    return _imageCarouselView;
}

- (IBAction)buttonClick:(id)sender {
}

- (void)scrollImage{
    [self.imageCarouselView startTimer];
}

- (void)stopScrollImage{
    [self.imageCarouselView stopTimer];
}

+ (DiscoverHeaderView *)loadFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"DiscoverHeader" owner:self options:nil] lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
