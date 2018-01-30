

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
#import "expertTypeView.h"
#import "ZHSearchPageViewController.h"
#import "ZHExpertUserInfoHomePageViewController.h"

#define kSconfirmBtnArrayName  @"kSconfirmBtnArrayName"


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
    NSInteger pageNo;

    NSString *orderStr;
    BOOL aseBOOL;
}

@property (nonatomic, assign) EnumASCTypes ASCType; // 排序方式


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray <ZHStudyModel *> *studyModels;

@property(nonatomic,strong)NSMutableArray <ZHStudyModel *>*Marry;

@property(nonatomic,strong)UIButton *answerFirstBtn;

@property(nonatomic,strong)UIButton *consultingBtn;

@property(nonatomic,strong)UIButton *releaseCaseBtn;

@property(nonatomic,strong)BtnColorModel *model;

@property(nonatomic,strong)UIButton *tempBtn;

@property(nonatomic,strong)NSArray *arr;

@property(nonatomic, strong) expertTypeView *expert;

@property(nonatomic,strong)NSMutableArray <UIButton *> *buttonArray;

@property(nonatomic,strong)UIButton *allButton;

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
    
    self.title = @"专家";
    // Do any additional setup after loading the view.
    [self loadData];
    [self loadExpertData];
    
    [self.view addSubview:self.tableView];
    
    pageNo = 1;
    orderStr = @"vieAnswerNumber";
    aseBOOL = YES;
}


- (void)loadExpertData{
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    
//    NSString *url = [NSString stringWithFormat:@"%@/api/expert/getExpertTitles",kIP];
    NSString *url = [NSString stringWithFormat:@"%@/api/expert/getCertificationTypes",kIP];

    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        _arr = response[@"data"];
        
        NSLog(@"%@",response);
    }];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = nil;
    
    if (section == 0) {
        
        UIView *headerView = [[UIView alloc] init];
        //        headerView.autoresizesSubviews = NO;
        headerView.clipsToBounds = YES;
        headerView.backgroundColor = [UIColor whiteColor];
        
        _buttonArray = [[NSMutableArray alloc]init]; //将button放到数组里面
//        NSArray * array = [NSArray arrayWithObjects:@"抢答",@"接受咨询",@"发布案例", nil];
//        
//        for (NSInteger i = 0; i < 3; i++) {
//            
//            _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            _allButton.frame = CGRectMake(self.view.frame.size.width /3 *i, 0, self.view.frame.size.width/3, 50);
//            _allButton.tag = i;
//            _allButton.backgroundColor = [UIColor colorWithWhite:100*i alpha:0];
//            
//            [_allButton addTarget:self action:@selector(btnActions:) forControlEvents:UIControlEventTouchUpInside];
//            [headerView addSubview:_allButton];
//            [_allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [_allButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//            _ASCType = EnumASCTypesJiang;
//            
//            [_allButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
//            
//            [_buttonArray addObject:_allButton];
//            
//            if (!i) {
//                _allButton.selected = YES;
//            }
//        }
        
        NSArray * array = [NSArray arrayWithObjects:@"抢答",@"接受咨询", nil];
        
        for (NSInteger i = 0; i < 2; i++) {
            
            _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _allButton.frame = CGRectMake(self.view.frame.size.width /2 *i, 0, self.view.frame.size.width/2, 50);
            _allButton.tag = i;
            _allButton.backgroundColor = [UIColor colorWithWhite:100*i alpha:0];
            
            [_allButton addTarget:self action:@selector(btnActions:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:_allButton];
            [_allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_allButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            _ASCType = EnumASCTypesJiang;
            
            [_allButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            
            [_buttonArray addObject:_allButton];
            
            if (!i) {
                _allButton.selected = YES;
            }
        }

        // 线
        UIView * lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 1);
        lineView.backgroundColor = [UIColor yellowColor];
        
        [headerView addSubview:lineView];
        
        return headerView;
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = nil;
    return view;
}

- (void)btnActions:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    

    for (UIButton *btn in self.buttonArray) {
        btn.selected = NO;
    }

    pageNo = 1;

    if (tag == 0) {
        orderStr = @"vieAnswerNumber";
        switch (_ASCType) {
            case EnumASCTypesSheng:{
                sender.selected = YES;
                _ASCType = EnumASCTypesJiang;
                aseBOOL = YES;
                sender.backgroundColor = [UIColor whiteColor];
            }
                break;
            case EnumASCTypesJiang:{
                sender.selected = YES;
                _ASCType = EnumASCTypesSheng;
                aseBOOL = NO;
                sender.backgroundColor = [UIColor whiteColor];
                break;
            }
            default:
                break;
        }
        [self requestFromNetworkWithOrder:orderStr asc:aseBOOL pageNo:pageNo];
        [_tableView.mj_header beginRefreshing];
    }else if (tag == 1) {
        orderStr = @"acceptConsultNumber";
        switch (_ASCType) {
            case EnumASCTypesSheng:{
                sender.selected = YES;
                _ASCType = EnumASCTypesJiang;
                aseBOOL = YES;
                sender.backgroundColor = [UIColor whiteColor];
            }
                break;
            case EnumASCTypesJiang:{
                sender.selected = YES;
                _ASCType = EnumASCTypesSheng;
                aseBOOL = NO;
                sender.backgroundColor = [UIColor whiteColor];
                break;
            }
            default:
                break;
        }
        [self requestFromNetworkWithOrder:orderStr asc:aseBOOL pageNo:pageNo];
        [_tableView.mj_header beginRefreshing];
    }
//    else {
//        orderStr = @"caseAnalysisNumber";
//        switch (_ASCType) {
//            case EnumASCTypesSheng:{
//                sender.selected = YES;
//                _ASCType = EnumASCTypesJiang;
//                aseBOOL = YES;
//                sender.backgroundColor = [UIColor whiteColor];
//            }
//                break;
//            case EnumASCTypesJiang:{
//                sender.selected = YES;
//                _ASCType = EnumASCTypesSheng;
//                aseBOOL = NO;
//                sender.backgroundColor = [UIColor whiteColor];
//                break;
//            }
//            default:
//                break;
//        }
//        [self requestFromNetworkWithOrder:orderStr asc:aseBOOL pageNo:pageNo];
//        [_tableView.mj_header beginRefreshing];
//    }
    
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




- (void)requestFromNetworkWithOrder:(NSString *)order asc:(BOOL)asc pageNo:(NSInteger)type{

    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject: order
            forKey: @"order"];
    [dic setObject: @(asc)
            forKey: @"asc"];
    [dic setObject: @(type)
            forKey:@"pageNo"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getExpertList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
    
        NSLog(@"response = %@",response);
        
        _studyModels = [NSArray yy_modelArrayWithClass:[ZHStudyModel class] json:response[@"data"]];

        if (pageNo == 1) { // 刷新
            _Marry = [NSMutableArray arrayWithArray:_studyModels];
        } else { // 加载更多
            
            [_Marry addObjectsFromArray: _studyModels];
        }
        
        
        if (!_studyModels || !_studyModels.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer resetNoMoreData];
        }
        
        [self.tableView.mj_header endRefreshing];
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        return 44;
//    }
//    return 160;
    
    return (indexPath.section == 0 ? 44:160);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return (section == 0 ? 50:iOS11Later);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return iOS11Later;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (section == 0) {
//        return 1;
//    }
//    return _Marry.count;
    return (section == 0 ? 1:_Marry.count);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCellid forIndexPath:indexPath];
        
        cell.didClick = ^(UIButton *sender){
            
            int row = 1;
            for (int i = 0; i < _arr.count; i++) {
                if (i % 3 == 0 && i != 0) {
                    row += 1;
                }
            }
            
            WEAKSELF
            if (sender.selected == YES) {
                cell.lineImgView.hidden = NO;
                weakSelf.expert = [[expertTypeView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 115+row*40)];
                weakSelf.expert.rowNum = row;
                weakSelf.expert.btnStrArray = _arr;
                [self.view addSubview:weakSelf.expert];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shuju:) name:kSconfirmBtnArrayName object:nil];
            }else{
                [weakSelf.expert removeFromSuperview];
                cell.lineImgView.hidden = YES;
            }
        };
        
        cell.searchClick = ^(){
          
            
            ZHSearchPageViewController *pageVc = [[ZHSearchPageViewController alloc]init];
            
            [self.navigationController pushViewController:pageVc animated:YES];
            
            
        };
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        _studyModel = _Marry[indexPath.row];
     
        ZHExpertTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExpertsCellid forIndexPath:indexPath];

        cell.model =  _studyModel;
        
        return  cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return;
    
    if (indexPath.section == 1) {
        
        ZHExpertUserInfoHomePageViewController  *expertVc = [[ZHExpertUserInfoHomePageViewController alloc]init];
        
        expertVc.expertID = _Marry[indexPath.row].expertId;
        
        [self.navigationController pushViewController:expertVc animated:YES];
        
    }
}

- (void)shuju:(NSNotification *)action {
    
    NSLog(@"shuju %@",action.userInfo[@"confirm"]);
    aseBOOL = NO;
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:@"vieAnswerNumber" forKey:@"order"];
    [dic setObject:@(aseBOOL) forKey:@"asc"];
    [dic setObject:@(pageNo) forKey:@"pageNo"];
    [dic setObject:action.userInfo[@"confirm"][@"type"] forKey:@"certificationType"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/learning/column/getExpertList",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        _studyModels = [NSArray yy_modelArrayWithClass:[ZHStudyModel class] json:response[@"data"]];
        
        if (pageNo == 1) { // 刷新
            _Marry = [NSMutableArray arrayWithArray:_studyModels];
        } else { // 加载更多
            
            [_Marry addObjectsFromArray: _studyModels];
        }
        
        
        if (!_studyModels || !_studyModels.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer resetNoMoreData];
        }
        
        [self.tableView.mj_header endRefreshing];
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    
    
    [self.expert removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:kScreenNameSelected object:nil];
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];

        [_tableView registerNib:[UINib nibWithNibName:@"ZHSearchTableViewCell" bundle:nil] forCellReuseIdentifier:SearchCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertTodayTableViewCell" bundle:nil] forCellReuseIdentifier:ExpertsCellid];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestFromNetworkWithOrder:orderStr asc:aseBOOL pageNo:pageNo];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            pageNo++;
            [self requestFromNetworkWithOrder:orderStr asc:aseBOOL pageNo:pageNo];
        }];
        
        [_tableView.mj_header beginRefreshing];
    }
    
    return _tableView;
}

- (NSMutableArray<NSString *> *)buttonTitles {
    if (!_buttonTitles) {
        _buttonTitles = [NSMutableArray arrayWithArray: @[@"抢答", @"接受咨询"]];
    }
    return _buttonTitles;
}

- (NSMutableArray<ZHButton *> *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSArray *)arr {
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

- (NSMutableArray<ZHStudyModel *> *)Marry{
    if (!_Marry) {
        _Marry = [NSMutableArray array];
    }
    
    return _Marry;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
