//
//  ASWaitingView.h
//  astro
//
//  Created by kjubo on 14-1-28.
//  Copyright (c) 2014年 kjubo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootViewController;
@interface ASWaitingView : UIView

@property (nonatomic, assign) RootViewController *viewController;

- (id)initWithBaseViewController:(RootViewController *)vc;
- (void)showWating:(NSString *)tips;
- (void)hideWaiting;
@end
