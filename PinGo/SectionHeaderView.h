//
//  SectionHeaderView.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/31.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeaderView : UICollectionReusableView

@property (nonatomic,copy) NSString *showText;

+ (SectionHeaderView *)loadFromNib;

@end
