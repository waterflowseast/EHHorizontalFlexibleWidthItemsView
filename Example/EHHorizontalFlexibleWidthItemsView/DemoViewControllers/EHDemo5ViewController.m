//
//  EHDemo5ViewController.m
//  EHHorizontalFlexibleWidthItemsView
//
//  Created by Eric Huang on 17/2/20.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHDemo5ViewController.h"
#import <Masonry/Masonry.h>
#import <EHHorizontalFlexibleWidthItemsView/EHHorizontalFlexibleWidthItemsTrackView.h>
#import <EHHorizontalFlexibleWidthItemsView/EHHorizontalFlexibleWidthLayout.h>
#import "WFEPercentageLabel.h"

static CGFloat const kLabelHeight = 30.0f;
static CGFloat const kMinimumInteritemSpacing = 20.0f;
static CGFloat const kTrackHeight = 6.0f;
static CGFloat const kTrackWidthPercent = 0.3f;

@interface EHDemo5ViewController () <EHHorizontalFlexibleWidthItemsTrackViewDelegate>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *widths;
@property (nonatomic, strong) NSArray *flexibleLabels;
@property (nonatomic, strong) EHHorizontalFlexibleWidthItemsTrackView *flexibleView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation EHDemo5ViewController

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"changeTrack" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"you can pan to slide";
    label.textColor = [UIColor grayColor];
    
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.flexibleView.mas_bottom).offset(100.0f);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - EHHorizontalFlexibleWidthItemsTrackViewDelegate

- (void)didTapItemAtIndex:(NSInteger)index inView:(EHHorizontalFlexibleWidthItemsTrackView *)view {
    NSLog(@"===> index: %ld, word: %@", (long)index, self.words[index]);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.flexibleView scrollToMiddleOfFrameForItemViewAtIndex:index];
    });
}

#pragma mark - event response

- (void)didClickButton {
    self.flexibleView.trackColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    self.flexibleView.trackCornerRadius = arc4random_uniform((int)kTrackHeight/2.0f + 1);
    self.flexibleView.trackWidthPercent = arc4random_uniform(255)/255.0;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    CGFloat translationX = [sender translationInView:sender.view].x;
    EHHorizontalFlexibleWidthItemsTrackViewSlideDirection direction = translationX > 0 ? EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionPrevious : EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionNext;
    CGFloat ratio = fabs(translationX) / CGRectGetWidth([UIScreen mainScreen].bounds);
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        [self.flexibleView slidingToDirection:direction percentage:ratio];
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.flexibleView.selectedIndex == 0 && direction == EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionPrevious) {
            [self.flexibleView slideBackFromDirection:direction];
            [self scrollFixedView];
            return;
        }
        
        if (self.flexibleView.selectedIndex == self.flexibleView.layout.itemWidths.count - 1 && direction == EHHorizontalFlexibleWidthItemsTrackViewSlideDirectionNext) {
            [self.flexibleView slideBackFromDirection:direction];
            [self scrollFixedView];
            return;
        }
        
        if (ratio > 0.5) {
            [self.flexibleView slideToDirection:direction];
        } else {
            [self.flexibleView slideBackFromDirection:direction];
        }
        
        [self scrollFixedView];
    }
}

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"EHHorizontalFlexibleWidthItemsTrackView";
}

- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addGestureRecognizer:self.pan];
}

- (void)scrollFixedView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.flexibleView scrollToMiddleOfFrameForItemViewAtIndex:self.flexibleView.selectedIndex];
    });
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

- (NSArray *)widths {
    if (!_widths) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            CGSize size = [self.words[i] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}];
            [mutableArray addObject:@(size.width * 3)];
        }
        
        _widths = [mutableArray copy];
    }
    
    return _widths;
}

- (NSArray *)flexibleLabels {
    if (!_flexibleLabels) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            WFEPercentageLabel *label = [[WFEPercentageLabel alloc] initWithText:self.words[i]];
            
            [mutableArray addObject:label];
        }
        
        _flexibleLabels = [mutableArray copy];
    }
    
    return _flexibleLabels;
}

- (EHHorizontalFlexibleWidthItemsTrackView *)flexibleView {
    if (!_flexibleView) {
        _flexibleView = [[EHHorizontalFlexibleWidthItemsTrackView alloc] initWithItems:self.flexibleLabels itemWidths:self.widths itemHeight:kLabelHeight insets:UIEdgeInsetsMake(15, 15, 10, 15) interitemSpacing:kMinimumInteritemSpacing trackHeight:kTrackHeight];
        
        _flexibleView.tapDelegate = self;
        _flexibleView.trackWidthPercent = kTrackWidthPercent;
        _flexibleView.trackCornerRadius = kTrackHeight / 2.0f;
        _flexibleView.trackColor = [UIColor blueColor];
        _flexibleView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    }
    
    return _flexibleView;
}

- (UIPanGestureRecognizer *)pan {
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    }
    
    return _pan;
}

@end
