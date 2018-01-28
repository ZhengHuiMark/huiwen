//
//  ZHSearchViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/9.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHSearchViewController.h"

#import "ZHFoucsTableView.h"
#import "ZHFocusButton.h"
#import "ZHAllModel.h"
#import "FreeDetailViewController.h"
#import "ZHRewardDetailViewController.h"
#import "ZHExpertUserInfoHomePageViewController.h"
#import "ZHCaseDetaiPageleViewController.h"
#define kTableViewWidth [UIScreen mainScreen].bounds.size.width

@interface ZHSearchViewController ()<UIScrollViewDelegate>
{
    ZHFocusButton *_selectedButton;
    
}
/**
 承载所有 TableView 的 ScrollView
 */
@property (nonatomic, strong) UIScrollView *tableScrollView;

/**
 承载所有按钮的 ScrollView
 */
@property (nonatomic, strong) UIScrollView *buttonScrollView;

/**
 存放所有按钮标题的数组
 */
@property (nonatomic, strong) NSMutableArray <NSString *>*buttonTitles;

/**
 存放所有按钮的数组
 */
@property (nonatomic, strong) NSMutableArray <ZHFocusButton *>*buttons;

/**
 存放所有 TableView 的字典, key: 按钮标题  value: tableview
 */
@property (nonatomic, strong) NSMutableDictionary <NSString *, ZHFoucsTableView *>*tableViewDict;


@end

@implementation ZHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}


- (void)configUI{
    self.navigationItem.title = @"关注";
    
    UINavigationBar *navBar =self.navigationController.navigationBar;
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        //UIBarMetricsLandscapePhone
        [navBar setBackgroundImage:[UIImage imageNamed:@"顶部背景"] forBarMetrics:UIBarMetricsDefault];
    }
    // 添加一个视图, 添加之后 ScrollView 就不会下移64了.
    UIView *unusedView = [UIView new];
    [self.view addSubview: unusedView];
    
    // Setup scrolle delegates
    self.buttonScrollView.delegate = self;
    self.tableScrollView.delegate = self;
    
    // Setup buttons
    CGFloat maxX = 0;
    NSInteger index=0;
    CGFloat buttonWidth = [UIScreen mainScreen].bounds.size.width / 4.0f;
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
            _selectedButton = button;
            [self getNewTableViewAtIndex: 0 dropMenuData: @[]];
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


#pragma mark - Private methods
- (ZHFoucsTableView *)getNewTableViewAtIndex:(NSInteger)index dropMenuData:(NSArray <NSArray <id <ZHDropMenuProtocol>>*>*)dropMenuData {
    
    // Caculate frame
    CGRect frame = (CGRect){index*kTableViewWidth, 0, self.tableScrollView.frame.size.width, self.tableScrollView.frame.size.height};
    
    // New table view
    ZHFoucsTableView *tableView = [ZHFoucsTableView tableViewWithDropMenu: dropMenuData frame: frame inView: self.tableScrollView];
    tableView.content = self.content;
    tableView.requestType = index;
    
//    
    tableView.FocusCellSelectPush = ^(ZHAllModel *model){
        
        if (model.rewardAskId && model.rewardAskId.length) {
            ZHRewardDetailViewController *FDeetailVc = [[ZHRewardDetailViewController alloc]init];
            
            FDeetailVc.uidStringz = model.rewardAskId ;
            
            [self.navigationController pushViewController:FDeetailVc animated:YES];
            
        }else if (model.freeAskId && model.freeAskId.length){
            
            FreeDetailViewController *FDeetailVc = [[FreeDetailViewController alloc]init];
            
            FDeetailVc.uidString = model.freeAskId ;
            
            [self.navigationController pushViewController:FDeetailVc animated:YES];
            
        }else if (model.expertId && model.expertId.length){
            
            ZHExpertUserInfoHomePageViewController  *expertVc = [[ZHExpertUserInfoHomePageViewController alloc]init];
            
            expertVc.expertID = model.expertId;
            
            [self.navigationController pushViewController:expertVc animated:YES];
            
        }
        else if (model.caseId && model.caseId.length){
            
            ZHCaseDetaiPageleViewController *caseDetailVc = [[ZHCaseDetaiPageleViewController alloc]init];
            caseDetailVc.urlId =    model.caseId;
            caseDetailVc.time = model.readingTime;
            caseDetailVc.title = model.title;
            caseDetailVc.words = model.words;
            
            [self.navigationController pushViewController:caseDetailVc animated:YES];

        }

        
//
    };
//
    // Add table view to dictionary
    [self.tableViewDict setObject: tableView forKey: _selectedButton.title];
    
    return tableView;
}

- (ZHFoucsTableView *)getNewTableViewAtIndex:(NSInteger)index {
    return [self getNewTableViewAtIndex: index
                           dropMenuData: nil];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.tableScrollView) {
        if (![self.tableViewDict.allKeys containsObject: _selectedButton.title]) {
            [self getNewTableViewAtIndex: _selectedButton.tag dropMenuData:@[]];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.tableScrollView && !decelerate) {
        
        NSInteger index= scrollView.contentOffset.x / kTableViewWidth;
        _selectedButton.selected = NO;
        _selectedButton = self.buttons[index];
        _selectedButton.selected = YES;
        
        if (![self.tableViewDict.allKeys containsObject: _selectedButton.title]) {
            [self getNewTableViewAtIndex: _selectedButton.tag];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index= scrollView.contentOffset.x / kTableViewWidth;
    _selectedButton.selected = NO;
    _selectedButton = self.buttons[index];
    _selectedButton.selected = YES;
    
    if (![self.tableViewDict.allKeys containsObject: _selectedButton.title]) {
        [self getNewTableViewAtIndex: _selectedButton.tag];
    }
}

#pragma mark - Lazy load
- (UIScrollView *)tableScrollView {
    
    if (!_tableScrollView) {
        _tableScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, kButtonHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - kButtonHeight)];
        _tableScrollView.pagingEnabled = YES;
        [self.view addSubview: _tableScrollView];
    }
    return _tableScrollView;
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

- (NSMutableDictionary<NSString *,ZHFoucsTableView *> *)tableViewDict {
    if (!_tableViewDict) {
        _tableViewDict = [NSMutableDictionary new];
    }
    return _tableViewDict;
}


@end
