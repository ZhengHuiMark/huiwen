//
//  MessageViewCell.m
//  messageDemo
//
//  Created by 刘培策 on 2018/1/14.
//  Copyright © 2018年 UniqueCe. All rights reserved.
//

#import "MessageViewCell.h"


#define HookBtnEditeWidth self.hookButton.frame.size.width+self.hookButton.frame.origin.x


@interface MessageViewCell ()

@property(nonatomic,strong) UIImageView *pictureImageView;

@property(nonatomic,strong) UIImageView *redImageView;

@property(nonatomic,strong) UILabel *nameLabel;

@property(nonatomic,strong) UILabel *messageLabel;

@property(nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,strong) UIButton *hookButton;

@end

@implementation MessageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.pictureImageView];
    [self.contentView addSubview:self.redImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.hookButton];
}

- (void)hookButtonClickAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.models.isMessageSelection = sender.selected;
    
    
    if (self.hookButtonClickBlock) {
        self.hookButtonClickBlock();
    }
    
}

- (void)setModels:(JPushMessageModel *)models {
    
    _models = models;
    
    self.nameLabel.text = models.title;
    self.messageLabel.text = models.content;
    self.timeLabel.text = models.time;
    self.hookButton.hidden = models.isHiddenChooseBtn;
    self.hookButton.tag = [models.objectId integerValue];
    
    if (self.hookButton.hidden) {
        self.pictureImageView.frame = CGRectMake(17.5, 12.5, 45, 45);
        self.redImageView.frame = CGRectMake(72.5, 22, 7.5, 7.5);
        self.nameLabel.frame = CGRectMake(_pictureImageView.bounds.size.width+_pictureImageView.frame.origin.x+10, 19, 100, 15);
        self.messageLabel.frame = CGRectMake(72.5, 39.5, [UIScreen mainScreen].bounds.size.width - 72.5-15, 15);
    }else {
        self.pictureImageView.frame = CGRectMake(17.5+HookBtnEditeWidth, 12.5, 45, 45);
        self.redImageView.frame = CGRectMake(72.5+HookBtnEditeWidth, 22, 7.5, 7.5);
        self.nameLabel.frame = CGRectMake(_pictureImageView.bounds.size.width+_pictureImageView.frame.origin.x+10, 19, 100, 15);
        self.messageLabel.frame = CGRectMake(72.5+HookBtnEditeWidth, 39.5, [UIScreen mainScreen].bounds.size.width - 72.5-15, 15);
    }
    
    self.redImageView.hidden = models.isRead;
    
    if (self.redImageView.hidden) {
        self.nameLabel.frame = CGRectMake(_pictureImageView.bounds.size.width+_pictureImageView.frame.origin.x+10, 19, 100, 15);
    }else {
        self.nameLabel.frame = CGRectMake(_pictureImageView.bounds.size.width+_pictureImageView.frame.origin.x+_redImageView.bounds.size.width+20, 19, 100, 15);
    }
    
    if (models.isMessageSelection) {
        self.hookButton.selected = YES;
    }else {
        self.hookButton.selected = NO;
    }
    
    
    switch ([models.msgType integerValue]) {
        case 1:
            self.pictureImageView.image = [UIImage imageNamed:@"会问"];
            break;
        case 2:
            self.pictureImageView.image = [UIImage imageNamed:@"case"];
            break;
        case 3:
            self.pictureImageView.image = [UIImage imageNamed:@"reward"];
            break;
        case 4:
            self.pictureImageView.image = [UIImage imageNamed:@"expert"];
            break;
    }
    
}


- (UIImageView *)pictureImageView {
    
    if (!_pictureImageView) {
        _pictureImageView = [UIImageView new];
        _pictureImageView.backgroundColor = [UIColor blueColor];
        _pictureImageView.frame = CGRectMake(17.5, 12.5, 45, 45);
        _pictureImageView.layer.masksToBounds = YES;
        _pictureImageView.layer.cornerRadius = 45.0f/2;
    }
    return _pictureImageView;
}

- (UIImageView *)redImageView {
    
    if (!_redImageView) {
        _redImageView = [UIImageView new];
        _redImageView.backgroundColor = [UIColor redColor];
        _redImageView.frame = CGRectMake(72.5, 22, 7.5, 7.5);
        _redImageView.layer.masksToBounds = YES;
        _redImageView.layer.cornerRadius = 7.5f/2;
        _redImageView.hidden = YES;
    }
    return _redImageView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"消息";
        _nameLabel.frame = CGRectMake(_pictureImageView.bounds.size.width+_pictureImageView.frame.origin.x+10, 19, 100, 15);
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}

- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.text = @"您的消息有人回到了。。。。。";
        _messageLabel.frame = CGRectMake(72.5, 39.5, [UIScreen mainScreen].bounds.size.width - 72.5-15, 15);
        _messageLabel.font = [UIFont systemFontOfSize:12];
    }
    return _messageLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"2017/10/11";
        _timeLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 17 - 120, 12, 120, 15);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UIButton *)hookButton {
    if (!_hookButton) {
        _hookButton = [[UIButton alloc] initWithFrame:CGRectMake(18, 24.5, 20, 20)];
        [_hookButton setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        [_hookButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [_hookButton addTarget:self action:@selector(hookButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hookButton;
}

@end
