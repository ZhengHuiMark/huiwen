//
//  ZHSearchDetailViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHSearchDetailViewController.h"
#import "ZHFocusButton.h"
#import "ZHFoucsTableView.h"

#define kTableViewWidth [UIScreen mainScreen].bounds.size.width
@interface ZHSearchDetailViewController ()<UIScrollViewDelegate>{
    ZHFocusButton *_selectedButton;
    
}

/**
 存放所有按钮的数组
 */
@property (nonatomic, strong) NSMutableArray <ZHFocusButton *>*buttons;

/**
 存放所有按钮标题的数组
 */
@property (nonatomic, strong) NSMutableArray <NSString *>*buttonTitles;

/**
 承载所有 TableView 的 ScrollView
 */
@property (nonatomic, strong) UIScrollView *tableScrollView;

/**
 承载所有按钮的 ScrollView
 */
@property (nonatomic, strong) UIScrollView *buttonScrollView;



@end

@implementation ZHSearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI{
    
    // 添加一个视图, 添加之后 ScrollView 就不会下移64了.
    UIView *unusedView = [UIView new];
    [self.view addSubview: unusedView];
    
    // Setup scrolle delegates
    self.buttonScrollView.delegate = self;
    self.tableScrollView.delegate = self;
    
    // Setup buttons
    CGFloat maxX = 0;
    NSInteger index=0;
    CGFloat buttonWidth = [UIScreen mainScreen].bounds.size.width / 3.0f;
    for (NSString *buttonTitle in self.buttonTitles) {
        
        // Create button
        CGPoint origin = CGPointMake(maxX, 0);
        ZHFocusButton *button = [ZHFocusButton buttonWithTitle: buttonTitle
                                                        origin: origin
                                                        inView: self.buttonScrollView];
        button.buttonAction = ^(ZHFocusButton *button){
            _selectedButton.selected = NO;
            _selectedButton = button;
            _selectedButton.selected = YES;
            [self.tableScrollView setContentOffset: CGPointMake(kTableViewWidth * button.tag,  0) animated: YES];
        };
        button.tag = index;
        button.selected = index==0;
        [self.buttons addObject: button];
        
        // Change button width
        button.frame = (CGRect){button.frame.origin, {buttonWidth, button.frame.size.height}};
        
        // Save first button
        if (index==0) {
//            _selectedButton = button;
//            [self getNewTableViewAtIndex: 0 dropMenuData: @[]];
        }
        
        // Configure frame and index
        maxX+=button.frame.size.width;
        index++;
    }
    
    // Setup button scroll view content size
    self.buttonScrollView.contentSize = CGSizeMake(maxX, 0);
    
    // Setup table scroll view content size
    self.tableScrollView.contentSize = CGSizeMake(kTableViewWidth * self.buttonTitles.count,  0);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.tableScrollView && !decelerate) {
        
        NSInteger index= scrollView.contentOffset.x / kTableViewWidth;
        _selectedButton.selected = NO;
        _selectedButton = self.buttons[index];
        _selectedButton.selected = YES;

    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index= scrollView.contentOffset.x / kTableViewWidth;
    _selectedButton.selected = NO;
    _selectedButton = self.buttons[index];
    _selectedButton.selected = YES;

}

- (UIScrollView *)buttonScrollView {
    
    if (!_buttonScrollView) {
        _buttonScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kButtonHeight)];
        _buttonScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview: _buttonScrollView];
    }
    return _buttonScrollView;
}

- (NSMutableArray<NSString *> *)buttonTitles {
    if (!_buttonTitles) {
        _buttonTitles = [NSMutableArray arrayWithArray: @[@"悬赏问", @"免费问", @"专家",@"案例"]];
    }
    return _buttonTitles;
}

- (NSMutableArray<ZHFocusButton *> *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}




@end
