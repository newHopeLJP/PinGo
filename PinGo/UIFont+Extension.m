//
//  UIFont+Extension.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)
+(UIFont *)fontWithSize:(CGFloat)size{
    UIFont *font=[UIFont  fontWithName:@"BigYoungMediumGB2.0" size:size];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:size];
}
@end
