//
//  PhotoCell.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/2.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "PhotoCell.h"
#import "UIImageView+WebCache.h"

@interface PhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCell

- (void)setPhotoInfo:(TopicInfo *)photoInfo{
    _photoInfo=photoInfo;
    if (photoInfo) {
        NSURL *url=[NSURL URLWithString:photoInfo.resUrl];
        [self.imageView sd_setImageWithURL:url];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.cornerRadius=3;
    self.layer.masksToBounds=YES;
}

@end
