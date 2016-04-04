//
//  ImageCarouselCell.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/1.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "ImageCarouselCell.h"
#import "UIImageView+WebCache.h"

@interface ImageCarouselCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCarouselCell

- (void)setBanner:(Banner *)banner{
    _banner=banner;
    
    if (banner && banner.imageUrl) {
        NSURL *url = [NSURL URLWithString:banner.imageUrl];
        [self.imageView sd_setImageWithURL:url];
    }
}

@end
