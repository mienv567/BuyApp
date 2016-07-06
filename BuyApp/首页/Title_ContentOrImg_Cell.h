//
//  Title_ContentOrImg_Cell.h
//  ChemicalApp
//
//  Created by D on 16/5/6.
//  Copyright © 2016年 Super_D. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Title_ContentType) {
    Title_Content_Middle,           //标题——内容（内容在中间）
    Title_Content_Right,            //标题——内容（内容居右)
    Title_Content_NoImg      //预约管理详情的cell
};

@interface Title_ContentOrImg_Cell : UITableViewCell

@property (strong, nonatomic) UILabel *lab_titile;
@property (strong, nonatomic) UILabel *lab_content;
//@property (strong, nonatomic) UIImageView *img_right;
@property (nonatomic,assign)Title_ContentType mode;

-(void)resetTitle_ContentOrImg_CellContent:(NSString *)content;
@end
