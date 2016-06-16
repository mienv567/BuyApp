//
//  ASWaitingView.m
//  astro
//
//  Created by kjubo on 14-1-28.
//  Copyright (c) 2014年 kjubo. All rights reserved.
//

#import "ASWaitingView.h"

@interface ASWaitingView()
//蒙皮图片
@property (nonatomic, retain) UIImageView *maskview;
//loading主界面
@property (nonatomic, retain) UIImageView *loadview;
//loading
@property (nonatomic, strong) UIImageView *ivLin;
@property (nonatomic, retain) UIImageView *activety;
//标题内容
@property (nonatomic, retain) UILabel *title;

//loading主界面最大宽度
@property CGFloat maxLoadingViewWidth;
@end

@implementation ASWaitingView

- (id)initWithBaseViewController:(RootViewController *)vc
{
    self = [super initWithFrame:vc.view.frame];
    if (self) {
        // Initialization code
        self.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        self.viewController = vc;
        [self.viewController.view addSubview:self];
        
        self.maxLoadingViewWidth = self.width * 0.5;
        
        self.maskview = [[UIImageView alloc] initWithFrame:self.bounds];
        self.maskview.backgroundColor = [UIColor blackColor];
        self.maskview.alpha = 0.3;
        [self addSubview:self.maskview];
        
        self.loadview = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.loadview.backgroundColor = GS_COLOR_WHITE;
        self.loadview.layer.cornerRadius = 8;
        [self addSubview:self.loadview];
        
        self.activety = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        self.activety.image = [UIImage imageNamed:@"lodingring"];
        [self.loadview addSubview:self.activety];
        
        self.ivLin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lin"]];
        [self.loadview addSubview:self.ivLin];
        
        self.title = [[UILabel alloc] init];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.lineBreakMode = NSLineBreakByCharWrapping;
        self.title.textColor = GS_COLOR_LIGHTBLACK;
        self.title.font = [UIFont gs_font:NSAppFontM];
        [self.loadview addSubview:self.title];
    }
    return self;
}

- (void)showWating:(NSString *)tips{
    if([tips length] == 0){
        tips = kDefalutLoadingText;
    }
    
    self.title.text = tips;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:self.title.font forKey:NSFontAttributeName];

    self.title.size =[self.title.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 25.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    self.loadview.size = CGSizeMake(self.title.width + 100, self.title.height + 40);
    self.loadview.center = CGPointMake(self.width * 0.5, self.height * 0.4);
    
    self.activety.left = 20;
    self.activety.centerY = self.loadview.height * 0.5;
    self.ivLin.center = self.activety.center;
    self.title.left = self.activety.right + 10;
    self.title.centerY = self.activety.centerY;
    
    self.hidden = NO;
    if(![self.activety.layer animationForKey:@"rotationAnimation"]){
        CABasicAnimation *rotaionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotaionAnimation.toValue = @(M_PI * 2.0);
        rotaionAnimation.duration = 1.0;
        rotaionAnimation.cumulative = YES;
        rotaionAnimation.repeatCount = HUGE_VALF;
        [self.activety.layer addAnimation:rotaionAnimation forKey:@"rotationAnimation"];
    }
    
    [self.viewController.view bringSubviewToFront:self];
    self.loadview.transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    [UIView animateWithDuration:0.2 animations:^{
        self.loadview.transform = CGAffineTransformIdentity;
    }];
}

- (void)hideWaiting{
    [UIView animateWithDuration:0.2 animations:^{
        self.loadview.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}


@end
