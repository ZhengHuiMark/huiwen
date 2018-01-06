//
//  ICChatBox.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/10.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEIGHT_TABBAR       75     // 就是chatBox的高度

#define HEIGHT_SCREEN       [UIScreen mainScreen].bounds.size.height
#define WIDTH_SCREEN        [UIScreen mainScreen].bounds.size.width

#define     CHATBOX_BUTTON_WIDTH        75
#define     HEIGHT_TEXTVIEW             HEIGHT_TABBAR * 0.74
#define     MAX_TEXTVIEW_HEIGHT         104

#define videwViewH HEIGHT_SCREEN * 0.64 // 录制视频视图高度
#define videwViewX HEIGHT_SCREEN * 0.36 // 录制视频视图X


typedef NS_ENUM(NSInteger, ICChatBoxStatus) {
    ICChatBoxStatusNothing,     // 默认状态
    ICChatBoxStatusShowVoice,   // 录音状态
    ICChatBoxStatusShowFace,    // 输入表情状态
    ICChatBoxStatusShowMore,    // 显示“更多”页面状态
    ICChatBoxStatusShowKeyboard,// 正常键盘
    ICChatBoxStatusShowVideo    // 录制视频
};


@class ICChatBox;
@protocol ICChatBoxDelegate <NSObject>

/**
 *  开始录音
 *
 *  @param chatBox chatBox
 */
- (void)chatBoxDidStartRecordingVoice:(ICChatBox *)chatBox;
- (void)chatBoxDidStopRecordingVoice:(ICChatBox *)chatBox;
- (void)chatBoxDidCancelRecordingVoice:(ICChatBox *)chatBox;
- (void)chatBoxDidDrag:(BOOL)inside;


@end


@interface ICChatBox : UIView
/** 保存状态 */
@property (nonatomic, assign) ICChatBoxStatus status;

@property (nonatomic, weak) id<ICChatBoxDelegate>delegate;

/** 输入框 */
@property (nonatomic, strong) UITextView *textView;


@end
