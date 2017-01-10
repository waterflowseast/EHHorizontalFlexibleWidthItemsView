//
//  EHFlexibleWidthItemsSingleAnimatedSelectionView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/27.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHItemViewDelegate.h>

@class EHFlexibleWidthItemsSingleAnimatedSelectionView;

@protocol EHFlexibleWidthItemsSingleAnimatedSelectionViewDelegate <NSObject>

@optional
- (void)didTapItemAtIndex:(NSInteger)index inView:(EHFlexibleWidthItemsSingleAnimatedSelectionView *)view;

@end

@class EHHorizontalFlexibleWidthLayout;

@interface EHFlexibleWidthItemsSingleAnimatedSelectionView : UIScrollView

@property (nonatomic, assign) id<EHFlexibleWidthItemsSingleAnimatedSelectionViewDelegate> tapDelegate;

@property (nonatomic, strong, readonly) EHHorizontalFlexibleWidthLayout *layout;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout;

- (CGFloat)totalHeight;
- (CGFloat)totalWidth;

- (void)makeIndexSelected:(NSInteger)index;
- (void)makeIndexSelectedWithAnimation:(NSInteger)index;

@end
