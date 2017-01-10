//
//  EHHorizontalFlexibleWidthItemsView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/16.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHTypeDefs.h>

@class EHHorizontalFlexibleWidthItemsView;

@protocol EHHorizontalFlexibleWidthItemsViewDelegate <NSObject>

@optional
- (void)didTapItemAtIndex:(NSInteger)index inView:(EHHorizontalFlexibleWidthItemsView *)view;

@end

@class EHHorizontalFlexibleWidthLayout;

@interface EHHorizontalFlexibleWidthItemsView : UIScrollView

@property (nonatomic, assign) BOOL allowsAnimationWhenTap;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, copy) void (^animationBlock)(UIView *itemView, NSTimeInterval animationDuration, EHAnimationCompletionBlock animationCompletion);
@property (nonatomic, assign) id<EHHorizontalFlexibleWidthItemsViewDelegate> tapDelegate;

@property (nonatomic, strong, readonly) EHHorizontalFlexibleWidthLayout *layout;

- (instancetype)initWithItems:(NSArray <UIView *> *)items itemWidths:(NSArray <NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (instancetype)initWithItems:(NSArray <UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout;

- (void)resetWithItems:(NSArray <UIView *> *)items itemWidths:(NSArray <NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (void)resetWithItems:(NSArray <UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout;

- (CGFloat)totalHeight;
- (CGFloat)totalWidth;

@end
