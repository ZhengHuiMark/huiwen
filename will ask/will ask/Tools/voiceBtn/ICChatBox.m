//
//  ICChatBox.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/10.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICChatBox.h"

@interface ICChatBox ()<UITextViewDelegate>

/** 按住说话 */
@property (nonatomic, strong) UIButton *talkButton;

@end

@implementation ICChatBox

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:self.talkButton];
        self.status = ICChatBoxStatusNothing; // 起始状态
    }
    return self;
}


#pragma mark - Getter and Setter

- (UIButton *) talkButton
{
    if (_talkButton == nil) {
        _talkButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height , 75)];
//        [_talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_talkButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
        [_talkButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateHighlighted];
//        [_talkButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
//        [_talkButton setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] forState:UIControlStateNormal];
//        [_talkButton setBackgroundImage:[UIImage gxz_imageWithColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5]] forState:UIControlStateHighlighted];
//        [_talkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_talkButton.layer setMasksToBounds:YES];
        [_talkButton.layer setCornerRadius:4.0f];
        [_talkButton.layer setBorderWidth:0.5f];
        [_talkButton addTarget:self action:@selector(talkButtonDown:) forControlEvents:UIControlEventTouchDown];
        [_talkButton addTarget:self action:@selector(talkButtonUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_talkButton addTarget:self action:@selector(talkButtonUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [_talkButton addTarget:self action:@selector(talkButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
//        [_talkButton addTarget:self action:@selector(talkButtonDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
        [_talkButton addTarget:self action:@selector(talkButtonDragInside:) forControlEvents:UIControlEventTouchDragInside];
        [_talkButton addTarget:self action:@selector(talkButtonDragInside:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
    }
    return _talkButton;
}

#pragma mark - Event Response

// 说话按钮
- (void)talkButtonDown:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxDidStartRecordingVoice:)]) {
        [_delegate chatBoxDidStartRecordingVoice:self];
    }
}

- (void)talkButtonUpInside:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxDidStopRecordingVoice:)]) {
        [_delegate chatBoxDidStopRecordingVoice:self];
    }
}

- (void)talkButtonUpOutside:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxDidCancelRecordingVoice:)]) {
        [_delegate chatBoxDidCancelRecordingVoice:self];
    }
}

//- (void)talkButtonDragOutside:(UIButton *)sender
//{
//    if ([_delegate respondsToSelector:@selector(chatBoxDidDrag:)]) {
//        NSLog(@"talkButtonDragOutside  NO ");
//        [_delegate chatBoxDidDrag:NO];
//    }
//}

- (void)talkButtonDragInside:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(chatBoxDidDrag:)]) {
        
        NSLog(@"talkButtonDragInside YEs");
        [_delegate chatBoxDidDrag:YES];
    }
}

- (void)talkButtonDragInside:(UIButton *)sender withEvent:(UIEvent *)myEvent {
    
    UITouch *touch = [[myEvent allTouches] anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    BOOL isIn = CGRectContainsPoint(self.bounds, point);
    
    if (isIn) {
    }else {
        if ([_delegate respondsToSelector:@selector(chatBoxDidDrag:)]) {
            
            NSLog(@"talkButtonDragInside NO");
            [_delegate chatBoxDidDrag:NO];
        }
    }
}


- (void)talkButtonTouchCancel:(UIButton *)sender {
    
}

@end
