//
//  ImageCarouselView.h
//  PinGo
//
//  Created by 新新希冀 on 16/4/1.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCarouselView : UIView

@property (nonatomic,copy) NSArray *bannerList;

- (void)scrollImage;
- (void)startTimer;
- (void)stopTimer;

+ (ImageCarouselView *)loadFromNib;

@end
