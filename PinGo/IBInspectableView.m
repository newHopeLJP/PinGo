//
//  IBInspectableView.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "IBInspectableView.h"

#pragma  mark IBInspectableView

IB_DESIGNABLE
@implementation IBInspectableView

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius=cornerRadius;
    self.layer.masksToBounds=cornerRadius>0;
}

-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

#pragma mark - IBInspectableImageView

IB_DESIGNABLE
@implementation IBInspectableImageView

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius=cornerRadius;
    self.layer.masksToBounds=cornerRadius>0;
}
-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

@end

#pragma mark - IBInspectableButton

IB_DESIGNABLE
@implementation IBInspectableButton

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius=cornerRadius;
    self.layer.masksToBounds=cornerRadius>0;
}

-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

@end