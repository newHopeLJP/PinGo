//
//  LeftRefreshView.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/25.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "LeftRefreshView.h"

#define kLeftRefreshViewWidth 65.0
#define kLeftRefreshViewX 15.0

typedef NS_ENUM(NSInteger,LeftRefreshViewState){
    Defualt,
    Pulling,
    Refreshing
};

#pragma mark - Private Class LeftImageView

@interface LeftImageView : UIImageView

@property (nonatomic,assign) BOOL shouldAnimating;

@end

@implementation LeftImageView

- (void)setShouldAnimating:(BOOL)shouldAnimating{
    _shouldAnimating=shouldAnimating;
    if (_shouldAnimating) {
        if (!self.isAnimating) {
            NSMutableArray *images=[[NSMutableArray alloc] init];
            for (int i=0; i<3; i++) {
                [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i]]];
            }
            self.animationImages=images;
            self.animationDuration=1.0;
            [self startAnimating];
        }
    }else{
        [self stopAnimating];
    }
}

@end

#pragma mark - LeftRefreshView

@interface LeftRefreshView ()

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,assign) LeftRefreshViewState beforeState;
@property (nonatomic,assign) LeftRefreshViewState refreshState;
@property (nonatomic,strong) LeftImageView *imageView;

@end

@implementation LeftRefreshView

- (LeftImageView *)imageView{
    if (!_imageView) {
        CGFloat y=(CGRectGetHeight(self.bounds)-self.scrollView.contentInset.top-kLeftRefreshViewWidth)*0.5;
        
        _imageView=[[LeftImageView alloc] initWithFrame:CGRectMake(0, y, kLeftRefreshViewWidth, kLeftRefreshViewWidth)];
        _imageView.image=[UIImage imageNamed:@"loading0"];
        _imageView.contentMode=UIViewContentModeCenter;
        _imageView.hidden=YES;
    }
    return _imageView;
}

- (void)setRefreshState:(LeftRefreshViewState)refreshState{
    _refreshState=refreshState;
    switch (_refreshState) {
        case Defualt:
            self.imageView.shouldAnimating=NO;
            if (self.beforeState==Refreshing) {
                [UIView animateWithDuration:0.25 animations:^{
                     self.scrollView.transform=CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                     self.imageView.hidden=YES;

                }];
            }
            break;
        case Pulling:
            self.imageView.shouldAnimating=YES;
            break;
        case Refreshing:
            [UIView animateWithDuration:0.3 animations:^{
                 self.scrollView.transform=CGAffineTransformMakeTranslation(kLeftRefreshViewWidth+kLeftRefreshViewX, 0);
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }];
            break;
    }
    
    self.beforeState = refreshState;

}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    for (UIView *view in newSuperview.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            self.scrollView=(UIScrollView *)view;
            self.frame=CGRectMake(kLeftRefreshViewX, 0, kLeftRefreshViewWidth, CGRectGetHeight(view.bounds));
            [self addSubview:self.imageView];
        }

    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    CGFloat leftInset=self.scrollView.contentInset.left;
    CGFloat offsetX=self.scrollView.contentOffset.x;
    CGFloat criticalValue=-leftInset-CGRectGetWidth(self.bounds);
    NSLog(@"leftInset=%f  offsetX=%f  totoal=%f",leftInset,offsetX,criticalValue);
    //拖动
    if (self.scrollView.dragging) {
        if (self.refreshState==Defualt && offsetX<0) {
            if (self.imageView.hidden) {
              [UIView animateWithDuration:0.2
                                    delay:0.05
                                  options:UIViewAnimationOptionCurveLinear
                               animations:^{
                                          self.imageView.hidden=NO;
                                        }
                               completion:nil];
            }

        }
        if (self.refreshState==Defualt && offsetX<criticalValue) {
            //完全显示出来
            self.refreshState=Pulling;
        }else if(self.refreshState==Pulling && offsetX>=criticalValue){
            self.refreshState=Defualt;
        }
    }else{
        if (self.refreshState==Pulling) {
            self.refreshState=Refreshing;
        }
    }
}

- (void)endRefresh{
    self.refreshState=Defualt;
}

- (void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

