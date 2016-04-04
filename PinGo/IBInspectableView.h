//
//  IBInspectableView.h
//  PinGo
//
//  Created by 新新希冀 on 16/3/12.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IBInspectableView : UIView
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@end

@interface IBInspectableImageView : UIImageView
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@end

@interface IBInspectableButton : UIButton
@property (nonatomic,assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic,assign)IBInspectable BOOL  canHighlight;
@end