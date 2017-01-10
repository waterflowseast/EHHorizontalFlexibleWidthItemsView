//
//  EHHorizontalFlexibleWidthLayout.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/16.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHHorizontalFlexibleWidthLayout : NSObject

@property (nonatomic, strong, readonly) NSArray <NSNumber *> *itemWidths;
@property (nonatomic, assign, readonly) CGFloat itemHeight;

@property (nonatomic, assign, readonly) UIEdgeInsets insets;
@property (nonatomic, assign, readonly) CGFloat interitemSpacing;

- (instancetype)initWithItemWidths:(NSArray <NSNumber *> *)itemWidths itemHeight:(CGFloat)itemHeight insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (CGFloat)totalHeight;
- (CGFloat)totalWidth;

- (CGFloat)xForIndex:(NSInteger)index;
- (CGFloat)yForIndex:(NSInteger)index;

- (NSInteger)indexForLocation:(CGPoint)location;

@end
