//
//  EHDemo1ViewController.m
//  EHHorizontalFlexibleWidthItemsView
//
//  Created by Eric Huang on 17/1/10.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHDemo1ViewController.h"
#import <Masonry/Masonry.h>
#import <YYCategories/UIImage+YYAdd.h>
#import <EHHorizontalFlexibleWidthItemsView/EHHorizontalFlexibleWidthItemsView.h>
#import <EHHorizontalFlexibleWidthItemsView/EHHorizontalFlexibleWidthItemsSeparatorView.h>
#import "EHCenteredButton.h"
#import "WFEButtontitleView.h"

static CGFloat const kLabelHeight = 30.0f;
static CGFloat const kButtonHeight = 80.0f;
static CGFloat const kMinimumInteritemSpacing = 20.0f;
static CGFloat const kCornerRadius = 3.0f;
static CGFloat const kSeparatorMinimumInteritemSpacing = 40.0f;
static CGFloat const kSeparatorWidth = 2.0f;
static CGFloat const kSeparatorHeight = 16.0f;

@interface EHDemo1ViewController () <EHHorizontalFlexibleWidthItemsViewDelegate>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *widths;

@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) NSArray *separatorLabels;

@property (nonatomic, strong) EHHorizontalFlexibleWidthItemsView *labelsView;
@property (nonatomic, strong) EHHorizontalFlexibleWidthItemsView *buttonsView;
@property (nonatomic, strong) EHHorizontalFlexibleWidthItemsView *viewsView;
@property (nonatomic, strong) EHHorizontalFlexibleWidthItemsSeparatorView *separatorLabelsView;

@end

@implementation EHDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureForNavigationBar];
    [self configureForViews];
    
    [self.view addSubview:self.labelsView];
    [self.labelsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo([self.labelsView totalHeight]);
    }];
    
    [self.view addSubview:self.buttonsView];
    [self.buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.labelsView.mas_bottom).offset(30.0f);
        make.height.mas_equalTo([self.buttonsView totalHeight]);
    }];
    
    [self.view addSubview:self.viewsView];
    [self.viewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.buttonsView.mas_bottom).offset(30.0f);
        make.height.mas_equalTo([self.viewsView totalHeight]);
    }];
    
    [self.view addSubview:self.separatorLabelsView];
    [self.separatorLabelsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.viewsView.mas_bottom).offset(30.0f);
        make.height.mas_equalTo([self.separatorLabelsView totalHeight]);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - EHHorizontalFlexibleWidthItemsViewDelegate

- (void)didTapItemAtIndex:(NSInteger)index inView:(EHHorizontalFlexibleWidthItemsView *)view {
    NSArray *viewNames = @[
                           @"labelsView", @"buttonsView", @"viewsView", @"separatorLabelsView"
                           ];

    NSLog(@"===> %@ index: %ld, word: %@", viewNames[view.tag], (long)index, self.words[index]);
}

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"EHHorizontalFlexibleWidthItemsView & EHHorizontalFlexibleWidthItemsSeparatorView";
}

- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIColor *)randomColor {
    NSArray *colors = @[
                        [UIColor lightGrayColor],
                        [UIColor grayColor],
                        [UIColor darkGrayColor],
                        [UIColor blackColor]
                        ];
    return colors[arc4random_uniform(4)];
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

- (NSArray *)labels {
    if (!_labels) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.text = self.words[i];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [self randomColor];
            label.clipsToBounds = YES;
            label.layer.cornerRadius = kCornerRadius;
            label.font = [UIFont systemFontOfSize:13.0f];
            label.textAlignment = NSTextAlignmentCenter;
            
            [mutableArray addObject:label];
        }
        
        _labels = [mutableArray copy];
    }
    
    return _labels;
}

- (NSArray *)buttons {
    if (!_buttons) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            EHCenteredButton *button = [EHCenteredButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:self.words[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"down-arrow"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:[self randomColor]] forState:UIControlStateNormal];
            button.clipsToBounds = YES;
            button.verticalSpace = 8.0f;
            button.layer.cornerRadius = kCornerRadius;
            button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            
            [mutableArray addObject:button];
        }
        
        _buttons = [mutableArray copy];
    }
    
    return _buttons;
}

- (NSArray *)views {
    if (!_views) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            WFEButtonTitleView *button = [[WFEButtonTitleView alloc] initWithImage:[UIImage imageNamed:@"down-arrow"] title:self.words[i]];
            button.backgroundColor = [UIColor lightGrayColor];
            
            [mutableArray addObject:button];
        }
        
        _views = [mutableArray copy];
    }
    
    return _views;
}

- (NSArray *)separatorLabels {
    if (!_separatorLabels) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.text = self.words[i];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [self randomColor];
            label.clipsToBounds = YES;
            label.layer.cornerRadius = kCornerRadius;
            label.font = [UIFont systemFontOfSize:13.0f];
            label.textAlignment = NSTextAlignmentCenter;
            
            [mutableArray addObject:label];
        }
        
        _separatorLabels = [mutableArray copy];
    }
    
    return _separatorLabels;
}

- (EHHorizontalFlexibleWidthItemsView *)labelsView {
    if (!_labelsView) {
        _labelsView = [[EHHorizontalFlexibleWidthItemsView alloc] initWithItems:self.labels itemWidths:self.widths itemHeight:kLabelHeight insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kMinimumInteritemSpacing];
        _labelsView.allowsAnimationWhenTap = YES;
        _labelsView.animationDuration = 0.4f;
        _labelsView.tapDelegate = self;
        _labelsView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
        _labelsView.tag = 0;
    }
    
    return _labelsView;
}

- (EHHorizontalFlexibleWidthItemsView *)buttonsView {
    if (!_buttonsView) {
        _buttonsView = [[EHHorizontalFlexibleWidthItemsView alloc] initWithItems:self.buttons itemWidths:self.widths itemHeight:kButtonHeight insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kMinimumInteritemSpacing];
        _buttonsView.allowsAnimationWhenTap = YES;
        _buttonsView.animationDuration = 0.4f;
        _buttonsView.tapDelegate = self;
        _buttonsView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
        _buttonsView.tag = 1;
    }
    
    return _buttonsView;
}

- (EHHorizontalFlexibleWidthItemsView *)viewsView {
    if (!_viewsView) {
        _viewsView = [[EHHorizontalFlexibleWidthItemsView alloc] initWithItems:self.views itemWidths:self.widths itemHeight:kButtonHeight insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kMinimumInteritemSpacing];
        _viewsView.allowsAnimationWhenTap = YES;
        _viewsView.animationDuration = 0.4f;
        _viewsView.tapDelegate = self;
        _viewsView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
        _viewsView.tag = 2;
    }
    
    return _viewsView;
}

- (EHHorizontalFlexibleWidthItemsSeparatorView *)separatorLabelsView {
    if (!_separatorLabelsView) {
        UIColor *separatorColor = [UIColor lightGrayColor];
        _separatorLabelsView = [[EHHorizontalFlexibleWidthItemsSeparatorView alloc] initWithItems:self.separatorLabels itemWidths:self.widths itemHeight:kLabelHeight insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kSeparatorMinimumInteritemSpacing separatorSize:CGSizeMake(kSeparatorWidth, kSeparatorHeight) separatorColor:separatorColor];
        _separatorLabelsView.allowsAnimationWhenTap = YES;
        _separatorLabelsView.animationDuration = 0.4f;
        _separatorLabelsView.tapDelegate = self;
        _separatorLabelsView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
        _separatorLabelsView.tag = 3;
    }
    
    return _separatorLabelsView;
}

@end
