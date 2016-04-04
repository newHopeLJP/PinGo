//
//  VisitorCell.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/21.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "VisitorCell.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import  "NSString+Age.h"

@implementation VisitorCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setVisitorRecord:(VisitorRecord *)visitorRecord{
    _visitorRecord=visitorRecord;

    User *user=visitorRecord.user;
    UIImage *img=[UIImage imageNamed:@"home_head"];
    if (user.headUrl) {
        NSURL *hearUrl=[NSURL URLWithString:user.headUrl];
        if (hearUrl) {
            [self.headIcon sd_setImageWithURL:hearUrl placeholderImage:img];
        }else{
            self.headIcon.image=img;
        }
    }else{
        self.headIcon.image=img;
    }
    self.nickNameLabel.text=user.nickname;
    [self.sexAgeButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)user.age] forState:UIControlStateNormal];
    
    [self.constellationButton setTitle:user.constellation forState:UIControlStateNormal];
    
    if (user.sex==1) {
        [self.sexAgeButton setImage:[UIImage imageNamed:@"woman_icon"] forState:UIControlStateNormal];
    }else{
        [self.sexAgeButton setImage:[UIImage imageNamed:@"man_icon"] forState:UIControlStateNormal];
    }
    
    self.visitorTimeLabel.text=[visitorRecord.visitTime dateStringToStyle:@"yyyy-MM-dd"];

}

@end
