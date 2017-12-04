//
//  MLAvatarDisplayView.m
//
//  Created by Liguoan on 13/04/2017.
//  Copyright © 2017 Liguoan. All rights reserved.
//

#import "MLAvatarDisplayView.h"

@interface MLAvatarDisplayView () {
    __kindof UIView *_fromView;
    BOOL _isAnimating;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation MLAvatarDisplayView
#pragma mark - Constructor
+ (instancetype)ml_singleImageDisplayView {
    return [self ml_singleImageDisplayViewInView: [UIApplication sharedApplication].keyWindow];
}

+ (instancetype)ml_singleImageDisplayViewInView:(UIView *)superView {
    MLAvatarDisplayView *imageDisplayView = [[[self class] alloc] init];
    imageDisplayView.frame = superView.bounds;
    [superView addSubview: imageDisplayView];
    return imageDisplayView;
}

- (instancetype)init {
    if (self = [super init]) {
        
        // Setup vars
        [self setupUI];
        
        // Setup gesture
        [self setupGesture];
    }
    return self;
}

#pragma mark - Basic setup
- (void)setupUI {
    
    self.alpha = 0.0f;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.9f];
}

- (void)setupGesture {
    
    [self addGestureRecognizer: self.tapGesture];
}

#pragma mark - Public methods
- (void)showFromButton:(UIButton *)button {
    if (!button) return;
    self.imageView.image = button.imageView.image;
    [self showFromView: button];
}

- (void)showFromImageView:(UIImageView *)imageView {
    if (!imageView) return;
    self.imageView.image = imageView.image;
    [self showFromView: imageView];
}

#pragma mark - Private methods
- (void)showFromView:(__kindof UIView *)fromView {
    
    if (_isAnimating) return;
    _isAnimating = YES;
    _fromView = fromView;
    self.imageView.frame = [self beginFrame];

    [UIView animateWithDuration: kMLSingleImageDisplayView_AnimationDuration animations:^{
        self.imageView.frame = [self finalFrame];
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        _isAnimating = NO;
        self.tapGesture.enabled = YES;
    }];
}

- (CGRect)beginFrame {
    return [self convertRect: _fromView.frame fromView: _fromView.superview];
}

- (CGRect)finalFrame {
    
    UIImage *image = self.imageView.image;
    CGFloat scale = image.size.height/image.size.width;
    CGFloat imgViewWidth = CGRectGetWidth(self.frame) - self.contentInset.left - self.contentInset.right;
    CGFloat imgViewHeight = imgViewWidth * scale;
    CGFloat imgViewX = CGRectGetWidth (self.frame)*0.5 - imgViewWidth *0.5;
    CGFloat imgViewY = CGRectGetHeight(self.frame)*0.5 - imgViewHeight*0.5;
    
    return CGRectMake(imgViewX, imgViewY, imgViewWidth, imgViewHeight);
}

- (void)dismiss {
    
    if (_isAnimating) return;
    _isAnimating = YES;
    self.tapGesture.enabled = NO;
    
    [UIView animateWithDuration: kMLSingleImageDisplayView_AnimationDuration animations:^{
        self.imageView.frame = [self beginFrame];
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        _isAnimating = NO;
    }];
}

#pragma mark - Actions
- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self dismiss];
}

#pragma mark - Lazy load
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self addSubview: _imageView];
    }
    return _imageView;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                              action: @selector(tapAction:)];
    }
    return _tapGesture;
}

@end
