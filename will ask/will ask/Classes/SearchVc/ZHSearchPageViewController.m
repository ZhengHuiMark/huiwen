//
//  ZHSearchPageViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/20.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHSearchPageViewController.h"
#import "historyView.h"
#import "ZHSearchViewController.h"


@interface ZHSearchPageViewController ()

//搜索历史
@property(nonatomic, strong) UIView *historySearchView;

//搜索框
@property(nonatomic, strong) UITextField *searchTextField;

@property(nonatomic, strong) historyView *history;

@end

@implementation ZHSearchPageViewController {
    
//    NSMutableArray *_searchOneDataArray; //键入前
//    NSMutableArray *_searchFuzzyDataArray; //键入时 模糊搜索
//    NSMutableArray *_tmpMArray;
    NSString *_selectedSeachBtnStr; //搜索的商品名称
    NSString *_textPlaceholderStr; //textField的默认值
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupNavigationItemTitleView];
    if (_selectedSeachBtnStr != nil && _selectedSeachBtnStr.length >0) {
        self.searchTextField.text = _selectedSeachBtnStr;
        self.searchTextField.placeholder = _textPlaceholderStr;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    
    [self setUpTableView];
}

- (void)setupNavigationItemTitleView {
    
    UITextField *seachText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, 30)];
    seachText.font = [UIFont systemFontOfSize:14];
    seachText.backgroundColor = [UIColor whiteColor];
    seachText.borderStyle = UITextBorderStyleRoundedRect;
    [seachText addTarget:self action:@selector(textFieldChangeAction) forControlEvents:UIControlEventEditingChanged];
    self.searchTextField = seachText;
    
    self.navigationItem.titleView = seachText;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarSeachClickAction)];
}

- (void)setUpTableView {
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/search/getSearchSettings",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
      
        if (error) {
            NSLog(@"%@",error);
        }
        
        _history.historyMarray = response[@"data"][@"hotWords"];
        _textPlaceholderStr = response[@"data"][@"defaultSearch"];
        self.searchTextField.placeholder = response[@"data"][@"defaultSearch"];
        
    }];
    
    _history = [[historyView alloc] init];

    __weak __typeof(self) weakSelf = self;
    _history.seachTextFieldBlock = ^(NSString *textString){
        
        _selectedSeachBtnStr = textString;
        weakSelf.searchTextField.text = textString;
        [weakSelf.navigationItem.titleView endEditing:YES];
        
        
        ZHSearchViewController *searchVc = [[ZHSearchViewController alloc]init];
        searchVc.content = [NSString stringWithFormat:@"%@",textString];
        
        [weakSelf.navigationController pushViewController:searchVc animated:YES];
        NSLog(@"跳转搜索结果");
        
    };
    
    [self.view addSubview:_history];
    self.historySearchView = _history;
    [_history mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
}

- (void)rightBarSeachClickAction {
    
    [self.navigationItem.titleView endEditing:YES];
    
    if (self.searchTextField.text.length > 0) {
        
        [_history addToHistory: self.searchTextField.text];
    }else {
        self.searchTextField.text = _textPlaceholderStr;
        [_history addToHistory: self.searchTextField.text];
    }

    
    
    NSLog(@"跳转搜索结果");
}

- (void)textFieldChangeAction {
    
    NSLog(@"textFieldChangeAction");
}


@end
