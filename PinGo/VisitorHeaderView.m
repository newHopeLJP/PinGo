//
//  VisitorHeaderView.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/19.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "VisitorHeaderView.h"

@implementation VisitorHeaderView

-(void)setVisitorCount:(NSUInteger)visitorCount{
    _visitorCount=visitorCount;
    self.visitorCountLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)visitorCount];
}

-(void)setVisitorTodayCount:(NSUInteger)visitorTodayCount{
    _visitorTodayCount=visitorTodayCount;
    self.visitorTodayLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)visitorTodayCount];
}

+(VisitorHeaderView *)loadFromNib{
    VisitorHeaderView *visitorHeaderView=[[NSBundle mainBundle] loadNibNamed:@"VisitorHeader" owner:self options:nil].lastObject;
    return visitorHeaderView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
