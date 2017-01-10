//
//  EHFlexibleWidthItemsSingleAnimatedSelectionSeparatorView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/27.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHFlexibleWidthItemsSingleAnimatedSelectionView.h"

@interface EHFlexibleWidthItemsSingleAnimatedSelectionSeparatorView : EHFlexibleWidthItemsSingleAnimatedSelectionView

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

@end
