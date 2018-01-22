//
//  historyView.m
//  NewGoldUnion
//
//  Created by 刘培策 on 17/5/21.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import "historyView.h"

//MARK:16进制颜色
#define ColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define xMargin 20
#define yMargin 40

static CGFloat x = 0;
static CGFloat y = 0;
static CGFloat historyY = 0;

@interface historyView ()

@property (weak, nonatomic) UIButton *clearBtn;

@property (weak, nonatomic) UILabel *historyLabel;

@property (nonatomic, strong) UIView *seachHistoryView;

@end

@implementation historyView {
    
    NSArray<NSString *> *_hotqueryList; //热门搜索
    NSMutableArray<NSString *> *_historyList; //历史记录
    NSMutableArray<UIButton *> *_historyBtns; //历史记录Btn
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _historyList = [NSMutableArray array];
        _historyBtns = [NSMutableArray array];
        
        x = 0; y = 0;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *titleLa = [UILabel labelWithText:@"热门搜索" fontSize:15 TextColor:ColorFromHex(0x323232)];
    [self addSubview:titleLa];
    [titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    
    NSMutableArray * tmpMArray = [NSMutableArray array];
    
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"historyList.archiver"];
    tmpMArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if (tmpMArray.count > 0) {
        _historyList = tmpMArray;
    }
}

- (void)setHistoryMarray:(NSMutableArray *)historyMarray {
    
    _historyMarray = historyMarray;
    
//    NSMutableArray *tmpMArray = [NSMutableArray array];
//    for (NSDictionary *dict in historyMarray) {
//
//        [tmpMArray addObject:dict[@"name"]];
//    }
    
    _hotqueryList = historyMarray;
    
    if(_hotqueryList){
        
        [self createButtons];
        
        if (_historyList.count > 0) {
            
            [self setupHistoryButtons];
        }
    }
}

- (void)createButtons{
    
    NSMutableArray<UIButton *> *arrM = [NSMutableArray arrayWithCapacity:_hotqueryList.count];
    
    for(NSInteger i = 0;i < _hotqueryList.count;i++){
        
        NSString *str = _hotqueryList[i];
        
        UIButton *btn = [UIButton ButtonWithTitle:str fontSize:12 normalColor:ColorFromHex(0x323232) selectedColor:nil Target:self Action:@selector(search_click:)];
        
        btn.layer.borderWidth = 0.5f;
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = ColorFromHex(0xefeff4).CGColor;
        btn.backgroundColor = [UIColor whiteColor];
        CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        
        titleSize.height += 15;
        titleSize.width += 35;
        
        btn.bounds = CGRectMake(0, 0, titleSize.width, titleSize.height);
        
        [self addSubview:btn];
        [arrM addObject:btn];
    }
    
    y = 40;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    [arrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect frame = btn.frame;
        
        if((x + frame.size.width + xMargin) > width - xMargin){
            y += yMargin ;
            x = 0;
        }
        
        frame.origin.x = x + xMargin;
        frame.origin.y = y;
        x += frame.size.width + xMargin;
        btn.frame = frame;
    }];
    
    UILabel *historyLabel = [[UILabel alloc] init];
    historyLabel.text = @"历史记录";
    historyLabel.font = [UIFont systemFontOfSize:16];
    historyLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    historyLabel.hidden = YES;
    [self addSubview:historyLabel];
    self.historyLabel = historyLabel;
    
    [historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(y + yMargin*1.6);
        make.left.equalTo(self).offset(20);
    }];
    
    y += yMargin*1.6;
    
    historyY = y;
    
    UIButton *clearBtn = [UIButton ButtonWithNormalImage:@"book-bj" selectedImage:nil Target:self Action:@selector(clearButtonClickAction)];
    clearBtn.hidden = YES;
    [self addSubview:clearBtn];
    self.clearBtn = clearBtn;
    
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(historyLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    x = 0;
    y += 40;
}

- (void)clearButtonClickAction{
    
    [_historyBtns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [_historyBtns removeAllObjects];
    [_historyList removeAllObjects];
    [self.seachHistoryView removeFromSuperview];
    
    y = historyY + 40;
    x = 0;
    
    self.historyLabel.hidden = YES;
    self.clearBtn.hidden = YES;

    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [Path stringByAppendingPathComponent:@"historyList.archiver"];
    [NSKeyedArchiver archiveRootObject:_historyList toFile:filename];
}

- (void)search_click:(UIButton *)btn{
    
    NSString *word = [btn titleForState:UIControlStateNormal];
    
    if (self.seachTextFieldBlock) {
        self.seachTextFieldBlock(word);
    }
    
    [self addToHistory:word];
}

- (void)addToHistory:(NSString *)word{
    
    if([_historyList containsObject:word]) {
        
        return;
    }else{
       
        if (_historyList.count >= 10) {
            
            [_historyList addObject:word];
            [_historyList removeObjectAtIndex:0];
            [_historyBtns removeObjectAtIndex:0];
            [self setupHistoryButtons];
            
        }else {
            
            [_historyList addObject:word];
            [self setupHistoryButtons];
        }
        //MARK:归接档存储
        NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filename = [Path stringByAppendingPathComponent:@"historyList.archiver"];
        [NSKeyedArchiver archiveRootObject:_historyList toFile:filename];
    }
}

- (void)setupHistoryButtons {
    
    [self.seachHistoryView removeFromSuperview];
    
    self.historyLabel.hidden = NO;
    self.clearBtn.hidden = NO;
    
    _seachHistoryView = [[UIView alloc] init];
//    _seachHistoryView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];

    [self addSubview:_seachHistoryView];
    [_seachHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.historyLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(150);
    }];
    
    CGFloat histoe_Y = 0;
    CGFloat histoe_X = 0;
    
    for (int i = 0; i < _historyList.count; i++) {
        
        UIButton *btn = [UIButton ButtonWithTitle:_historyList[i] fontSize:12 normalColor:ColorFromHex(0x323232) selectedColor:nil Target:self Action:@selector(search_click:)];
        btn.layer.borderWidth = 0.5f;
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = ColorFromHex(0xefeff4).CGColor;
        btn.backgroundColor = [UIColor whiteColor];
        CGSize titleSize = [_historyList[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        
        titleSize.height += 15;
        titleSize.width += 35;
        
        if((histoe_X + titleSize.width + xMargin) > [UIScreen mainScreen].bounds.size.width - xMargin) {
            
            histoe_Y += yMargin ;
            histoe_X = 0;
        }
        
        histoe_X += xMargin;
        btn.frame = CGRectMake(histoe_X, histoe_Y, titleSize.width, titleSize.height);
        histoe_X += titleSize.width;
        
        [_seachHistoryView addSubview:btn];
        [_historyBtns addObject:btn];
    }
}


@end
