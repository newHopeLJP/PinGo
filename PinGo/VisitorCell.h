//
//  VisitorCell.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/21.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBInspectableView.h"
#import "VisitorRecord.h"

@interface VisitorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet IBInspectableButton *sexAgeButton;
@property (weak, nonatomic) IBOutlet IBInspectableButton *constellationButton;
@property (weak, nonatomic) IBOutlet IBInspectableImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *visitorTimeLabel;

@property (strong,nonatomic) VisitorRecord *visitorRecord;
@end
