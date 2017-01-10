//
//  EHHorizontalFlexibleWidthLayout.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/16.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFlexibleWidthLayout.h"

@interface EHHorizontalFlexibleWidthLayout ()

@property (nonatomic, strong, readwrite) NSArray <NSNumber *> *itemWidths;
@property (nonatomic, assign, readwrite) CGFloat itemHeight;

@property (nonatomic, assign, readwrite) UIEdgeInsets insets;
@property (nonatomic, assign, readwrite) CGFloat interitemSpacing;

@property (nonatomic, strong) NSMutableArray *xs;

@end

@implementation EHHorizontalFlexibleWidthLayout

- (instancetype)initWithItemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    self = [super init];
    if (self) {
        _itemWidths = [itemWidths copy];
        _itemHeight = itemHeight;
        _insets = insets;
        _interitemSpacing = interitemSpacing;
        
        [self calculateValues];
    }
    
    return self;
}

- (CGFloat)totalHeight {
    return self.insets.top + self.itemHeight + self.insets.bottom;
}

- (CGFloat)totalWidth {
    CGFloat width = self.insets.left + self.insets.right + (self.itemWidths.count - 1) * self.interitemSpacing;
    
    for (int i = 0; i < self.itemWidths.count; i++) {
        width += [self.itemWidths[i] floatValue];
    }
    
    return width;
}

- (CGFloat)xForIndex:(NSInteger)index {
    if (index >= 0 && index < self.xs.count) {
        return [self.xs[index] floatValue];
    }
    
    return self.insets.left;
}

- (CGFloat)yForIndex:(NSInteger)index {
    return self.insets.top;
}

- (NSInteger)indexForLocation:(CGPoint)location {
    for (int i = 0; i < self.itemWidths.count; i++) {
        if (location.x >= [self.xs[i] floatValue] &&
            location.x <= [self.xs[i] floatValue] + [self.itemWidths[i] floatValue] &&
            location.y >= self.insets.top &&
            location.y <= self.insets.top + self.itemHeight) {
            
            return i;
        }
    }
    
    return -1;
}

#pragma mark - private methods

- (void)calculateValues {
    CGFloat currentX = _insets.left;
    
    for (int i = 0; i < _itemWidths.count; i++) {
        [self.xs addObject:@(currentX)];
        currentX += [_itemWidths[i] floatValue] + _interitemSpacing;
    }
}

#pragma mark - getters & setters

- (NSMutableArray *)xs {
    if (!_xs) {
        _xs = [NSMutableArray arrayWithCapacity:10];
    }
    
    return _xs;
}

@end
