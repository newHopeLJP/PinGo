//
//  UIImage+ColorImage.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

+(UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), true, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
