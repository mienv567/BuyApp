//
//  UITableViewCell+GSMasonryAutoCellHeight.m
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 15/9/1.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "UITableViewCell+GSMasonryAutoCellHeight.h"
#import <objc/runtime.h>
#import "UITableView+GSCacheHeight.h"

NSString *const kGSCacheUniqueKey = @"kGSCacheUniqueKey";
NSString *const kGSCacheStateKey = @"kGSCacheStateKey";
NSString *const kGSRecalculateForStateKey = @"kGSRecalculateForStateKey";
NSString *const kGSCacheForTableViewKey = @"kGSCacheForTableViewKey";

const void *s_GS_lastViewInCellKey = "GS_lastViewInCellKey";
const void *s_GS_bottomOffsetToCellKey = "GS_bottomOffsetToCellKey";

@implementation UITableViewCell (GSMasonryAutoCellHeight)

#pragma mark - Public
+ (CGFloat)GS_heightForIndexPath:(NSIndexPath *)indexPath config:(GSCellBlock)config {
  UITableViewCell *cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:nil];
  
  if (config) {
    config(cell);
  }
  
  return [cell private_GS_heightForIndexPath:indexPath];
}

+ (CGFloat)GS_heightForIndexPath:(NSIndexPath *)indexPath
                           config:(GSCellBlock)config
                            cache:(GSCacheHeight)cache {
  if (cache) {
    NSDictionary *cacheKeys = cache();
    UITableView *tableView = cacheKeys[kGSCacheForTableViewKey];
    
    NSString *key = cacheKeys[kGSCacheUniqueKey];
    NSString *stateKey = cacheKeys[kGSCacheStateKey];
    NSString *shouldUpdate = cacheKeys[kGSRecalculateForStateKey];
    
    NSMutableDictionary *stateDict = tableView.GS_cacheCellHeightDict[key];
    NSString *cacheHeight = stateDict[stateKey];
 
    if (tableView == nil
        || tableView.GS_cacheCellHeightDict.count == 0
        || shouldUpdate.boolValue
        || cacheHeight == nil) {
      CGFloat height = [self GS_heightForIndexPath:indexPath config:config];
      
      if (stateDict == nil) {
        stateDict = [[NSMutableDictionary alloc] init];
        tableView.GS_cacheCellHeightDict[key] = stateDict;
      }
      
      [stateDict setObject:[NSString stringWithFormat:@"%lf", height] forKey:stateKey];
      
      return height;
    } else if (tableView.GS_cacheCellHeightDict.count != 0
               && cacheHeight != nil
               && cacheHeight.integerValue != 0) {
      NSLog(@"read from cache");
      return cacheHeight.floatValue;
    }
  }
  
  return [self GS_heightForIndexPath:indexPath config:config];
}

- (void)setGS_lastViewInCell:(UIView *)GS_lastViewInCell {
  objc_setAssociatedObject(self,
                           s_GS_lastViewInCellKey,
                           GS_lastViewInCell,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)GS_lastViewInCell {
  return objc_getAssociatedObject(self, s_GS_lastViewInCellKey);
}

- (void)setGS_bottomOffsetToCell:(CGFloat)GS_bottomOffsetToCell {
  objc_setAssociatedObject(self,
                           s_GS_bottomOffsetToCellKey,
                           @(GS_bottomOffsetToCell),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)GS_bottomOffsetToCell {
  NSNumber *valueObject = objc_getAssociatedObject(self, s_GS_bottomOffsetToCellKey);
  if ([valueObject respondsToSelector:@selector(floatValue)]) {
    return valueObject.floatValue;
  }
  
  return 0.0;
}

#pragma mark - Private
- (CGFloat)private_GS_heightForIndexPath:(NSIndexPath *)indexPath {
  NSAssert(self.GS_lastViewInCell != nil, @"您未指定cell排列中最后一个视图对象，无法计算cell的高度");
  
  [self layoutIfNeeded];
  
  CGFloat rowHeight = self.GS_lastViewInCell.frame.size.height + self.GS_lastViewInCell.frame.origin.y;
  rowHeight += self.GS_bottomOffsetToCell;
  
  return rowHeight;
}



@end
