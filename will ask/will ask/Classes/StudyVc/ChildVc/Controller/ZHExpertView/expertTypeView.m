//
//  expertTypeView.m
//  expertTypeDemo
//
//  Created by 刘培策 on 2018/1/6.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import "expertTypeView.h"
#import "expertBtnView.h"


#define Btn_Height 50

/** 通知 name */
#define kSBtnTitleName  @"kSBtnTitleName"
#define kSconfirmBtnArrayName  @"kSconfirmBtnArrayName"
#define kScancelBtnArrayName  @"kScancelBtnArrayName"

@interface expertTypeView ()

/** 重置 */
@property(nonatomic,strong) UIButton *resetButton;

/** 确认 */
@property(nonatomic,strong) UIButton *confirmButton;

@property(nonatomic,strong) expertBtnView *expBtnView;

@property(nonatomic,strong) UILabel *nameLabel;

@end

@implementation expertTypeView {
//    NSMutableArray *_tempArray;
    // 用来存储筛选选择的name和type的
    NSMutableDictionary *_tempDict;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
//        _tempArray = [NSMutableArray array];
        _tempDict = [NSMutableDictionary dictionary];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnTitle:) name:kSBtnTitleName object:nil];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor redColor];
    
    self.resetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-Btn_Height, [UIScreen mainScreen].bounds.size.width/2-1, Btn_Height)];
    [self.resetButton addTarget:self action:@selector(resetButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.resetButton setTitle:@"重置" forState:UIControlStateNormal];
    self.resetButton.backgroundColor = [UIColor brownColor];
    [self addSubview:self.resetButton];
    
    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(self.resetButton.bounds.size.width+1, self.bounds.size.height-Btn_Height, [UIScreen mainScreen].bounds.size.width/2, Btn_Height)];
    [self.confirmButton addTarget:self action:@selector(confirmButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    self.confirmButton.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.confirmButton];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 30)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = [UIColor yellowColor];
    self.nameLabel.text = @"专家类型";
    self.nameLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:self.nameLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.resetButton.bounds.size.width, self.bounds.size.height-Btn_Height+5, 1, Btn_Height-10)];
    lineView.backgroundColor = [UIColor redColor];
    [self addSubview:lineView];
    
    self.expBtnView = [[expertBtnView alloc] initWithFrame:CGRectMake(0, self.nameLabel.bounds.size.height+self.nameLabel.frame.origin.y, [UIScreen mainScreen].bounds.size.width, 100)];
    self.expBtnView.backgroundColor = [UIColor purpleColor];
    self.expBtnView.rowNum = 3;
    [self addSubview:self.expBtnView];
}

- (void)setRowNum:(int)rowNum {
    
    _rowNum = rowNum;
}

- (void)setBtnStrArray:(NSArray *)btnStrArray {
    
    _btnStrArray = btnStrArray;
        
    self.expBtnView.arrayDataSource = btnStrArray;
    self.expBtnView.frame = CGRectMake(0, self.nameLabel.bounds.size.height+self.nameLabel.frame.origin.y+15, [UIScreen mainScreen].bounds.size.width, 40*self.rowNum);
}

- (void)resetButtonClickAction {
    
    NSLog(@"resetButtonClickAction");
//    [_tempArray removeAllObjects];
    [_tempDict removeAllObjects];

    [[NSNotificationCenter defaultCenter] postNotificationName:kScancelBtnArrayName object:self];
}

- (void)confirmButtonClickAction {
    
//    NSLog(@"confirmButtonClickAction");
//    if (_tempArray.count > 0) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kSconfirmBtnArrayName object:self userInfo:@{@"confirm":_tempArray}];
//    }else {
////        NSLog(@"- 请选择类型 -");
//        [SVProgressHUD showInfoWithStatus:@"请选择类型"];
//        [SVProgressHUD dismissWithDelay:1.0];
//    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kSconfirmBtnArrayName object:self userInfo:@{@"confirm":_tempDict}];

}

- (void)btnTitle:(NSNotification *)action {
    
    NSLog(@" action %@",action.userInfo[@"name"]);
//    
//    for (int i = 0; i < _tempArray.count; i++) {
//        
//        if ([_tempArray[i] isEqualToString: action.userInfo[@"name"]]) {
//            [_tempArray removeObjectAtIndex:i];
//            return;
//        }
//    }
//
    [_tempDict setObject:action.userInfo[@"name"] forKey:@"name"];
    [_tempDict setObject:action.userInfo[@"type"] forKey:@"type"];
    NSLog(@"name %@ type %@, dict%@",action.userInfo[@"name"],action.userInfo[@"type"],_tempDict);
//    [_tempArray addObject: action.userInfo[@"name"]];
//    NSLog(@" %@",_tempArray);
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
