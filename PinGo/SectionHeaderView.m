//
//  SectionHeaderView.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/31.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "SectionHeaderView.h"

@interface SectionHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SectionHeaderView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setShowText:(NSString *)showText{
    _showText=showText;
    self.label.text=showText;
}

+ (SectionHeaderView *)loadFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:self options:nil] lastObject];
}

@end
