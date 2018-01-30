//
//  ZHConsultingMeViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHConsultingMeViewController.h"
#import "ZHConsultingMeAnswerVoiceTableViewCell.h"
#import "ZHConsultingMeDetailTableViewCell.h"
#import "ZHConsultingMeVoiceTableViewCell.h"
#import "ZHExpertAnswerMeTableViewCell.h"
#import "ZHMeChaseAskTableViewCell.h"
#import "ZHExpertChaseMeTableViewCell.h"
#import "ZHAllConsultingMeModel.h"

#import "ICChatBox.h"
#import "ICRecordManager.h"
#import "alertString.h"
#import "ICVoiceHud.h"
#import "yuyinView.h"

#import "MLImageCell.h"
#import "LBViewController+ImagePicker.h"
#import "VoiceConverter.h"
#import "OSSService.h"

static NSInteger kMaxCount = 3;

static NSString *expertAnswerVoiceCellid = @"expertAnswerVoiceCellid";
static NSString *expertVoiceCellid = @"expertVoiceCellid";
static NSString *meDetailCellid = @"meDetailCellid";
static NSString *expertAnswerContentCellid = @"expertAnswerContentCellid";
static NSString *meChaseAskContentCellid = @"meChaseAskContentCellid";
static NSString *expertAnswerChaseCellid = @"expertAnswerChaseCellid";

@interface ZHConsultingMeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ICChatBoxDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    OssService * service;
    NSString * uploadFilePath;
    NSString * _voicePath;
    BOOL _isCancelBool;

}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <ZHAllConsultingMeModel *>*detailModels;


/** 控件view */
@property(nonatomic,strong)UIView *ControlsView;
/** 文本view */
@property(nonatomic,strong)UIView *ContentView;
/** 语音view */
@property(nonatomic,strong)UIView *speakView;
/** 图片view */
@property(nonatomic,strong)UIView *ImageView;
/** 承载所有的view */
@property(nonatomic,strong)UIView *AllView;
/** textView */
@property(nonatomic,strong)UITextView *ContentTextView;
/** 切换语音按钮 */
@property(nonatomic,strong)UIButton *speakBtn;
/** 收起自定义控件按钮 */
@property(nonatomic,strong)UIButton *downBtn;
/** 切换文本按钮 */
@property(nonatomic,strong)UIButton *textBtn;
/** 发布按钮 */
@property(nonatomic,strong)UIButton *ReleaseBtn;

//播放语音整个view
@property(nonatomic,strong)UIView *VoiceView;

@property(nonatomic,strong)UILabel *PlaceholderLabel;

@property(nonatomic,strong)UILabel *LinkageLabel;

@property(nonatomic,strong)UIButton *VoiceBtn;
//删除按钮
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIView *shadowView;

/** 录音文件名 */
@property (nonatomic, copy) NSString *recordName;

@property (nonatomic, strong) ICVoiceHud *voiceHud;

@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray<MLImageModel *> *imageModels;

@property(nonatomic, strong) UIView *footerView;
@property(nonatomic, strong) UIButton *answerButton;


@property(nonatomic,strong)NSData *VoiceData;

@property(nonatomic,strong)NSMutableArray *mArray;

/** 语音时间 */
@property(nonatomic,copy)NSString *voiceSecondTime;


@end

@implementation ZHConsultingMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [self.view addSubview:self.tableView];
    
//    [self configUI];
    
    [self setupUI];

}

- (void)configUI{
    if (self.model.allowAnswer == YES) {
        _footerView = [UIView new];
        _footerView.clipsToBounds = YES;
        _footerView.frame = CGRectMake(0,CGRectGetMaxY(self.tableView.frame) - 50, [UIScreen mainScreen].bounds.size.width, 50);
        _footerView.backgroundColor = [UIColor redColor];
        _answerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _footerView.bounds.size.height)];
        [_answerButton setTitle:@"回复咨询" forState:UIControlStateNormal];
        _answerButton.layer.masksToBounds = YES;
        _answerButton.layer.cornerRadius = 10;
        [_answerButton setBackgroundColor:[UIColor colorWithRed:195/255.0 green:226/255.0 blue:237/255.0 alpha:1]];
        [_answerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.answerButton addTarget:self action:@selector(UPControl) forControlEvents:UIControlEventTouchUpInside];
        
        [_footerView addSubview:self.answerButton];
        [self.view addSubview:_footerView];
    }
    
    if (self.model.allowAddAnswer) {
        
        _footerView = [UIView new];
        _footerView.clipsToBounds = YES;
        _footerView.frame = CGRectMake(0,CGRectGetMaxY(self.tableView.frame) - 50, [UIScreen mainScreen].bounds.size.width, 50);
        _footerView.backgroundColor = [UIColor redColor];
        _answerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _footerView.bounds.size.height)];
        [_answerButton setTitle:@"回复追问" forState:UIControlStateNormal];
        _answerButton.layer.masksToBounds = YES;
        _answerButton.layer.cornerRadius = 10;
        [_answerButton setBackgroundColor:[UIColor colorWithRed:195/255.0 green:226/255.0 blue:237/255.0 alpha:1]];
        [_answerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.answerButton addTarget:self action:@selector(UPControl) forControlEvents:UIControlEventTouchUpInside];
        
        [_footerView addSubview:self.answerButton];
        [self.view addSubview:_footerView];
    }

    
}

- (void)loadData{
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:self.conslutId forKey:@"consultId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/ut/consult/getConsultMyDetails",kIP];
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
    
        _model = [ZHAllConsultingMeModel yy_modelWithJSON:response[@"data"]];
        
        if (self.model.allowAnswer == YES) {
            [self configUI];
        }
        
        if (self.model.allowAddAnswer == YES) {
            [self configUI];
        }

        [self.tableView reloadData];
    }];
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    if (section == 1 && self.model.answerTime) {
        return 1;
    }
    if (section == 2 && self.model.addQuestionTime) {
        return 1;
    }
    
    if (section == 3 && self.model.addAnswerTime) {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHConsultingMeDetailTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:meDetailCellid forIndexPath:indexPath];
        contentCell.model = _model;
        
        return contentCell;
    }
    
    if (indexPath.section == 1 && self.model.answerTime) {
        
        if (self.model.answerVoice) {
            ZHConsultingMeAnswerVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertAnswerVoiceCellid forIndexPath:indexPath];
            
            cell.model = _model;
            
            return cell;
            
        }
        ZHExpertAnswerMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertAnswerContentCellid forIndexPath:indexPath];
        cell.model = _model;
        
        return cell;
    }
    
    if (indexPath.section == 2 && self.model.addQuestionTime) {
        ZHMeChaseAskTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:meChaseAskContentCellid forIndexPath:indexPath];
        contentCell.model = _model;
        
        return contentCell;
    }
    
    if (indexPath.section == 3 && self.model.addAnswerTime) {
        
        if (self.model.addAnswerVoice) {
            ZHConsultingMeVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertVoiceCellid forIndexPath:indexPath];
            
            cell.model = _model;
            return cell;
        }
        ZHExpertChaseMeTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:expertAnswerChaseCellid forIndexPath:indexPath];
        contentCell.model = _model;
        
        return contentCell;
    }
    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
    
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        _tableView.rowHeight = 300;

        [_tableView registerNib:[UINib nibWithNibName:@"ZHConsultingMeAnswerVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:expertAnswerVoiceCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHConsultingMeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:meDetailCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHConsultingMeVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:expertVoiceCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertAnswerMeTableViewCell" bundle:nil] forCellReuseIdentifier:expertAnswerContentCellid];
        [_tableView registerNib:[UINib nibWithNibName:@"ZHMeChaseAskTableViewCell" bundle:nil] forCellReuseIdentifier:meChaseAskContentCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHExpertChaseMeTableViewCell" bundle:nil] forCellReuseIdentifier:expertAnswerChaseCellid];
    }
    //    //#import "ZHMyConsultingDetailTableViewCell.h"
    //#import "ZHMyConsultingAnswerVoiceTableViewCell.h"
    //#import "ZHMyConsultingVoiceTableViewCell.h"
    return _tableView;
}



- (NSMutableArray<ZHAllConsultingMeModel *> *)detailModels {
    
    if (!_detailModels) {
        _detailModels = [NSMutableArray array];
    }
    
    return _detailModels;
}




#pragma mark - 发布回答
- (void)releaseAnswer{
    /*
     answerContent	回答文本	string
     answerPhotos	回答图片	string
     answerVoice	回答语音	string
     consultId      咨询ID
     */
    
    if (self.model.allowAnswer == YES) {
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        //    [dic setObject:_uidString forKey:@"freeAskId"];
        //    if (self.ContentTextView.text) {
        [dic setObject:self.ContentTextView.text forKey:@"answerContent"];
        [dic setObject:self.conslutId forKey:@"consultId"];
        //    }
  
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/consult/answer",kIP];

        NSInteger index=0;
        __block NSInteger  imgCount = 0;
        __block NSInteger taskCount = 0;
        for (MLImageModel *imgModel in self.imageModels) {
            if (imgModel.modelType == MLImageModelTypePlaceholder) continue;
            imgCount++;
        }
        
        if (self.imageModels.count == 1) {
            [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                
                if (error) {
                    NSLog(@"%@",error);
                }
                
                NSLog(@"response = %@",response);
                [self downControl];
                taskCount += 1;
                if (taskCount == 2) {
                    [self loadData];
                }
                
            }];
            
        } else {
            for (MLImageModel *imageModel in self.imageModels) {
                if (imageModel.modelType == MLImageModelTypePlaceholder) continue;{
                    
                    
                    NSData *imageData = UIImageJPEGRepresentation(imageModel.image, 0.5);
                    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"123"];
                    [imageData writeToFile:fullPath atomically:NO];
                    uploadFilePath = fullPath;
                    //                NSLog(@"uploadFilePath : %@", uploadFilePath);
                    
                    
                    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
                    
                    NSString * objectKey = [NSString stringWithFormat:@"%@%@%f%ld",[UserManager sharedManager].userModel.resourceId,@"RP",interval,(long)index];
                    index++;
                    //            NSLog(@"2131312321323  ===%@",objectKey);
                    
                    NSString *bucketName = bucketNameFree;
                    //            NSLog(@"%@",bucketName);
                    
                    [service asyncPutImage:objectKey localFilePath:uploadFilePath bucketName:bucketName comletion:^(BOOL isSuccess) {
                        
                        if (isSuccess) {
                            [self.mArray addObject:objectKey];
                            
                            if (self.mArray.count >= imgCount) {
                                [dic setObject: [_mArray componentsJoinedByString:@","] forKey: @"answerPhotos"];
                                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                                    
                                    if (error) {
                                        NSLog(@"%@",error);
                                    }
                                    
                                    NSLog(@"response = %@",response);
                                    [self downControl];
                                    taskCount += 1;
                                    if (taskCount == 2) {
                                        [self loadData];
                                    }
                                    
                                }];
                            }
                            
                            
                            
                        } else {
                            imgCount--;
                        }
                    }];
                    
                    
                    
                }
            }
        }
        
        
        if (_voicePath) {
            
            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
            
            NSString * objectKey = [NSString stringWithFormat:@"%@%@%f_%@",[UserManager sharedManager].userModel.resourceId,@"RV",interval,_voiceSecondTime];
            uploadFilePath = _voicePath;
            NSString *bucketName = bucketNameFree;
            
            [service asyncPutImage:objectKey localFilePath:uploadFilePath bucketName:bucketName comletion:^(BOOL isSuccess) {
                
                if (isSuccess) {
                    [dic setObject:objectKey forKey:@"answerVoice"];
                    [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                        
                        if (error) {
                            NSLog(@"%@",error);
                        }
                        taskCount += 1;
                        if (taskCount == 2) {
                            [self loadData];
                        }
                        NSLog(@"response = %@",response);
                        
                    }];
                }
                
            }];
        }
    }
    
    if (self.model.allowAddAnswer == YES) {
        
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        //    [dic setObject:_uidString forKey:@"freeAskId"];
        //    if (self.ContentTextView.text) {
        [dic setObject:self.ContentTextView.text forKey:@"answerContent"];
        [dic setObject:self.conslutId forKey:@"consultId"];
        //    }
        
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/consult/addAnswer",kIP];
        
        
        
        
        NSInteger index=0;
        __block NSInteger  imgCount = 0;
        __block NSInteger taskCount = 0;
        for (MLImageModel *imgModel in self.imageModels) {
            if (imgModel.modelType == MLImageModelTypePlaceholder) continue;
            imgCount++;
        }
        
        if (self.imageModels.count == 1) {
            [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                
                if (error) {
                    NSLog(@"%@",error);
                }
                
                NSLog(@"response = %@",response);
                [self downControl];
                taskCount += 1;
                if (taskCount == 2) {
                    [self loadData];
                }
                
            }];
            
        } else {
            for (MLImageModel *imageModel in self.imageModels) {
                if (imageModel.modelType == MLImageModelTypePlaceholder) continue;{
                    
                    
                    NSData *imageData = UIImageJPEGRepresentation(imageModel.image, 0.5);
                    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"123"];
                    [imageData writeToFile:fullPath atomically:NO];
                    uploadFilePath = fullPath;
                    //                NSLog(@"uploadFilePath : %@", uploadFilePath);
                    
                    
                    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
                    
                    NSString * objectKey = [NSString stringWithFormat:@"%@%@%f%ld",[UserManager sharedManager].userModel.resourceId,@"RP",interval,(long)index];
                    index++;
                    //            NSLog(@"2131312321323  ===%@",objectKey);
                    
                    NSString *bucketName = bucketNameFree;
                    //            NSLog(@"%@",bucketName);
                    
                    [service asyncPutImage:objectKey localFilePath:uploadFilePath bucketName:bucketName comletion:^(BOOL isSuccess) {
                        
                        if (isSuccess) {
                            [self.mArray addObject:objectKey];
                            
                            if (self.mArray.count >= imgCount) {
                                [dic setObject: [_mArray componentsJoinedByString:@","] forKey: @"answerPhotos"];
                                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                                    
                                    if (error) {
                                        NSLog(@"%@",error);
                                    }
                                    
                                    NSLog(@"response = %@",response);
                                    [self downControl];
                                    taskCount += 1;
                                    if (taskCount == 2) {
                                        [self loadData];
                                    }
                                    
                                }];
                            }
                            
                            
                            
                        } else {
                            imgCount--;
                        }
                    }];
                    
                    
                    
                }
            }
        }
        
        
        if (_voicePath) {
            
            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
            
            NSString * objectKey = [NSString stringWithFormat:@"%@%@%f_%@",[UserManager sharedManager].userModel.resourceId,@"RV",interval,_voiceSecondTime];
            uploadFilePath = _voicePath;
            NSString *bucketName = bucketNameFree;
            
            [service asyncPutImage:objectKey localFilePath:uploadFilePath bucketName:bucketName comletion:^(BOOL isSuccess) {
                
                if (isSuccess) {
                    [dic setObject:objectKey forKey:@"answerVoice"];
                    [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                        
                        if (error) {
                            NSLog(@"%@",error);
                        }
                        taskCount += 1;
                        if (taskCount == 2) {
                            [self loadData];
                        }
                        NSLog(@"response = %@",response);
                        
                    }];
                }
                
            }];
        }
    }
    
   
    
}

- (void)setupUI{
    
    [self.view addSubview:self.AllView];
    [_AllView addSubview:self.ControlsView];
    [_AllView addSubview:self.ContentView];
    [_AllView addSubview:self.ImageView];
    
    [self.ContentView addSubview:self.ContentTextView];
    [self.ControlsView addSubview:self.downBtn];
    [self.ControlsView addSubview:self.textBtn];
    [self.ControlsView addSubview:self.speakBtn];
    [self.ControlsView addSubview:self.ReleaseBtn];
    
    [self.ContentTextView addSubview:self.PlaceholderLabel];
    [self.ContentTextView addSubview:self.LinkageLabel];
    
    self.ContentTextView.delegate = self;
    
    CGFloat VoiceBtnWidth = 75;
    CGFloat VoiceBtnHeight = VoiceBtnWidth;
    
    ICChatBox *btn = [[ICChatBox alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - VoiceBtnWidth ) / 2, 42.5, VoiceBtnWidth, VoiceBtnHeight)];
    btn.delegate = self;
    [self.speakView addSubview:btn];
    
    _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50) collectionViewLayout: self.layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0,18, 0, 0);
    [_collectionView registerNib:[UINib nibWithNibName: NSStringFromClass([MLImageCell class])
                                                bundle: [NSBundle mainBundle]]
      forCellWithReuseIdentifier: NSStringFromClass([MLImageCell class])];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    [self.ImageView addSubview:self.collectionView];
}

- (UIButton *)VoiceBtn{
    if (!_VoiceBtn) {
        
        CGFloat VoiceBtnWidth = 75;
        CGFloat VoiceBtnHeight = VoiceBtnWidth;
        
        _VoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_VoiceBtn setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
        [_VoiceBtn setImage:[UIImage imageNamed:@"record1"] forState:UIControlStateSelected];
        
        _VoiceBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - VoiceBtnWidth ) / 2, 42.5, VoiceBtnWidth, VoiceBtnHeight);
    }
    return _VoiceBtn;
}

- (UIButton *)deleteButton{
    
    if (!_deleteButton) {
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _deleteButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 14 , 150, 50, 13);
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deleteButton;
}

#pragma mark - 删除语音消息
- (void)deleteAction{
    
    [self.VoiceView removeFromSuperview];
    _isCancelBool = YES;
}

- (UIView *)ControlsView{
    
    if (!_ControlsView) {
        
        CGFloat ControlsViewHeight = 50;
        
        _ControlsView = [UIView new];
        
        _ControlsView.backgroundColor = [UIColor lightGrayColor];
        
        _ControlsView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ControlsViewHeight);
    }
    return _ControlsView;
}

- (UIView *)ContentView{
    
    if (!_ContentView) {
        
        CGFloat ContentViewHeight = 190;
        
        _ContentView = [UIView new];
        
        _ContentView.backgroundColor = [UIColor redColor];
        
        _ContentView.frame = CGRectMake(0, CGRectGetMaxY(self.ControlsView.frame), [UIScreen mainScreen].bounds.size.width, ContentViewHeight);
    }
    return _ContentView;
}

- (UIView *)AllView{
    
    if (!_AllView) {
        CGFloat AllViewHeight = 285;
        
        _AllView = [UIView new];
        
        _AllView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _AllView.frame = (CGRect){CGPointMake(0, [UIScreen mainScreen].bounds.size.height - 64
                                              ), CGSizeMake([UIScreen mainScreen].bounds.size.width, AllViewHeight )};
    }
    return _AllView;
}

- (UIView *)VoiceView{
    
    if (!_VoiceView) {
        
        CGFloat VoiceViewHeight = 190;
        _VoiceView = [UIView new];
        _VoiceView.backgroundColor = [UIColor redColor];
        
        _VoiceView.frame =  CGRectMake(0, CGRectGetMaxY(self.ControlsView.frame), [UIScreen mainScreen].bounds.size.width, VoiceViewHeight);
    }
    return _VoiceView;
}

- (UIView *)speakView{
    
    if (!_speakView) {
        
        CGFloat SpeakViewHeight = 190;
        
        _speakView = [UIView new];
        
        _speakView.backgroundColor = [UIColor greenColor];
        
        _speakView.frame = CGRectMake(0, CGRectGetMaxY(self.ControlsView.frame), [UIScreen mainScreen].bounds.size.width, SpeakViewHeight);
    }
    return _speakView;
}

- (UIView *)ImageView{
    
    if (!_ImageView) {
        
        CGFloat SpeakViewHeight = 45;
        
        _ImageView = [UIView new];
        
        _ImageView.backgroundColor = [UIColor blueColor];
        
        _ImageView.frame = CGRectMake(0, CGRectGetMaxY(self.ContentView.frame), [UIScreen mainScreen].bounds.size.width, SpeakViewHeight);
    }
    return _ImageView;
}

- (UITextView *)ContentTextView{
    
    if (!_ContentTextView) {
        
        CGFloat ContentTextViewHeight = 190;
        
        _ContentTextView = [UITextView new];
        _ContentTextView.backgroundColor = [UIColor yellowColor];
        _ContentTextView.alpha = .8;
        _ContentTextView.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, ContentTextViewHeight);
    }
    return _ContentTextView;
}

- (UILabel *)PlaceholderLabel {
    
    if (!_PlaceholderLabel) {
        _PlaceholderLabel = [UILabel new];
        
        _PlaceholderLabel.text = @"请输入您的回答";
        _PlaceholderLabel.font = [UIFont systemFontOfSize:14];
        _PlaceholderLabel.frame = CGRectMake(5, 7, 100, 15);
    }
    return _PlaceholderLabel;
}

- (UILabel *)LinkageLabel {
    
    if (!_LinkageLabel) {
        
        _LinkageLabel = [UILabel new];
        
        _LinkageLabel.text = @"0/200";
        _LinkageLabel.font = [UIFont systemFontOfSize:14];
        
        _LinkageLabel.frame = CGRectMake(CGRectGetMaxX(self.ContentTextView.frame) - 64, CGRectGetMaxY(self.ContentTextView.frame) - 30.5, 80, 13.5);
    }
    return _LinkageLabel;
}


- (UIButton *)ReleaseBtn {
    
    CGFloat ReleaseBtnHeight = 14;
    CGFloat ReleaseBtnWidth = 35;
    
    _ReleaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_ReleaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    _ReleaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    _ReleaseBtn.frame = CGRectMake(CGRectGetMaxX(self.ControlsView.frame) - 18 - ReleaseBtnWidth, 18, ReleaseBtnWidth, ReleaseBtnHeight);
    [_ReleaseBtn addTarget:self action:@selector(releaseAnswer) forControlEvents:UIControlEventTouchUpInside];
    
    
    return _ReleaseBtn;
}


- (UIButton *)downBtn {
    
    
    CGFloat DownBtnHeight = 22.5;
    CGFloat DownBtnWidth = DownBtnHeight;
    
    if (!_downBtn) {
        _downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_downBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
        
        _downBtn.frame = CGRectMake(18, 11, DownBtnWidth, DownBtnHeight);
        
        
        [_downBtn addTarget:self action:@selector(downControl) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downBtn;
}

- (UIButton *)speakBtn {
    
    
    if (!_speakBtn) {
        
        CGFloat DownBtnHeight = 22.5;
        CGFloat DownBtnWidth = DownBtnHeight;
        
        _speakBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_speakBtn setImage:[UIImage imageNamed:@"book-1"] forState:UIControlStateNormal];
        [_speakBtn setImage:[UIImage imageNamed:@"free"] forState:UIControlStateSelected];
        
        _speakBtn.frame = CGRectMake(CGRectGetMaxX(self.textBtn.frame) + 10, 11, DownBtnWidth, DownBtnHeight);
        [_speakBtn addTarget:self action:@selector(gogo) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _speakBtn;
    
}

- (void)gogo {
    
    [self.AllView addSubview:self.speakView];
    //        [self.ContentTextView removeFromSuperview];
    _speakBtn.selected = YES;
    self.textBtn.selected = NO;
}

- (UIButton *)textBtn {
    if (!_textBtn) {
        
        CGFloat DownBtnHeight = 22.5;
        CGFloat DownBtnWidth = DownBtnHeight;
        
        _textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_textBtn setImage:[UIImage imageNamed:@"book-1"] forState:UIControlStateNormal];
        [_textBtn setImage:[UIImage imageNamed:@"bonus"] forState:UIControlStateSelected];
        
        _textBtn.selected = YES;
        _textBtn.frame = CGRectMake(CGRectGetMaxX(self.downBtn.frame) + 10, 11, DownBtnWidth, DownBtnHeight);
        [_textBtn addTarget:self action:@selector(nono) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _textBtn;
}

- (void)nono {
    
    if (self.VoiceView) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"标题" message:@"请问确定放弃语音内容，转换为文字输入？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
        
        [alertview show];
    }
    [self.speakView removeFromSuperview];
    
    _speakBtn.selected = NO;
    self.textBtn.selected = YES;
}

- (void)downControl {
    
    _answerButton.hidden = NO;
    _footerView.hidden = NO;
    [UIView animateWithDuration: .5 animations:^{
        CGRect currentFrame = self.AllView.frame;
        currentFrame.origin.y = self.AllView.frame.origin.y + CGRectGetHeight(currentFrame)    ;
        self.AllView.frame = currentFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)UPUP {
    //
    //    _shadowView = [UIView new];
    //    _shadowView.backgroundColor = [UIColor blackColor];
    //    _shadowView.alpha = .3;
    //    _shadowView.frame = self.tableView.frame;
    //    [self.tableView addSubview:self.shadowView];
    
    _answerButton.hidden = YES;
    _footerView.hidden = YES;
    [UIView animateWithDuration: .5 animations:^{
        CGRect currentFrame = self.AllView.frame;
        currentFrame.origin.y = self.AllView.frame.origin.y - CGRectGetHeight(currentFrame);
        self.AllView.frame = currentFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        
        [_PlaceholderLabel setHidden:NO];
        
    }else{
        
        [_PlaceholderLabel setHidden:YES];
        
    }
    NSInteger wordCount = textView.text.length;
    self.LinkageLabel.text = [NSString stringWithFormat:@"%ld/200",  (long)wordCount];
}

#pragma mark - ICChatBoxDelegate
- (void)chatBoxDidStartRecordingVoice:(ICChatBox *)chatBox {
    
    NSLog(@"Start");
    self.recordName = [self currentRecordFileName];
    
    [[ICRecordManager shareManager] startRecordingWithFileName:self.recordName completion:^(NSError *error) {
        if (error) {   // 加了录音权限的判断
        } else {
            NSLog(@"应该是拿到录音文件 %@ ",self.recordName);
            
            self.voiceHud.hidden = NO;
            
            if (_isCancelBool) {
                self.voiceHud.image  = [UIImage imageNamed:@"voice_1"];
                [self.timer setFireDate:[NSDate date]];
            }else {
                [self timer];
            }
        }
    }];
}

- (void)chatBoxDidStopRecordingVoice:(ICChatBox *)chatBox {
    
    NSLog(@"Stop");
    __weak typeof(self) weakSelf = self;
    [[ICRecordManager shareManager] stopRecordingWithCompletion:^(NSString *recordPath) {
        if ([recordPath isEqualToString:shortRecord]) {
            
            [self.voiceHud removeFromSuperview];
            [alertString showString:@"语音太短" Delay:1];
            [[ICRecordManager shareManager] removeCurrentRecordFile:weakSelf.recordName];
            
        } else {
            
            self.voiceHud.hidden = YES;
            NSLog(@"path-%@-",recordPath);
            
            CGFloat VoiceBtnWidth = 75;
            CGFloat VoiceBtnHeight = VoiceBtnWidth;
            
            [_VoiceBtn setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
            [_VoiceBtn setImage:[UIImage imageNamed:@"record1"] forState:UIControlStateSelected];
            
            _VoiceBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - VoiceBtnWidth ) / 2, 42.5, VoiceBtnWidth, VoiceBtnHeight);
            
            [self.AllView addSubview:self.VoiceView];
            [self.VoiceView addSubview:self.deleteButton];
            
            yuyinView *yuyin = [[yuyinView alloc] initWithFrame:CGRectMake(55,(self.VoiceView.frame.size.height / 2) - 25,[UIScreen mainScreen].bounds.size.width - 55 - 88, 50)];
            yuyin.pathStr = recordPath;
            
            _voiceSecondTime = yuyin.durationLabel.text;
            
            // 文件路径
            NSString *voicePath =  recordPath;
            NSString *amrPath   = [[voicePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"amr"];
            [VoiceConverter ConvertWavToAmr:voicePath amrSavePath:amrPath];
            
            NSLog(@"amr = %@",amrPath);
            //获取链接数据转成Data
            _VoiceData = [NSData dataWithContentsOfFile:amrPath];
            NSLog(@"_VoiceData = %@",_VoiceData);
            
            _voicePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"456"];;
            [_VoiceData writeToFile:_voicePath atomically:YES];
            
            [self.VoiceView addSubview:yuyin];
        }
    }];
    
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)chatBoxDidCancelRecordingVoice:(ICChatBox *)chatBox {
    
    NSLog(@"Cancel");
    [[ICRecordManager shareManager] removeCurrentRecordFile:self.recordName];
    self.voiceHud.hidden = YES;
    [_timer setFireDate:[NSDate distantFuture]];
    _isCancelBool = YES;
}

- (void)chatBoxDidDrag:(BOOL)inside {
    
    NSLog(@"DidDrag");
    
    if (inside) {
        [_timer setFireDate:[NSDate distantPast]];
        _voiceHud.image  = [UIImage imageNamed:@"voice_1"];
    } else {
        [_timer setFireDate:[NSDate distantFuture]];
        self.voiceHud.animationImages  = nil;
        self.voiceHud.image = [UIImage imageNamed:@"cancelVoice"];
    }
}

- (NSString *)currentRecordFileName
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%ld",(long)timeInterval];
    return fileName;
}

- (ICVoiceHud *)voiceHud
{
    if (!_voiceHud) {
        _voiceHud = [[ICVoiceHud alloc] initWithFrame:CGRectMake(0, 0, 155, 155)];
        _voiceHud.hidden = YES;
        _voiceHud.center = CGPointMake(WIDTH_SCREEN/2, HEIGHT_SCREEN/2);
        [self.view addSubview:_voiceHud];
    }
    return _voiceHud;
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)progressChange
{
    AVAudioRecorder *recorder = [[ICRecordManager shareManager] recorder] ;
    [recorder updateMeters];
    
    float   level;                // The linear 0.0 .. 1.0 value we need.
    
    float   minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
    
    float   decibels = [recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels) {
        
        level = 0.0f;
        
    } else if (decibels >= 0.0f) {
        
        level = 1.0f;
        
    } else {
        
        float   root            = 2.0f;
        
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        
        float   amp             = powf(10.0f, 0.05f * decibels);
        
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
    }
    
    self.voiceHud.progress = level* 100;
    NSLog(@"平均值 %f level %f %f ", level * 100,level,self.voiceHud.progress);
}

#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass([MLImageCell class])
                                                                       forIndexPath: indexPath];
    imageCell.imageModel = self.imageModels[indexPath.item];
    return imageCell;
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取 Model
    MLImageModel *imageModel = self.imageModels[indexPath.item];
    
    // 判断 Model 的类型
    switch (imageModel.modelType) {
        case MLImageModelTypePlaceholder: { // 如果是 PlaceHolder 类型, 则需要调起相机或者相册让用户选图片, 我在这里是假装用户选择了一张图片.
            [self selectPhotoWithSuccessBlock:^(UIImagePickerController *imagePickerViewController, NSDictionary<NSString *,id> *info) {
                UIImage *image = info[UIImagePickerControllerEditedImage];
                
                // 创建数据模型
                MLImageModel *imageModel = [MLImageModel new];
                imageModel.image = image;
                
                // 重新配置数组, 你应该把这个图片放在数组的倒数第二位, 因为倒数第一位应该是占位图
                NSInteger count = self.imageModels.count;
                [self.imageModels insertObject: imageModel
                                       atIndex: count-1];
                
                // 在这里你需要判断是否已经超出了最大值, 如果超出了最大值, 你需要删除掉最后一个占位图
                if (self.imageModels.count > kMaxCount) {
                    [self.imageModels removeObjectAtIndex: self.imageModels.count-1];
                }
                
                
                [self.collectionView reloadData];
                
                
            } cancelBlock:^(UIImagePickerController *imagePickerViewController) {}];
            
        }
            break;
            
        case MLImageModelTypeImage: { // 如果是 Image 类型, 在这里可以做删除图片的操作, 也可以不做任何操作, 主要看你的业务逻辑, 我在这里写的是删除图片的操作.
            
            // 我在这里模拟做一下删除图片的操作, 你需要删除的是对应下标的图片
            [self.imageModels removeObjectAtIndex: indexPath.item];
            
            // 在这里判断最后一张是不是占位图, 如果是占位图则什么操作都不用做, 如果不是占位图, 则需要添加一个占位图的数据模型
            MLImageModel *imageModel = [self.imageModels lastObject];
            if (imageModel.modelType != MLImageModelTypePlaceholder) {
                
                MLImageModel *placeHolderModel = [MLImageModel new];
                [self.imageModels addObject: placeHolderModel];
            }
        }
            break;
    }
    
    // 刷新 CollectionView
    [self.collectionView reloadData];
}

#pragma mark - Lazy load
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumInteritemSpacing = 10;
        _layout.minimumLineSpacing = 10;
        _layout.sectionInset = UIEdgeInsetsZero;
        _layout.itemSize = CGSizeMake(25, 25);
    }
    return _layout;
}

- (NSMutableArray<MLImageModel *> *)imageModels {
    if (!_imageModels) {
        _imageModels = [NSMutableArray arrayWithObject: [MLImageModel new]];
        
    }
    return _imageModels;
}

- (NSMutableArray *)mArray {
    
    if (!_mArray) {
        
        _mArray = [[NSMutableArray alloc]init];
    }
    
    return _mArray;
}



@end