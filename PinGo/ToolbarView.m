//
//  ToolbarView.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/27.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "ToolbarView.h"

@implementation ToolbarView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, 0.2)];
    [[UIColor lightGrayColor] setFill];
    [path fill];
    
}


@end
