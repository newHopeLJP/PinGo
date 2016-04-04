//
//  TabBar.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/13.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TabBar.h"
#import "DHButton.h"

@interface TabBar ()

@property (nonatomic,strong) DHButton* selButton;
@property (nonatomic,strong) NSArray<NSString*>*   btnImages;
@property (nonatomic,strong) NSMutableArray<UIButton*>*   buttons;

@end

@implementation TabBar

-(void)awakeFromNib{
    [super awakeFromNib];
    for (int i=0; i<self.btnImages.count; i++) {
        NSString *imageName=self.btnImages[i];
        DHButton *b=[self buttonWithImageName:imageName];
        b.tag=i;
        if (i==0) {
            [self buttonClick:b];
        }
        [self addSubview:b];
        [self.buttons addObject:b];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count=self.buttons.count;
    CGFloat w=CGRectGetWidth(self.bounds)/(CGFloat)count;
    CGFloat h=CGRectGetHeight(self.bounds);
    
    CGRect frame=CGRectMake(0, 0, w, h);
    for (DHButton* b in self.buttons) {
        b.frame=CGRectOffset(frame, w*(CGFloat)b.tag, 0);
    }
}

-(DHButton*)buttonWithImageName:(NSString*)imageName{
    DHButton* b=[DHButton buttonWithType:UIButtonTypeCustom];
    NSString *selectedImageName=[imageName stringByAppendingString:@"_sel"];
    [b setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [b setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [b addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    return b;
}

-(void)buttonClick:(DHButton*)button{
    if (self.selButton!=button) {
        
        if (button.tag != 2) {
            self.selButton.selected = false;
            button.selected = true;
            self.selButton = button;
        }
        
        if (self.aDelegate) {
             [self.aDelegate tabBar:self didClickButton:button.tag];
        }
       

    }
}

-(NSArray*)btnImages{
    if (!_btnImages) {
        _btnImages=@[@"tabbar_home", @"tabbar_discover", @"tabbar_show", @"tabbar_message", @"tabbar_profile"];
    }
    return _btnImages;
}

-(NSMutableArray*)buttons{
    if (!_buttons) {
        _buttons=[[NSMutableArray alloc]init];
    }
    return _buttons;
}


@end
