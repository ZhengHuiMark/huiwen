//
//  ZHRewardDetailViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/11/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardDetailViewController.h"
#import "ZHRewardDetailTableViewCell.h"
#import "ZHRewardAnswerTableViewCell.h"
#import "ZHRewardAnswerVoiceTableViewCell.h"
#import "Macro.h"
#import "ZHNetworkTools.h"
#import "ZHFreeAnswerModel.h"
#import "ZHFreeDetailModel.h"
#import "YYModel.h"

#import "VoiceConverter.h"
#import "ICChatBox.h"
#import "ICRecordManager.h"
#import "alertString.h"
#import "ICVoiceHud.h"
#import "yuyinView.h"
#import "MLImageCell.h"
#import "LBViewController+ImagePicker.h"

static NSString *RewardDetailCellid = @"RewardDetailCellid";

static NSString *RewardContentCellid = @"RewardContentCellid";

static NSString *RewardVoiceCellid = @"RewardVoiceCellid";

static NSInteger kMaxCount = 3;

@interface ZHRewardDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

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

@property(nonatomic,strong)UILabel *PlaceholderLabel;

@property(nonatomic,strong)UILabel *LinkageLabel;

@property(nonatomic,strong)UIButton *VoiceBtn;

/** 录音文件名 */
@property (nonatomic, copy) NSString *recordName;

//@property (nonatomic, strong) ICVoiceHud *voiceHud;

@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray<MLImageModel *> *imageModels;



@property(nonatomic,strong)NSData *VoiceData;



@end

@implementation ZHRewardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self loadData];
    
    
    
    [self.view addSubview:self.tableView];
    
}


- (void)loadData {
    
    NSMutableDictionary *dic = [ZHNetworkTools parameters];
    [dic setObject:_uidStringz forKey:@"rewardAskId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/rewardask/uto/getRewardAskDetail",kIP];
    
    NSLog(@"url = %@",url);
    
    NSLog(@"231231 = %@",dic);
    
    [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSLog(@"response = %@",response);
        
        _detailModel = [ZHFreeDetailModel yy_modelWithJSON:response[@"data"]];
        
        
        _detailModel.anserModels = [NSArray yy_modelArrayWithClass:[ZHFreeAnswerModel class] json:response[@"data"][@"answers"]];
        
        
        [self.tableView reloadData];
        
    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.1;
    }
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        
        
        NSString *wenzi = self.detailModel.content;
        CGFloat marin = 17.5;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        
        
        return 219 + labelHeight;
    }
    
    if (self.detailModel.anserModels[indexPath.row].content) {
        
        
        NSString *wenzi = self.detailModel.anserModels[indexPath.row].content;
        CGFloat marin = 17.5;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
        CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                               attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                                  context: nil].size.height;
        
        
        return 219 + labelHeight;
    }
    
    
    return 285;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return self.detailModel.anserModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    
    if (indexPath.section == 0) {
        ZHRewardDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RewardDetailCellid forIndexPath:indexPath];
        
        cell.detailModel = _detailModel;
        
        return cell;
    }
    
    if (self.detailModel.anserModels[indexPath.row].content) {
        ZHRewardAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RewardContentCellid forIndexPath:indexPath];
        
        cell.detailModel = self.detailModel;
        cell.answerModel = self.detailModel.anserModels[indexPath.row];
        
        //        cell.answerVoiceModel = self.detailModel.anserModels[indexPath.row];
        
        return cell;
        
    }else{
        //   (self.detailModel.anserModels[indexPath.row].voice)
        ZHRewardAnswerVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RewardVoiceCellid forIndexPath:indexPath];
        
        
        cell.detailModel = self.detailModel;

        cell.answerModel = self.detailModel.anserModels[indexPath.row];
        
        return cell;
        
    }
    
    return cell;
    
    
}






- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        
        //    NSBundle *bundle = [NSBundle mainBundle];
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHRewardDetailTableViewCell" bundle:nil] forCellReuseIdentifier:RewardDetailCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHRewardAnswerTableViewCell" bundle:nil] forCellReuseIdentifier:RewardContentCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHRewardAnswerVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:RewardVoiceCellid];
    }
    
    return _tableView;
}


- (void)setupUI{
    
    UIButton *btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btnUp setImage:[UIImage imageNamed:@"expert"] forState:UIControlStateNormal];
    
    btnUp.frame = CGRectMake(0,CGRectGetMaxY(self.view.frame)- 50 ,[UIScreen mainScreen].bounds.size.width, 50);
//    
//    [btnUp addTarget:self action:@selector(UPUP) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnUp];
    
    [self.view addSubview:self.AllView];
    [_AllView addSubview:self.ControlsView];
    [_AllView addSubview:self.ContentView];
    //    [_AllView addSubview:self.speakView];
    [_AllView addSubview:self.ImageView];
    
    
    [self.ContentView addSubview:self.ContentTextView];
    [self.ControlsView addSubview:self.downBtn];
    [self.ControlsView addSubview:self.textBtn];
    [self.ControlsView addSubview:self.speakBtn];
    [self.ControlsView addSubview:self.ReleaseBtn];
    
    [self.ContentTextView addSubview:self.PlaceholderLabel];
    [self.ContentTextView addSubview:self.LinkageLabel];
    //    [self.speakView addSubview:self.VoiceBtn];
    
    self.ContentTextView.delegate = self;
    
    CGFloat VoiceBtnWidth = 75;
    CGFloat VoiceBtnHeight = VoiceBtnWidth;
//    
//    ICChatBox *button1 = [[ICChatBox alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - VoiceBtnWidth ) / 2, 42.5, VoiceBtnWidth, VoiceBtnHeight)];
//    btn.delegate = self;
//    [self.speakView addSubview:button1];
    
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
//
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
        _AllView.frame = (CGRect){CGPointMake(0, [UIScreen mainScreen].bounds.size.height - AllViewHeight
                                              ), CGSizeMake([UIScreen mainScreen].bounds.size.width, AllViewHeight)};
        
    }
    
    
    return _AllView;
    
}

//
//- (UIView *)speakView{
//    
//    if (!_speakView) {
//        
//        CGFloat SpeakViewHeight = 190;
//        
//        _speakView = [UIView new];
//        
//        _speakView.backgroundColor = [UIColor greenColor];
//        
//        _speakView.frame = CGRectMake(0, CGRectGetMaxY(self.ControlsView.frame), [UIScreen mainScreen].bounds.size.width, SpeakViewHeight);
//        
//    }
//    
//    return _speakView;
//}
//
//- (UIView *)ImageView{
//    
//    if (!_ImageView) {
//        
//        CGFloat SpeakViewHeight = 45;
//        
//        _ImageView = [UIView new];
//        
//        _ImageView.backgroundColor = [UIColor blueColor];
//        
//        _ImageView.frame = CGRectMake(0, CGRectGetMaxY(self.ContentView.frame), [UIScreen mainScreen].bounds.size.width, SpeakViewHeight);
//        
//    }
//    return _ImageView;
//}
//
//
//
//- (UITextView *)ContentTextView{
//    
//    if (!_ContentTextView) {
//        
//        CGFloat ContentTextViewHeight = 190;
//        
//        _ContentTextView = [UITextView new];
//        
//        
//        _ContentTextView.backgroundColor = [UIColor yellowColor];
//        _ContentTextView.alpha = .8;
//        
//        
//        _ContentTextView.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, ContentTextViewHeight);
//    }
//    return _ContentTextView;
//}
//
//
//- (UILabel *)PlaceholderLabel {
//    
//    if (!_PlaceholderLabel) {
//        _PlaceholderLabel = [UILabel new];
//        
//        _PlaceholderLabel.text = @"请输入您的回答";
//        _PlaceholderLabel.font = [UIFont systemFontOfSize:14];
//        
//        _PlaceholderLabel.frame = CGRectMake(5, 7, 100, 15);
//        
//    }
//    return _PlaceholderLabel;
//}
//
//- (UILabel *)LinkageLabel {
//    
//    if (!_LinkageLabel) {
//        
//        _LinkageLabel = [UILabel new];
//        
//        _LinkageLabel.text = @"0/200";
//        _LinkageLabel.font = [UIFont systemFontOfSize:14];
//        
//        _LinkageLabel.frame = CGRectMake(CGRectGetMaxX(self.ContentTextView.frame) - 64, CGRectGetMaxY(self.ContentTextView.frame) - 30.5, 80, 13.5);
//    }
//    return _LinkageLabel;
//}
//
//
//- (UIButton *)ReleaseBtn {
//    
//    CGFloat ReleaseBtnHeight = 14;
//    CGFloat ReleaseBtnWidth = 35;
//    
//    _ReleaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [_ReleaseBtn setTitle:@"发布" forState:UIControlStateNormal];
//    _ReleaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    
//    _ReleaseBtn.frame = CGRectMake(CGRectGetMaxX(self.ControlsView.frame) - 18 - ReleaseBtnWidth, 18, ReleaseBtnWidth, ReleaseBtnHeight);
//    
//    
//    return _ReleaseBtn;
//}
//
//
//- (UIButton *)downBtn {
//    
//    
//    CGFloat DownBtnHeight = 22.5;
//    CGFloat DownBtnWidth = DownBtnHeight;
//    
//    if (!_downBtn) {
//        _downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        [_downBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
//        
//        _downBtn.frame = CGRectMake(18, 11, DownBtnWidth, DownBtnHeight);
//        
//        
//        [_downBtn addTarget:self action:@selector(downControl) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    
//    
//    
//    return _downBtn;
//}
//
//- (UIButton *)speakBtn {
//    
//    
//    if (!_speakBtn) {
//        
//        CGFloat DownBtnHeight = 22.5;
//        CGFloat DownBtnWidth = DownBtnHeight;
//        
//        _speakBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        [_speakBtn setImage:[UIImage imageNamed:@"book-1"] forState:UIControlStateNormal];
//        [_speakBtn setImage:[UIImage imageNamed:@"free"] forState:UIControlStateSelected];
//        
//        _speakBtn.frame = CGRectMake(CGRectGetMaxX(self.textBtn.frame) + 10, 11, DownBtnWidth, DownBtnHeight);
//        [_speakBtn addTarget:self action:@selector(gogo) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    
//    return _speakBtn;
//    
//}

//- (void)gogo {
//    [self.AllView addSubview:self.speakView];
//    //        [self.ContentTextView removeFromSuperview];
//    _speakBtn.selected = YES;
//    self.textBtn.selected = NO;
//    
//}
//
//- (UIButton *)textBtn {
//    if (!_textBtn) {
//        
//        CGFloat DownBtnHeight = 22.5;
//        CGFloat DownBtnWidth = DownBtnHeight;
//        
//        _textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        [_textBtn setImage:[UIImage imageNamed:@"book-1"] forState:UIControlStateNormal];
//        [_textBtn setImage:[UIImage imageNamed:@"bonus"] forState:UIControlStateSelected];
//        
//        _textBtn.selected = YES;
//        _textBtn.frame = CGRectMake(CGRectGetMaxX(self.downBtn.frame) + 10, 11, DownBtnWidth, DownBtnHeight);
//        [_textBtn addTarget:self action:@selector(nono) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    return _textBtn;
//}
//
//- (void)nono {
//    
//    [self.speakView removeFromSuperview];
//    
//    _speakBtn.selected = NO;
//    self.textBtn.selected = YES;
//    
//    
//    
//}
//
//- (void)downControl {
//    
//    [UIView animateWithDuration: .5 animations:^{
//        CGRect currentFrame = self.AllView.frame;
//        currentFrame.origin.y = self.AllView.frame.origin.y + CGRectGetHeight(currentFrame) + 64;
//        self.AllView.frame = currentFrame;
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    
//}

//- (void)UPUP {
//    
//    
//    [UIView animateWithDuration: .5 animations:^{
//        CGRect currentFrame = self.AllView.frame;
//        currentFrame.origin.y = self.AllView.frame.origin.y - CGRectGetHeight(currentFrame) - 64;
//        self.AllView.frame = currentFrame;
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//}

//- (void)textViewDidChange:(UITextView *)textView{
//    
//    if ([textView.text length] == 0) {
//        
//        [_PlaceholderLabel setHidden:NO];
//        
//    }else{
//        
//        [_PlaceholderLabel setHidden:YES];
//        
//    }
//    NSInteger wordCount = textView.text.length;
//    self.LinkageLabel.text = [NSString stringWithFormat:@"%ld/200",  (long)wordCount];
//}
//
//#pragma mark - ICChatBoxDelegate
//- (void)chatBoxDidStartRecordingVoice:(ICChatBox *)chatBox {
//    
//    NSLog(@"Start");
//    self.recordName = [self currentRecordFileName];
//    
//    [[ICRecordManager shareManager] startRecordingWithFileName:self.recordName completion:^(NSError *error) {
//        if (error) {   // 加了录音权限的判断
//        } else {
//            //            if ([_delegate respondsToSelector:@selector(voiceDidStartRecording)]) {
//            //                [_delegate voiceDidStartRecording];
//            //            }
//            NSLog(@"应该是拿到录音文件 %@ ",self.recordName);
//            
//            self.voiceHud.hidden = NO;
//            [self timer];
//        }
//    }];
//}

//- (void)chatBoxDidStopRecordingVoice:(ICChatBox *)chatBox {
//    
//    NSLog(@"Stop");
//    __weak typeof(self) weakSelf = self;
//    [[ICRecordManager shareManager] stopRecordingWithCompletion:^(NSString *recordPath) {
//        if ([recordPath isEqualToString:shortRecord]) {
//            
//            [self.voiceHud removeFromSuperview];
//            [alertString showString:@"语音太短" Delay:1];
//            [[ICRecordManager shareManager] removeCurrentRecordFile:weakSelf.recordName];
//            
//            
//        } else {
//            //            if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:sendVoiceMessage:)]) {
//            //                [_delegate chatBoxViewController:weakSelf sendVoiceMessage:recordPath];
//            //            }
//            self.voiceHud.hidden = YES;
//            NSLog(@"path-%@-",recordPath);
//            
//            CGFloat VoiceBtnWidth = 75;
//            CGFloat VoiceBtnHeight = VoiceBtnWidth;
//            
//            
//            
//            [_VoiceBtn setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
//            [_VoiceBtn setImage:[UIImage imageNamed:@"record1"] forState:UIControlStateSelected];
//            
//            _VoiceBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - VoiceBtnWidth ) / 2, 42.5, VoiceBtnWidth, VoiceBtnHeight);
//            yuyinView *yuyin = [[yuyinView alloc] initWithFrame:CGRectMake(100,350 , 150, 50)];
//            yuyin.backgroundColor = [UIColor whiteColor];
//            yuyin.pathStr = recordPath;
//            //
//            NSLog(@"yuyin path = %@", yuyin.pathStr);
//            
//            //
//            
//            // 文件路径
//            NSString *voicePath =  recordPath;
//            NSString *amrPath   = [[voicePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"amr"];
//            [VoiceConverter ConvertWavToAmr:voicePath amrSavePath:amrPath];
//            
//            NSLog(@"amr = %@",amrPath);
//            //获取链接数据转成Data
//            _VoiceData = [NSData dataWithContentsOfFile:recordPath];
//            NSLog(@"_VoiceData = %@",_VoiceData);
//            
//            [_VoiceData writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"AudioTempFile"] atomically:YES];
//            
//            
//            
//            
//            [self.view addSubview:yuyin];
//            
//        }
//    }];
//}

//- (void)chatBoxDidCancelRecordingVoice:(ICChatBox *)chatBox {
//    
//    NSLog(@"Cancel");
//    
//    //    if ([_delegate respondsToSelector:@selector(voiceDidCancelRecording)]) {
//    //        [_delegate voiceDidCancelRecording];
//    //    }
//    [[ICRecordManager shareManager] removeCurrentRecordFile:self.recordName];
//    self.voiceHud.hidden = YES;
//    [_timer invalidate];
//}

//- (void)chatBoxDidDrag:(BOOL)inside
//{
//    NSLog(@"DidDrag");
//    
//    if (inside) {
//        [_timer setFireDate:[NSDate distantPast]];
//        _voiceHud.image  = [UIImage imageNamed:@"voice_1"];
//    } else {
//        [_timer setFireDate:[NSDate distantFuture]];
//        self.voiceHud.animationImages  = nil;
//        self.voiceHud.image = [UIImage imageNamed:@"cancelVoice"];
//    }
//    [_timer invalidate];
//}
//
//- (NSString *)currentRecordFileName
//{
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
//    NSString *fileName = [NSString stringWithFormat:@"%ld",(long)timeInterval];
//    return fileName;
//}
//
////- (ICVoiceHud *)voiceHud
//{
//    if (!_voiceHud) {
//        _voiceHud = [[ICVoiceHud alloc] initWithFrame:CGRectMake(0, 0, 155, 155)];
//        _voiceHud.hidden = YES;
//        _voiceHud.center = CGPointMake(WIDTH_SCREEN/2, HEIGHT_SCREEN/2);
//        [self.view addSubview:_voiceHud];
//    }
//    return _voiceHud;
//}
//
//- (NSTimer *)timer
//{
//    if (!_timer) {
//        _timer =[NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
//    }
//    return _timer;
//}
//- (void)progressChange
//{
//    AVAudioRecorder *recorder = [[ICRecordManager shareManager] recorder] ;
//    [recorder updateMeters];
//    float power= [recorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0,声音越大power绝对值越小
//    CGFloat progress = (1.0/160)*(power + 160);
//    self.voiceHud.progress = progress;
//}

//#pragma mark - UICollectionView DataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.imageModels.count;
//}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    MLImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass([MLImageCell class])
//                                                                       forIndexPath: indexPath];
//    imageCell.imageModel = self.imageModels[indexPath.item];
//    return imageCell;
//}

#pragma mark - UICollectionView Delegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    // 获取 Model
//    MLImageModel *imageModel = self.imageModels[indexPath.item];
//    
//    // 判断 Model 的类型
//    switch (imageModel.modelType) {
//        case MLImageModelTypePlaceholder: { // 如果是 PlaceHolder 类型, 则需要调起相机或者相册让用户选图片, 我在这里是假装用户选择了一张图片.
//            [self selectPhotoWithSuccessBlock:^(UIImagePickerController *imagePickerViewController, NSDictionary<NSString *,id> *info) {
//                UIImage *image = info[UIImagePickerControllerEditedImage];
//                
//                // 创建数据模型
//                MLImageModel *imageModel = [MLImageModel new];
//                imageModel.image = image;
//                
//                // 重新配置数组, 你应该把这个图片放在数组的倒数第二位, 因为倒数第一位应该是占位图
//                NSInteger count = self.imageModels.count;
//                [self.imageModels insertObject: imageModel
//                                       atIndex: count-1];
//                
//                // 在这里你需要判断是否已经超出了最大值, 如果超出了最大值, 你需要删除掉最后一个占位图
//                if (self.imageModels.count > kMaxCount) {
//                    [self.imageModels removeObjectAtIndex: self.imageModels.count-1];
//                }
//                
//                [self.collectionView reloadData];
//                
//                
//            } cancelBlock:^(UIImagePickerController *imagePickerViewController) {}];
//            
//        }
//            break;
//            
//        case MLImageModelTypeImage: { // 如果是 Image 类型, 在这里可以做删除图片的操作, 也可以不做任何操作, 主要看你的业务逻辑, 我在这里写的是删除图片的操作.
//            
//            // 我在这里模拟做一下删除图片的操作, 你需要删除的是对应下标的图片
//            [self.imageModels removeObjectAtIndex: indexPath.item];
//            
//            // 在这里判断最后一张是不是占位图, 如果是占位图则什么操作都不用做, 如果不是占位图, 则需要添加一个占位图的数据模型
//            MLImageModel *imageModel = [self.imageModels lastObject];
//            if (imageModel.modelType != MLImageModelTypePlaceholder) {
//                
//                MLImageModel *placeHolderModel = [MLImageModel new];
//                [self.imageModels addObject: placeHolderModel];
//            }
//        }
//            break;
//    }
//    
//    // 刷新 CollectionView
//    [self.collectionView reloadData];
//}


#pragma mark - Lazy load
//- (UICollectionViewFlowLayout *)layout {
//    if (!_layout) {
//        _layout = [[UICollectionViewFlowLayout alloc] init];
//        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _layout.minimumInteritemSpacing = 10;
//        _layout.minimumLineSpacing = 10;
//        _layout.sectionInset = UIEdgeInsetsZero;
//        _layout.itemSize = CGSizeMake(35, 35);
//    }
//    return _layout;
//}

//
//- (NSMutableArray<MLImageModel *> *)imageModels {
//    if (!_imageModels) {
//        _imageModels = [NSMutableArray arrayWithObject: [MLImageModel new]];
//        
//    }
//    return _imageModels;
//}


@end
