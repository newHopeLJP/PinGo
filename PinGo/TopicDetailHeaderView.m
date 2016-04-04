//
//  TopicDetailHeaderView.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/30.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TopicDetailHeaderView.h"
#import "IBInspectableView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface TopicDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutletCollection(IBInspectableButton) NSArray<IBInspectableButton *> *userIconButtons;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end

@implementation TopicDetailHeaderView

+ (TopicDetailHeaderView *)loadFromNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"TopicDetailHeader" owner:self options:nil] lastObject];
}

- (void)setSubjectInfo:(SubjectInfo *)subjectInfo{
    _subjectInfo=subjectInfo;
    
    if (subjectInfo.imageUrl) {
        NSURL *bgImagUrl=[NSURL URLWithString:subjectInfo.imageUrl];
        [self.backgroundImageView sd_setImageWithURL:bgImagUrl];
    }
    self.titleLabel.text=subjectInfo.title;
    self.contentLabel.text=subjectInfo.desc;
    NSLog(@"%stitleLabel.text=%@ contentLabel.text=%@",__FUNCTION__,self.titleLabel.text,self.contentLabel.text);
}

- (void)setUsers:(NSArray<User *> *)users{
    _users=users;
    
    NSInteger index=0;
    for (User *user in users) {
        if (user.headUrl) {
            if (self.userIconButtons.count<index) {
                return;
            }
            NSURL *headUrl=[NSURL URLWithString:user.headUrl];
            self.userIconButtons[index].hidden=NO;
            [self.userIconButtons[index] sd_setBackgroundImageWithURL:headUrl forState:UIControlStateNormal];
        }
        index++;
    }
}

- (IBAction)userIconButtonClick:(UIButton *)sender {
}
- (IBAction)followButtonClick:(UIButton *)sender {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
