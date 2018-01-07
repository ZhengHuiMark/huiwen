//
//  yuyinView.m
//  录音demo
//
//  Created by 刘培策 on 2017/11/9.
//  Copyright © 2017年 lzhl_iOS. All rights reserved.
//

#import "yuyinView.h"
#import "ICRecordManager.h"
#import "VoiceConverter.h"

@interface yuyinView () <ICRecordManagerDelegate>

@property (nonatomic, strong) UIButton    *voiceButton;
@property (nonatomic, strong) UILabel     *durationLabel;
@property (nonatomic, strong) UIImageView *voiceIcon;

@property (nonatomic, strong) UIImageView *currentVoiceIcon;


@end

@implementation yuyinView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"voice3"].CGImage);
    [self addSubview:self.voiceIcon];
    [self addSubview:self.durationLabel];
    [self addSubview:self.voiceButton];
}

- (void)setPathStr:(NSString *)pathStr {
    
    _pathStr = pathStr;
    NSString *voicePath = [self mediaPath:pathStr];
    self.durationLabel.text  = [NSString stringWithFormat:@"%ld''",[[ICRecordManager shareManager] durationWithVideo:[NSURL fileURLWithPath:voicePath]]];
    
    self.voiceIcon.image = [UIImage imageNamed:@"voice3"];
    UIImage *image1 = [UIImage imageNamed:@"voice1"];
    UIImage *image2 = [UIImage imageNamed:@"voice2"];
    UIImage *image3 = [UIImage imageNamed:@"voice3"];
    self.voiceIcon.animationImages = @[image1, image2, image3];
    self.voiceIcon.animationDuration = 0.8;
    
}
// 文件路径
- (NSString *)mediaPath:(NSString *)originPath
{
    // 这里文件路径重新给，根据文件名字来拼接
    NSString *name = [[originPath lastPathComponent] stringByDeletingPathExtension];
    return [[ICRecordManager shareManager] receiveVoicePathWithFileKey:name];
}


#pragma mark - respond Method
- (void)voiceButtonClicked:(UIButton *)voiceBtn {
    
    voiceBtn.selected = !voiceBtn.selected;
    
    [self chatVoiceTapedMediaPath:self.pathStr VoiceIcon:self.voiceIcon redView:nil];
}


#pragma mark - Getter

- (UIButton *)voiceButton
{
    if (nil == _voiceButton) {
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceButton addTarget:self action:@selector(voiceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _voiceButton.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
    return _voiceButton;
}


- (UILabel *)durationLabel
{
    if (nil == _durationLabel ) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.font = [UIFont systemFontOfSize:20];
        _durationLabel.frame = CGRectMake(self.bounds.size.width + 10, self.bounds.size.height/2-10, 30, 20);
    }
    return _durationLabel;
}

- (UIImageView *)voiceIcon
{
    if (nil == _voiceIcon) {
        _voiceIcon = [[UIImageView alloc] init];
        
        _voiceIcon.frame = CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height);
    }
    return _voiceIcon;
}



// play voice
- (void)chatVoiceTapedMediaPath:(NSString *)path
                      VoiceIcon:(UIImageView *)voiceIcon
                        redView:(UIView *)redView
{
    // 文件路径
    NSString *voicePath = [self mediaPath:path];
    NSString *amrPath   = [[voicePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"amr"];
    [VoiceConverter ConvertAmrToWav:amrPath wavSavePath:voicePath];
    

    ICRecordManager *recordManager = [ICRecordManager shareManager];
    recordManager.playDelegate = self;
    
    [[ICRecordManager shareManager] startPlayRecorder:voicePath];
    [voiceIcon startAnimating];
    self.currentVoiceIcon = voiceIcon;
}


- (void)voiceDidPlayFinished
{
    ICRecordManager *manager = [ICRecordManager shareManager];
    manager.playDelegate = nil;
    [self.currentVoiceIcon stopAnimating];
    self.currentVoiceIcon = nil;
}

@end
