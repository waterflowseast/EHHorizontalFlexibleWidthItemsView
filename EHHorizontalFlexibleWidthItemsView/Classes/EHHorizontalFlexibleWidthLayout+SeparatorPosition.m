//
//  EHHorizontalFlexibleWidthLayout+SeparatorPosition.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/22.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFlexibleWidthLayout+SeparatorPosition.h"

@implementation EHHorizontalFlexibleWidthLayout (SeparatorPosition)

- (CGFloat)centerXForSeparatorAtIndex:(NSInteger)index {
    if (index < 1 || index >= self.itemWidths.count) {
        return 0;
    }
    
    return [self xForIndex:index] - self.interitemSpacing / 2.0f;
}

- (CGFloat)centerYForSeparatorAtIndex:(NSInteger)index {
    if (index < 1 || index >= self.itemWidths.count) {
        return 0;
    }
    
    return [self yForIndex:index] + self.itemHeight / 2.0f;
}

@end
