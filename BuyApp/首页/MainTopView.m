//
//  MainTopView.m
//  BuyApp
//
//  Created by D on 16/6/20.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import "MainTopView.h"

#define  GoodsArray @[@"",@"",@""]

@implementation MainTopView


- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self view_backGroundView];
        
    }
    return self;
}

-(void)setMyRootVc:(MainVc *)myRootVc{
    _myRootVc = myRootVc;
}

-(void)dealloc{
    self.myRootVc = nil;
}
//最新揭晓
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (GoodsArray.count > tap.view.tag-500) {

        [self.myRootVc tapAction:tap.view.tag-500];
    }
}

//显示获奖详情
-(void)click_showNewsInfo{
    [self.myRootVc click_showNewsInfo];
}

//循环广告
-(void)pageView:(ASPageView *)pageView didSelected:(NSInteger)index{
    [self.myRootVc pageView:pageView didSelected:index];
}

//功能菜单
-(void)click_MainClassViewIndex:(NSInteger)tag{
    //1:分类 2:十元区 3:揭晓 4:帮助
    [self.myRootVc click_MainclassViewIndexByVc:tag];

}

//创建视图
-(void)view_backGroundView{
    self.topBackGroundView = [UIView new];
    self.topBackGroundView.backgroundColor = GS_COLOR_WHITE;
    [self addSubview:self.topBackGroundView];
    [self.topBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(@(K_WIDTH / 660.0 * 410.0 + 80 + K_WIDTH / 3 + 30  +40));
    }];
    
    //创建广告
    self.pageView = [[ASPageView alloc]init];
    self.pageView.backgroundColor = [UIColor redColor];
    self.pageView.userInteractionEnabled = YES;
    self.pageView.delegate = self;
    [self.topBackGroundView addSubview:self.pageView];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.topBackGroundView);
        make.height.equalTo(self.pageView.mas_width).dividedBy(660.0/410.0);
    }];
    
    //创建功能菜单
    self.classView = [[MainClassView alloc] init];
    self.classView.delegate = self;
    self.classView.userInteractionEnabled = YES;
    [self.classView setDataWithModel:nil];
    self.classView.backgroundColor = [UIColor whiteColor];
    [self.topBackGroundView addSubview:self.classView];
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.pageView);
        make.top.equalTo(self.pageView.mas_bottom);
        make.height.mas_equalTo(@80);
    }];

    //创建中奖提示
    [self view_NewsBackView];
    [self.newsBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.classView);
        make.top.equalTo(self.classView.mas_bottom).offset(2);
        make.height.mas_equalTo(@40);
    }];
    
    //创建最新揭晓
    [self view_goodsBackView];
    [self.goodsBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.newsBackView);
        make.top.equalTo(self.newsBackView.mas_bottom).offset(2);
        make.height.mas_equalTo(K_WIDTH / 3 + 30  );
    }];
    
}

//创建最新揭晓视图
-(void)view_goodsBackView{
    
    self.goodsBackView = [UIView new];
    self.goodsBackView.backgroundColor = GS_COLOR_WHITE;
    [self.topBackGroundView addSubview:self.goodsBackView];
    
    UILabel * titleLab = [[UILabel alloc] init];
    titleLab.backgroundColor = [UIColor whiteColor];
    titleLab.textColor = GS_COLOR_DARKGRAY;
    titleLab.font = [UIFont gs_boldfont:NSAppFontM];
    titleLab.text = @"  最新揭晓";
    [self.goodsBackView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.goodsBackView);
        make.height.mas_equalTo(@30);
    }];
    
    self.goodsView = [UIView new];
    self.goodsView.backgroundColor = [UIColor whiteColor];
    [self.goodsBackView addSubview:self.goodsView];
    [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.goodsBackView);
        make.top.equalTo(titleLab.mas_bottom).offset(2);
        make.bottom.equalTo(self.goodsBackView.mas_bottom);
    }];
    
    for (int i = 0; i < 3; i++) {
        MainGoodsModel *item = nil;
        GoodsView *gv=[[GoodsView alloc]initWithFrame:CGRectMake(K_WIDTH/3 * i , 0, K_WIDTH / 3 - 1, K_WIDTH / 3)];
        [gv setDataModel:item];
        gv.tag = 500 + i;
        gv.userInteractionEnabled = YES;
        [gv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        [self.goodsView addSubview:gv];
        if (i < 2) {
            UILabel *lin=[[UILabel alloc]initWithFrame:CGRectMake(gv.right, gv.height * 0.1, 1, gv.height* 0.8)];
            lin.backgroundColor = GS_COLOR_WHITE;
            [self.goodsView addSubview:lin];
        }
    }
    
}
//创建最新消息视图
-(void)view_NewsBackView{
    
    self.newsBackView = [UIView new];
    self.newsBackView.backgroundColor = [UIColor whiteColor];
    [self.topBackGroundView addSubview:self.newsBackView];
    
    UIImageView *iv = [[UIImageView alloc] init];
    iv.backgroundColor = [UIColor orangeColor];
    [self.newsBackView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.newsBackView).with.offset(10);
        make.top.equalTo(self.newsBackView).with.offset(5);
        make.bottom.equalTo(self.newsBackView).with.offset(-5);
        make.width.mas_equalTo(iv.mas_height);
    }];
    
    self.newsLabel = [[UILabel alloc] init];
    self.newsLabel.backgroundColor = [UIColor clearColor];
    self.newsLabel.textColor = GS_COLOR_DARKGRAY;
    self.newsLabel.font = [UIFont gs_boldfont:NSAppFontL];
    self.newsLabel.text = @"测试: 暂时没有数据";
    [self.newsBackView addSubview:self.newsLabel];
    [self.newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(iv);
        make.left.equalTo(iv.mas_right).offset(10);
        make.right.equalTo(self.newsBackView.mas_right);
    }];
    
    UIButton *newsButton = [[UIButton alloc] init];
    [newsButton addTarget:self action:@selector(click_showNewsInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.newsBackView addSubview:newsButton];
    [newsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.newsBackView);
    }];
    
}



@end
