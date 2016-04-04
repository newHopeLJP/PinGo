//
//  HomeCollectionViewCell.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/27.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "IBInspectableView.h"
#import "ToolbarView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "NSDate+Extension.h"

@interface HomeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet IBInspectableButton *headButton;
@property (weak, nonatomic) IBOutlet UIButton *headIcon;
@property (weak, nonatomic) IBOutlet IBInspectableButton *tagButton;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet ToolbarView *toolbarView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *starButton;

@end

@implementation HomeCollectionViewCell

- (void)setTopicInfo:(TopicInfo *)topicInfo{
    _topicInfo=topicInfo;
    
    if (!topicInfo) {
        return;
    }
    
    if (topicInfo.resUrl) {
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topicInfo.resUrl]];
    }
    
    UIImage *img=[UIImage imageNamed:@"home_head"];
    if (topicInfo.userInfo && topicInfo.userInfo.headUrl) {
        [self.headButton sd_setBackgroundImageWithURL:[NSURL URLWithString:topicInfo.userInfo.headUrl] forState:UIControlStateNormal placeholderImage:img];
    }else{
        [self.headButton setImage:img forState:UIControlStateNormal];
    }
    
    if (topicInfo.userInfo) {
        if (topicInfo.userInfo.heat==1) {
            self.headIcon.hidden=NO;
            [self.headIcon setImage:[UIImage imageNamed:@"home_head_star"] forState:UIControlStateNormal];
        }else{
            self.headIcon.hidden=YES;
        }
    }
    
    if (topicInfo.subjectTitle) {
        if (![topicInfo.subjectTitle isEqualToString:@""]) {
            self.tagButton.hidden=NO;
            [self.tagButton setTitle:[NSString stringWithFormat:@"  #%@",topicInfo.subjectTitle] forState:UIControlStateNormal];
        }else{
            self.tagButton.hidden=YES;
        }
    }
    
    self.describeLabel.text=topicInfo.content;
    
    NSDate *pubDate=[NSDate dateWithTimeStamp:topicInfo.pubTime];
    NSDateComponents *components=[kCalendar components:NSCalendarUnitMonth fromDate:pubDate];
    self.monthLabel.text=[NSString stringWithFormat:@"%ld月",(long)components.month];
    components=[kCalendar components:NSCalendarUnitDay fromDate:pubDate];
    self.dayLabel.text=[NSString stringWithFormat:@"%ld",components.day];
    components=[kCalendar components:NSCalendarUnitYear fromDate:pubDate];
    self.yearLabel.text=[NSString stringWithFormat:@"%ld",components.year];
    
    if (topicInfo.commentCnt) {
        NSInteger commentNum=[topicInfo.commentCnt integerValue];
        if (commentNum>999) {
            [self.commentButton setTitle:@"999+" forState:UIControlStateNormal];
        }else if(commentNum==0){
            [self.commentButton setTitle:@"评论" forState:UIControlStateNormal];
        }else{
            [self.commentButton setTitle:topicInfo.commentCnt forState:UIControlStateNormal];
        }
    }
    
    if (topicInfo.praiseCnt>999) {
        [self.starButton setTitle:@"999+" forState:UIControlStateNormal];
    }else{
        [self.starButton setTitle:[NSString stringWithFormat:@"%ld",topicInfo.praiseCnt] forState:UIControlStateNormal];
    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = true;
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (self.delegate) {
        NSLog(@"sender.tag:%ld",sender.tag);
        [self.delegate homeCollectionViewCell:self didClickButton:sender withButtonType:(HomeCollectionViewCellButtonType)(sender.tag) withTopicInfo:self.topicInfo];
    }
}

@end
