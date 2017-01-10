//
//  EHDemo2ViewController.m
//  EHHorizontalFlexibleWidthItemsView
//
//  Created by Eric Huang on 17/1/10.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHDemo2ViewController.h"
#import <Masonry/Masonry.h>
#import <EHHorizontalFlexibleWidthItemsView/EHHorizontalFlexibleWidthItemsSelectionView.h>
#import "WFELabel.h"

static CGFloat const kLabelHeight = 30.0f;
static CGFloat const kMinimumInteritemSpacing = 20.0f;

@interface EHDemo2ViewController () <EHHorizontalFlexibleWidthItemsViewDelegate, EHItemViewSelectionDelegate>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *flexibleLabels;
@property (nonatomic, strong) NSArray *flexibleWidths;
@property (nonatomic, strong) EHHorizontalFlexibleWidthItemsSelectionView *flexibleView;

@end

@implementation EHDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureForNavigationBar];
    [self configureForViews];
    
    [self.view addSubview:self.flexibleView];
    [self.flexibleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo([self.flexibleView totalHeight]);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - EHHorizontalFlexibleWidthItemsViewDelegate

- (void)didTapItemAtIndex:(NSInteger)index inView:(UIView *)view {
    NSLog(@"===> index: %ld, word: %@", (long)index, self.words[index]);
}

#pragma mark - EHItemViewSelectionDelegate

- (void)didTapExceedingLimitInView:(UIView *)view maxSelectionsAllowed:(NSUInteger)maxSelectionsAllowed {
    NSLog(@"===> exceeding max: %ld", (long)maxSelectionsAllowed);
}

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"EHHorizontalFlexibleWidthItemsSelectionView";
}

- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - getters & setters

- (NSArray *)words {
    if (!_words) {
        _words = @[
                   @"照片", @"拍摄", @"小视频", @"视频聊天",
                   @"红包", @"转账", @"位置", @"收藏",
                   @"个人名片", @"语音输入", @"卡券"
                   ];
    }
    
    return _words;
}

- (NSArray *)flexibleLabels {
    if (!_flexibleLabels) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            WFELabel *label = [[WFELabel alloc] initWithText:self.words[i]];
            
            [mutableArray addObject:label];
        }
        
        _flexibleLabels = [mutableArray copy];
    }
    
    return _flexibleLabels;
}

- (NSArray *)flexibleWidths {
    if (!_flexibleWidths) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            CGSize size = [self.words[i] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}];
            [mutableArray addObject:@(size.width * 3)];
        }
        
        _flexibleWidths = [mutableArray copy];
    }
    
    return _flexibleWidths;
}

- (EHHorizontalFlexibleWidthItemsSelectionView *)flexibleView {
    if (!_flexibleView) {
        _flexibleView = [[EHHorizontalFlexibleWidthItemsSelectionView alloc] initWithItems:self.flexibleLabels itemWidths:self.flexibleWidths itemHeight:kLabelHeight insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kMinimumInteritemSpacing];
        _flexibleView.allowsAnimationWhenTap = YES;
        _flexibleView.animationDuration = 0.4f;
        _flexibleView.allowsMultipleSelection = YES;
        _flexibleView.maxSelectionsAllowed = 3;
        
        _flexibleView.animationBlock = ^(UIView *itemView, NSTimeInterval animationDuration, EHAnimationCompletionBlock animationCompletion) {
            [UIView
             animateKeyframesWithDuration:animationDuration
             delay:0
             options:UIViewKeyframeAnimationOptionCalculationModeLinear
             animations:^{
                 [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
                     itemView.transform = CGAffineTransformMakeTranslation(0, -5.0f);
                 }];
                 
                 [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.4 animations:^{
                     itemView.transform = CGAffineTransformMakeTranslation(0, 5.0f);
                 }];
                 
                 [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
                     itemView.transform = CGAffineTransformMakeTranslation(0, 0);
                 }];
             } completion:animationCompletion];
        };
        
        _flexibleView.tapDelegate = self;
        _flexibleView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    }
    
    return _flexibleView;
}

@end
