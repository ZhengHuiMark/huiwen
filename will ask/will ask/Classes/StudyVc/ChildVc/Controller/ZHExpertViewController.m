

//
//  ZHExpertViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/11/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertViewController.h"
#import "ZHSearchTableViewCell.h"
#import "ZHExpertTodayTableViewCell.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "YYModel.h"
#import "ZHStudyModel.h"
#import "BtnColorModel.h"
#import "ZHButton.h"

typedef NS_ENUM(NSUInteger, EnumASCTypes) {
    EnumASCTypesNone = 0,
    EnumASCTypesSheng,
    EnumASCTypesJiang
};


static NSString *SearchCellid = @"SearchCellid";

static NSString *ExpertsCellid = @"ExpertsCellid";

@interface ZHExpertViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ZHButton *_selectedButton;
    AModel *model1;

}

@property (nonatomic, assign) EnumASCTypes ASCType; // 排序方式


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray <ZHStudyModel *> *studyModels;

@property(nonatomic,strong)UIButton *answerFirstBtn;

@property(nonatomic,strong)UIButton *consultingBtn;

@property(nonatomic,strong)UIButton *releaseCaseBtn;

@property(nonatomic,strong)BtnColorModel *model;

@property(nonatomic,strong)UIButton *tempBtn;


/**
 存放所有按钮标题的数组
 */
@property (nonatomic, strong) NSMutableArray <NSString *>*buttonTitles;


/**
 存放所有按钮的数组
 */
@property (nonatomic, strong) NSMutableArray <ZHButton *>*buttons;

@end

@implementation ZHExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    
    [self.view addSubview:self.tableView];
    
}



- (void)loadData{
    
    //   /api/learning/column/getExpertList
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getExpertList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        
        NSLog(@"response = %@",response);
        
        _studyModels = [NSArray yy_modelArrayWithClass:[ZHStudyModel class] json:response[@"data"]];
        
        [self.tableView reloadData];
    }];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView * view = nil;
    
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc] init];
//        headerView.autoresizesSubviews = NO;
        headerView.clipsToBounds = YES;
        headerView.backgroundColor = [UIColor whiteColor];
        
        
        NSArray * array = [NSArray arrayWithObjects:@"抢答",@"接受咨询",@"发布案例", nil];

        for (NSInteger i = 0; i < 3; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(self.view.frame.size.width /3 *i, 0, self.view.frame.size.width/3, 50);
            btn.tag = i;
            btn.backgroundColor = [UIColor colorWithWhite:100*i alpha:0];
            
            [btn addTarget:self action:@selector(btnActions:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:btn];
            [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           
        }

        _tempBtn = nil;
        
        
        // 线
        UIView * lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 1);
        lineView.backgroundColor = [UIColor yellowColor];
        
        [headerView addSubview:lineView];
     
        
        return headerView;
        
        
    }
    
    
    
    return view;
    
    
}


- (void)btnActions:(UIButton *)sender{
    
    NSInteger tag = sender.tag;
    

    if (tag == 0 && _ASCType == EnumASCTypesSheng) { //抢答
        sender.selected = YES;
        _ASCType = EnumASCTypesJiang;
        
        
//        [self requestFromNetworkWithOrder:@"vieAnswerNumber" asc:true];
        sender.backgroundColor = [UIColor whiteColor];

    }else if (tag == 0 && _ASCType == EnumASCTypesJiang ) {
        
        sender.selected = YES;
        _ASCType = EnumASCTypesSheng;
//        [self requestFromNetworkWithOrder:@"vieAnswerNumber" asc:false];

        sender.backgroundColor = [UIColor whiteColor];
    }else if (tag == 0 && _ASCType == EnumASCTypesNone){
        
        sender.selected = YES;
        _ASCType = EnumASCTypesSheng;
        
        sender.backgroundColor = [UIColor whiteColor];
    }
    
    if (tag == 1 && _ASCType == EnumASCTypesSheng) {
        
        sender.selected = YES;
        _ASCType = EnumASCTypesJiang;

        sender.backgroundColor = [UIColor whiteColor];
        
    }else if (tag == 1 && _ASCType == EnumASCTypesJiang && (tag != 0) | 3) {
        
        
        
        sender.selected = YES;
        _ASCType = EnumASCTypesSheng;
        sender.backgroundColor = [UIColor whiteColor];
    }else if (tag == 1 && _ASCType == EnumASCTypesNone){
        
        sender.selected = YES;
        _ASCType = EnumASCTypesSheng;
        
        sender.backgroundColor = [UIColor whiteColor];
    }
    if (tag == 2 && _ASCType == EnumASCTypesSheng) {
        
        sender.selected = YES;
        _ASCType = EnumASCTypesJiang;
        
        sender.backgroundColor = [UIColor whiteColor];
        
    }else if (tag == 2 && _ASCType == EnumASCTypesJiang && (tag != 0) | 3) {
        
        
        
        sender.selected = YES;
        _ASCType = EnumASCTypesSheng;
        sender.backgroundColor = [UIColor whiteColor];
    }else if (tag == 2 && _ASCType == EnumASCTypesNone){
        
        sender.selected = YES;
        _ASCType = EnumASCTypesSheng;
        
        sender.backgroundColor = [UIColor whiteColor];
    }
   
    
    if(_tempBtn == sender) {
        //上次点击过的按钮，不做处理
    } else{
        //本次点击的按钮设为红色
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //将上次点击过的按钮设为黑色
        [_tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    _tempBtn = sender;
    
}


- (void)requestFromNetworkWithOrder:(NSString *)order asc:(BOOL)asc {

    
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: order
            forKey: @"order"];
    [dic setObject: @(asc)
            forKey: @"asc"];

    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getExpertList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        
        NSLog(@"response = %@",response);
        
        _studyModels = [NSArray yy_modelArrayWithClass:[ZHStudyModel class] json:response[@"data"]];
        
        [self.tableView reloadData];
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 44;
    }

    
    return 160;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
    
        return 0.1;
    }
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 10;
        case 1:
            return 20;
//        case 2:
//            return 20;
    }
    return 0;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    return _studyModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCellid forIndexPath:indexPath];
        
        return cell;
        
    }
    
    if (indexPath.section == 1) {
        
        _studyModel = _studyModels[indexPath.row];
     
        ZHExpertTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid forIndexPath:indexPath];
     
        cell.model =  _studyModel;
        
        return  cell;
        
    }
    
    
    
    return cell;

}

- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        

        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHSearchTableViewCell" bundle:nil] forCellReuseIdentifier:SearchCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertTodayTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
        
//        [_tableView registerNib:[UINib nibWithNibName:@"ZHIntroductionTableViewCell" bundle:nil] forCellReuseIdentifier:IntroductionCellid];
        
//        [_tableView registerNib:[UINib nibWithNibName:@"ZHTypeTableViewCell" bundle:nil] forCellReuseIdentifier:typeCellid];
    }
    
    return _tableView;
}


- (NSMutableArray<NSString *> *)buttonTitles {
    if (!_buttonTitles) {
        _buttonTitles = [NSMutableArray arrayWithArray: @[@"抢答", @"接受咨询", @"发布案例"]];
    }
    return _buttonTitles;
}

- (NSMutableArray<ZHButton *> *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}




@end
