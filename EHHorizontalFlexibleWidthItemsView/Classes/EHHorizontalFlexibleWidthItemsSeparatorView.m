//
//  EHHorizontalFlexibleWidthItemsSeparatorView.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/22.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFlexibleWidthItemsSeparatorView.h"
#import "EHHorizontalFlexibleWidthLayout+SeparatorPosition.h"

@implementation EHHorizontalFlexibleWidthItemsSeparatorView

- (instancetype)initWithItems:(NSArray<UIView *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor {
    self = [super initWithItems:items itemWidths:itemWidths itemHeight:itemHeight insets:insets interitemSpacing:interitemSpacing];
    if (self) {
        [self drawSeparatorsWithSize:separatorSize color:separatorColor];
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor {
    self = [super initWithItems:items layout:layout];
    if (self) {
        [self drawSeparatorsWithSize:separatorSize color:separatorColor];
    }
    
    return self;
}

- (void)resetWithItems:(NSArray<UIView *> *)items itemWidths:(NSArray<NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor {
    [super resetWithItems:items itemWidths:itemWidths itemHeight:itemHeight insets:insets interitemSpacing:interitemSpacing];
    [self drawSeparatorsWithSize:separatorSize color:separatorColor];
}

- (void)resetWithItems:(NSArray<UIView *> *)items layout:(EHHorizontalFlexibleWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor {
    [super resetWithItems:items layout:layout];
    [self drawSeparatorsWithSize:separatorSize color:separatorColor];
}

#pragma mark - private methods

- (void)drawSeparatorsWithSize:(CGSize)size color:(UIColor *)color {
    for (int i = 1; i < self.layout.itemWidths.count; i++) {
        UIView *separator = [[UIView alloc] init];
        separator.backgroundColor = color;
        separator.tag = -1;

        separator.frame = CGRectMake(
            [self.layout centerXForSeparatorAtIndex:i] - size.width / 2.0f,
            [self.layout centerYForSeparatorAtIndex:i] - size.height / 2.0f,
            size.width,
            size.height);

        [self addSubview:separator];
    }
}

@end
