//
//  EHFlexibleWidthItemsSequentialSelectionView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/22.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFlexibleWidthItemsView.h"
#import <EHItemViewCommon/EHItemViewDelegate.h>

@interface EHFlexibleWidthItemsSequentialSelectionView : EHHorizontalFlexibleWidthItemsView

@property (nonatomic, assign) BOOL allowsToCancel;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout;

- (void)makeIndexSelected:(NSInteger)index;

@end
