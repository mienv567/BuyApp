//
//  UITableView+GSCacheHeight.m
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 16/1/22.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "UITableView+GSCacheHeight.h"
#import <objc/runtime.h>

static const void *__GS_tableview_cacheCellHeightKey = "__GS_tableview_cacheCellHeightKey";

@implementation UITableView (GSCacheHeight)

- (NSMutableDictionary *)GS_cacheCellHeightDict {
 NSMutableDictionary *dict = objc_getAssociatedObject(self, __GS_tableview_cacheCellHeightKey);
  
  if (dict == nil) {
    dict = [[NSMutableDictionary alloc] init];
    objc_setAssociatedObject(self,
                             __GS_tableview_cacheCellHeightKey,
                             dict,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  
  return dict;
}

@end
