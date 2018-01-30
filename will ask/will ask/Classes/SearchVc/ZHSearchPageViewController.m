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
    
//    [self setupNavigationItemTitleView];
//    if (_selectedSeachBtnStr != nil && _selectedSeachBtnStr.length >0) {
//        self.searchTextField.text = _selectedSeachBtnStr;
//        self.searchTextField.placeholder = _textPlaceholderStr;
//    }
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    
    [self setUpTableView];
    [self setupNavigationItemTitleView];
}

- (void)setupNavigationItemTitleView {
    
    UIView *navview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SafeAreaTopHeight)];
    navview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navview];
    
    UITextField *seachText = [[UITextField alloc] init]; //WithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, 30)];
    seachText.font = [UIFont systemFontOfSize:14];
    seachText.backgroundColor = [UIColor colorWithR:245 G:245 B:245 alpha:1];
    seachText.borderStyle = UITextBorderStyleRoundedRect;
//    seachText.layer.cornerRadius = 15.0f;
//    seachText.layer.masksToBounds = YES;
    seachText.placeholder = _textPlaceholderStr;
    [seachText addTarget:self action:@selector(textFieldChangeAction) forControlEvents:UIControlEventEditingChanged];
    self.searchTextField = seachText;
    [navview addSubview:seachText];
    [seachText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navview.mas_centerY).offset(10);
        make.centerX.equalTo(navview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, 30));
    }];
    
    UIButton *seachBtn = [UIButton ButtonWithTitle:@"搜索" fontSize:13 normalColor:[UIColor colorWithR:132 G:132 B:132 alpha:1] selectedColor:nil Target:self Action:@selector(rightBarSeachClickAction)];
    seachBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [navview addSubview:seachBtn];
    [seachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(seachText.mas_centerY);
        make.left.equalTo(seachText.mas_right);
        make.right.equalTo(navview.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *backBtn = [UIButton ButtonWithNormalImage:@"return1" selectedImage:nil Target:self Action:@selector(bacckButtonClickAction)];
    [navview addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(seachText.mas_centerY);
        make.left.equalTo(navview.mas_left);
        make.right.equalTo(seachText.mas_left).offset(-10);
        make.height.mas_equalTo(30);
    }];
}

- (void) bacckButtonClickAction {
    [self.navigationController popViewControllerAnimated:YES];
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
        make.top.equalTo(self.view.mas_top).offset(SafeAreaTopHeight);
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

    ZHSearchViewController *searchVc = [[ZHSearchViewController alloc]init];
    searchVc.content = [NSString stringWithFormat:@"%@",_textPlaceholderStr];
    [self.navigationController pushViewController:searchVc animated:YES];
    NSLog(@"跳转搜索结果");
}

- (void)textFieldChangeAction {
    
    NSLog(@"textFieldChangeAction");
}


@end
