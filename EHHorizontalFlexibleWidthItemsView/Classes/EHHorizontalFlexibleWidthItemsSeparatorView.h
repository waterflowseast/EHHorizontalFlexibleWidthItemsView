//
//  EHHorizontalFlexibleWidthItemsSeparatorView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/22.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFlexibleWidthItemsView.h"

@interface EHHorizontalFlexibleWidthItemsSeparatorView : EHHorizontalFlexibleWidthItemsView

- (instancetype)initWithItems:(NSArray<UIView *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (instancetype)initWithItems:(NSArray<UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (void)resetWithItems:(NSArray<UIView *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (void)resetWithItems:(NSArray<UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

@end
