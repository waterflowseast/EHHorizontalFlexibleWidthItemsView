//
//  EHHorizontalFlexibleWidthItemsTrackView.m
//  Pods
//
//  Created by Eric Huang on 17/2/17.
//
//

#import "EHHorizontalFlexibleWidthItemsTrackView.h"
#import "EHHorizontalFlexibleWidthLayout.h"
#import <EHItemViewCommon/UIView+EHItemViewDelegate.h>

static NSTimeInterval const kAnimationDuration = 0.35;

@interface EHHorizontalFlexibleWidthItemsTrackView () <EHItemViewDelegate>

@property (nonatomic, strong, readwrite) EHHorizontalFlexibleWidthLayout *layout;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@property (nonatomic, assign, readwrite) CGFloat trackHeight;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) UIView *trackView;

@end

@implementation EHHorizontalFlexibleWidthItemsTrackView

- (void)commonInit {
    self.showsHorizontalScrollIndicator = NO;
    _trackWidthPercent = 1.0f;
    _trackCornerRadius = 0;
    _trackColor = [UIColor redColor];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray <UIView *> *)items itemWidths:(NSArray <NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing trackHeight:(CGFloat)trackHeight {
    self = [super init];
    if (self) {
        [self commonInit];
        
        _layout = [[EHHorizontalFlexibleWidthLayout alloc] initWithItemWidths:itemWidths itemHeight:itemHeight insets:insets interitemSpacing:interitemSpacing];
        _trackHeight = trackHeight;
        
        [self addToViewWithItems:items];
        _selectedIndex = 0;
        [self addTrackView];
        
        [self didTapView:[self itemViewAtIndex:_selectedIndex] toSelected:YES];
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray <UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout trackHeight:(CGFloat)trackHeight {
    self = [super init];
    if (self) {
        [self commonInit];
        
        _layout = layout;
        _trackHeight = trackHeight;
        
        [self addToViewWithItems:items];
        _selectedIndex = 0;
        [self addTrackView];
        
        [self didTapView:[self itemViewAtIndex:_selectedIndex] toSelected:YES];
    }
    
    return self;
}

- (void)resetWithItems:(NSArray <UIView *> *)items itemWidths:(NSArray <NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing trackHeight:(CGFloat)trackHeight {
    [self removeGestureRecognizer:self.tapRecognizer];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _layout = [[EHHorizontalFlexibleWidthLayout alloc] initWithItemWidths:itemWidths itemHeight:itemHeight insets:insets interitemSpacing:interitemSpacing];
    _trackHeight = trackHeight;
    
    [self addToViewWithItems:items];
    _selectedIndex = 0;
    [self addTrackView];
    
    for (int i = 0; i < items.count; i++) {
        [self didTapView:[self itemViewAtIndex:i] toSelected:(i == self.selectedIndex)];
    }
}

- (void)resetWithItems:(NSArray <UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout trackHeight:(CGFloat)trackHeight {
    [self removeGestureRecognizer:self.tapRecognizer];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _layout = layout;
    _trackHeight = trackHeight;
    
    [self addToViewWithItems:items];
    _selectedIndex = 0;
    [self addTrackView];
    
    for (int i = 0; i < items.count; i++) {
        [self didTapView:[self itemViewAtIndex:i] toSelected:(i == self.selectedIndex)];
    }
}

- (CGFloat)totalHeight {
    return [self.layout totalHeight] + self.trackHeight;
}

- (CGFloat)totalWidth {
    return [self.layout totalWidth];
}

- (void)makeIndexSelectedWithAnimation:(NSInteger)index {
    if (self.selectedIndex != index) {
        [self didTapView:[self itemViewAtIndex:self.selectedIndex] animateToSelected:NO];
        [self didTapView:[self itemViewAtIndex:index] animateToSelected:YES];
        
        self.selectedIndex = index;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            CGRect frame = self.trackView.frame;
            frame.origin.x = [self xForTrackAtIndex:self.selectedIndex];
            frame.size.width = [self widthForTrackAtIndex:self.selectedIndex];
            self.trackView.frame = frame;
        }];
    }
}

- (void)slidingToDirection:(EHHorizontalFlexibleWidthItemsTrackViewSlideDirection)direction percentage:(CGFloat)percentage {
    [self didSlideView:[self itemViewAtIndex:self.selectedIndex] reactInPercentage:(1 - percentage)];
    
    CGFloat selectedWidth = [self widthForTrackAtIndex:self.selectedIndex];
    CGFloat tempWidth = 0;
    CGFloat selectedX = [self xForTrackAtIndex:self.selectedIndex];
    CGFloat tempX = 0;

    if (direction == EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionNext) {
        tempWidth = [self widthForTrackAtIndex:(self.selectedIndex + 1)];
        
        if (self.selectedIndex != self.layout.itemWidths.count - 1) {
            tempX = [self xForTrackAtIndex:(self.selectedIndex + 1)];
            [self didSlideView:[self itemViewAtIndex:(self.selectedIndex + 1)] reactInPercentage:percentage];
        } else {
            tempX = selectedX + tempWidth + self.layout.interitemSpacing;
        }
    } else {
        tempWidth = [self widthForTrackAtIndex:(self.selectedIndex - 1)];
        
        if (self.selectedIndex != 0) {
            tempX = [self xForTrackAtIndex:(self.selectedIndex - 1)];
            [self didSlideView:[self itemViewAtIndex:(self.selectedIndex - 1)] reactInPercentage:percentage];
        } else {
            tempX = selectedX - (tempWidth + self.layout.interitemSpacing);
        }
    }
    
    CGRect frame = self.trackView.frame;
    frame.origin.x = tempX * percentage + selectedX * (1 - percentage);
    frame.size.width = tempWidth * percentage + selectedWidth * (1 - percentage);
    self.trackView.frame = frame;
}

- (void)slideToDirection:(EHHorizontalFlexibleWidthItemsTrackViewSlideDirection)direction {
    [self didTapView:[self itemViewAtIndex:self.selectedIndex] animateToSelected:NO];

    if (direction == EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionNext) {
        [self didTapView:[self itemViewAtIndex:(self.selectedIndex + 1)] animateToSelected:YES];
        self.selectedIndex += 1;
    } else {
        [self didTapView:[self itemViewAtIndex:(self.selectedIndex - 1)] animateToSelected:YES];
        self.selectedIndex -= 1;
    }
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGRect frame = self.trackView.frame;
        frame.origin.x = [self xForTrackAtIndex:self.selectedIndex];
        frame.size.width = [self widthForTrackAtIndex:self.selectedIndex];
        self.trackView.frame = frame;
    }];
}

- (void)slideBackFromDirection:(EHHorizontalFlexibleWidthItemsTrackViewSlideDirection)direction {
    [self didTapView:[self itemViewAtIndex:self.selectedIndex] animateToSelected:YES];
    
    if (direction == EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionNext) {
        if (self.selectedIndex != self.layout.itemWidths.count - 1) {
            [self didTapView:[self itemViewAtIndex:(self.selectedIndex + 1)] animateToSelected:NO];
        }
    } else {
        if (self.selectedIndex != 0) {
            [self didTapView:[self itemViewAtIndex:(self.selectedIndex - 1)] animateToSelected:NO];
        }
    }

    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGRect frame = self.trackView.frame;
        frame.origin.x = [self xForTrackAtIndex:self.selectedIndex];
        frame.size.width = [self widthForTrackAtIndex:self.selectedIndex];
        self.trackView.frame = frame;
    }];
}

- (void)scrollToMiddleOfFrameForItemViewAtIndex:(NSInteger)index {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat minEffectiveX = width / 2.0f;
    CGFloat maxEffectiveX = [self.layout totalWidth] - width + width / 2.0f;
    
    CGFloat x = [self.layout xForIndex:index] + [self.layout.itemWidths[index] floatValue] / 2.0f;
    CGFloat offsetX = 0;
    
    if (x < minEffectiveX) {
        offsetX = minEffectiveX - width / 2.0f;
    } else if (x > maxEffectiveX) {
        offsetX = maxEffectiveX - width / 2.0f;
    } else {
        offsetX = x - width / 2.0f;
    }
    
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - EHItemViewDelegate

- (void)didTapControl:(UIControl *)control inView:(UIView *)view {
    [self didTapItemAtIndex:view.tag];
}

#pragma mark - event response

- (void)didTapControl:(UIControl *)sender {
    [self didTapItemAtIndex:sender.tag];
}

- (void)didTapView:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self];
    NSInteger index = [self.layout indexForLocation:location];
    
    if (index >= 0 && index < self.layout.itemWidths.count) {
        [self didTapItemAtIndex:index];
    }
}

#pragma mark - private methods

- (void)addToViewWithItems:(NSArray <UIView *> *)items {
    self.contentSize = CGSizeMake([self totalWidth], [self totalHeight]);
    
    for (int i = 0; i < items.count; i++) {
        UIView *itemView = items[i];
        itemView.tag = i;
        itemView.eh_itemViewDelegate = self;
        
        if (itemView.userInteractionEnabled && [itemView respondsToSelector:@selector(addTarget:action:forControlEvents:)]) {
            UIControl *itemControl = (UIControl *)itemView;
            [itemControl addTarget:self action:@selector(didTapControl:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        itemView.frame = CGRectMake([self.layout xForIndex:i],
                                    [self.layout yForIndex:i],
                                    [self.layout.itemWidths[i] floatValue],
                                    self.layout.itemHeight);
        [self addSubview:itemView];
    }
    
    [self addGestureRecognizer:self.tapRecognizer];
}

- (void)addTrackView {
    self.trackView.frame = CGRectMake([self xForTrackAtIndex:self.selectedIndex],
                                      [self.layout totalHeight],
                                      [self widthForTrackAtIndex:self.selectedIndex],
                                      self.trackHeight);
    
    [self addSubview:self.trackView];
}

- (CGFloat)xForTrackAtIndex:(NSInteger)index {
    return [self.layout xForIndex:index] + (1 - self.trackWidthPercent) * [self.layout.itemWidths[index] floatValue] / 2.0f;
}

- (CGFloat)widthForTrackAtIndex:(NSInteger)index {
    NSInteger i = 0;
    if (index >= 0 && index < self.layout.itemWidths.count) {
        i = index;
    } else if (index < 0) {
        i = 0;
    } else {
        i = self.layout.itemWidths.count - 1;
    }
    
    return [self.layout.itemWidths[i] floatValue] * self.trackWidthPercent;
}

- (void)didTapItemAtIndex:(NSInteger)index {
    [self makeIndexSelectedWithAnimation:index];
    
    if ([self.tapDelegate respondsToSelector:@selector(didTapItemAtIndex:inView:)]) {
        [self.tapDelegate didTapItemAtIndex:index inView:self];
    }
}

- (void)didTapView:(UIView <EHItemViewDelegate> *)view toSelected:(BOOL)selected {
    if ([view respondsToSelector:@selector(didTapToSelected:)]) {
        [view didTapToSelected:selected];
    }
}

- (void)didTapView:(UIView <EHItemViewDelegate> *)view animateToSelected:(BOOL)selected {
    if ([view respondsToSelector:@selector(didTapToAnimateToSelected:)]) {
        [view didTapToAnimateToSelected:selected];
    }
}

- (void)didSlideView:(UIView <EHItemViewDelegate> *)view reactInPercentage:(CGFloat)percentage {
    if ([view respondsToSelector:@selector(didReactInPercentage:)]) {
        [view didReactInPercentage:percentage];
    }
}

- (UIView <EHItemViewDelegate> *)itemViewAtIndex:(NSInteger)index {
    UIView *itemView = [self viewWithTag:index];
    
    // if it's myself, find it in my subviews
    if ([self isEqual:itemView]) {
        for (UIView *subView in self.subviews) {
            itemView = [subView viewWithTag:index];
            
            if (itemView) {
                break;
            }
        }
    }
    
    return (UIView <EHItemViewDelegate> *)itemView;
}

#pragma mark - getters & setters

- (void)setTrackWidthPercent:(CGFloat)trackWidthPercent {
    if (trackWidthPercent < 0 || trackWidthPercent > 1.0f) {
        return;
    }
    
    _trackWidthPercent = trackWidthPercent;
    
    CGRect frame = _trackView.frame;
    frame.origin.x = [self xForTrackAtIndex:self.selectedIndex];
    frame.size.width = [self widthForTrackAtIndex:self.selectedIndex];
    _trackView.frame = frame;
}

- (void)setTrackCornerRadius:(CGFloat)trackCornerRadius {
    _trackCornerRadius = trackCornerRadius;
    _trackView.layer.cornerRadius = trackCornerRadius;
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    _trackView.backgroundColor = trackColor;
}

- (UIView *)trackView {
    if (!_trackView) {
        _trackView = [[UIView alloc] init];
        _trackView.clipsToBounds = YES;
        _trackView.layer.cornerRadius = _trackCornerRadius;
        _trackView.backgroundColor = _trackColor;
    }
    
    return _trackView;
}

- (UITapGestureRecognizer *)tapRecognizer {
    if (!_tapRecognizer) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    }
    
    return _tapRecognizer;
}

@end
