//
//  TopMenu.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/13.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TopMenu.h"
#import "DHButton.h"

@interface TopMenu ()

@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;
@property (strong, nonatomic) IBOutletCollection(DHButton) NSArray *buttons;

@end

@implementation TopMenu


-(void)setShowText:(NSArray<NSString *> *)showText{
    _showText=showText;
    [self.buttons[0] setTitle:_showText[0] forState:UIControlStateNormal];
    [self.buttons[1] setTitle:_showText[1] forState:UIControlStateNormal];
}

-(void)setToIndex:(NSUInteger)toIndex{
    _toIndex=toIndex;
    
    if (toIndex<=self.buttons.count) {
        CGPoint center=self.indicatorLabel.center;
        DHButton *btn=self.buttons[toIndex];
        center.x=btn.center.x;
        [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.indicatorLabel.center=center;
        } completion:nil];
    }
    
}

- (IBAction)buttonClick:(DHButton *)sender {
    NSUInteger index=sender.tag;
    if (index!=self.toIndex) {
        self.toIndex=index;
        if (self.delegate) {
            [self.delegate topMenu:self didClickButton:index];
        }
    }
}

+(TopMenu *)loadFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"TopMenu" owner:self options:nil] lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
