//
//  EHHorizontalFlexibleWidthItemsTrackView.h
//  Pods
//
//  Created by Eric Huang on 17/2/17.
//
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHItemViewDelegate.h>

#ifndef EHHorizontalFlexibleWidthItemsTrackView_H
#define EHHorizontalFlexibleWidthItemsTrackView_H

typedef NS_ENUM(NSInteger, EHHorizontalFlexibleWidthItemsTrackViewSlideDirection) {
    EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionNext,
    EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionPrevious
};

#endif

@class EHHorizontalFlexibleWidthItemsTrackView;

@protocol EHHorizontalFlexibleWidthItemsTrackViewDelegate <NSObject>

@optional
- (void)didTapItemAtIndex:(NSInteger)index inView:(EHHorizontalFlexibleWidthItemsTrackView *)view;

@end

@class EHHorizontalFlexibleWidthLayout;

@interface EHHorizontalFlexibleWidthItemsTrackView : UIScrollView

@property (nonatomic, assign) id<EHHorizontalFlexibleWidthItemsTrackViewDelegate> tapDelegate;

@property (nonatomic, strong, readonly) EHHorizontalFlexibleWidthLayout *layout;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, assign, readonly) CGFloat trackHeight;
@property (nonatomic, assign) CGFloat trackWidthPercent;
@property (nonatomic, assign) CGFloat trackCornerRadius;
@property (nonatomic, strong) UIColor *trackColor;

- (instancetype)initWithItems:(NSArray <UIView *> *)items itemWidths:(NSArray <NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing trackHeight:(CGFloat)trackHeight;

- (instancetype)initWithItems:(NSArray <UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout trackHeight:(CGFloat)trackHeight;

- (void)resetWithItems:(NSArray <UIView *> *)items itemWidths:(NSArray <NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing trackHeight:(CGFloat)trackHeight;

- (void)resetWithItems:(NSArray <UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout trackHeight:(CGFloat)trackHeight;

- (CGFloat)totalHeight;
- (CGFloat)totalWidth;

- (void)makeIndexSelectedWithAnimation:(NSInteger)index;
- (void)slidingToDirection:(EHHorizontalFlexibleWidthItemsTrackViewSlideDirection)direction percentage:(CGFloat)percentage;
- (void)slideToDirection:(EHHorizontalFlexibleWidthItemsTrackViewSlideDirection)direction;
- (void)slideBackFromDirection:(EHHorizontalFlexibleWidthItemsTrackViewSlideDirection)direction;

- (void)scrollToMiddleOfFrameForItemViewAtIndex:(NSInteger)index;

@end
