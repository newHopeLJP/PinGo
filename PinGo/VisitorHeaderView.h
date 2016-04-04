//
//  VisitorHeaderView.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/19.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitorHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *visitorCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorTodayLabel;

@property (nonatomic,assign) NSUInteger visitorCount;
@property (nonatomic,assign) NSUInteger visitorTodayCount;

+(VisitorHeaderView *)loadFromNib;

@end
