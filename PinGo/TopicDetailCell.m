//
//  TopicDetailCell.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/30.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TopicDetailCell.h"
#import "IBInspectableView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@interface TopicDetailCell ()
@property (weak, nonatomic) IBOutlet IBInspectableButton *userIconButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *starNumButton;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *starButton;
@end

@implementation TopicDetailCell

- (void)setTopicInfo:(TopicInfo *)topicInfo{
    _topicInfo=topicInfo;
    
    if (!topicInfo) {
        return;
    }
    
    if (topicInfo.userInfo) {
        if (topicInfo.userInfo.headUrl) {
            [self.userIconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:topicInfo.userInfo.headUrl]  forState:UIControlStateNormal];
        }
        self.userNameLabel.text=topicInfo.userInfo.nickname;
    }
    
    [self.starButton setTitle:topicInfo.commentCnt forState:UIControlStateNormal];
    
    if (topicInfo.resUrl) {
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:topicInfo.resUrl]];
    }
    
    self.descLabel.text = topicInfo.content;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius=5;
    self.layer.masksToBounds=YES;
}

@end
