//
//  UIImage+ColorImage.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

+(nullable UIImage*)imageWithColor:(nonnull UIColor* )color andSize:(CGSize)size;

@end
