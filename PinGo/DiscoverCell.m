//
//  DiscoverCell.m
//  PinGo
//
//  Created by 新新希冀 on 16/4/3.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "DiscoverCell.h"
#import "UIImageView+WebCache.h"

@interface DiscoverCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIButton *visitorButton;
@property (weak, nonatomic) IBOutlet UIButton *picButton;

@end

@implementation DiscoverCell

- (void)setSubjectInfo:(SubjectInfo *)subjectInfo{
    _subjectInfo=subjectInfo;
    if (subjectInfo) {
        NSURL *url=[NSURL URLWithString:subjectInfo.imageUrl];
        [self.imageView sd_setImageWithURL:url];
        
        self.describeLabel.text=subjectInfo.title;
        [self.visitorButton setTitle:[self stringFromNum:subjectInfo.readCnt] forState:UIControlStateNormal];
        [self.visitorButton setTitle:[self stringFromNum:subjectInfo.topicCnt] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius=3;
    self.layer.masksToBounds=YES;
}

- (NSString *)stringFromNum:(NSInteger)num{
    if (num>999) {
        double kNum=(double)num/1000.0;
        if (kNum>999) {
            return @"999k+";
        }
        return [NSString stringWithFormat:@"%.1fk",kNum];
    }else{
        return [NSString stringWithFormat:@"%ld",num];
    }
}




@end
