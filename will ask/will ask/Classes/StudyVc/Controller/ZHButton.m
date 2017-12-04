//
//  ZHButton.m
//  Test Home Page
//
//  Created by  Liguoan on 13/02/2017.
//  Copyright © 2017 LinkBike. All rights reserved.
//

#import "ZHButton.h"

#define kButtonFont [UIFont systemFontOfSize: 16]

/** 标题到左侧间距 */
static NSInteger const kButtonTitleLeftMargin = 10;
/** 标题到右侧间距 */
static NSInteger const kButtonTitleRightMargin = 10;

@interface ZHButton ()

@property (nonatomic, copy) NSString *buttonTitle;

@property (nonatomic, assign) CGPoint origin;

@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end

@implementation ZHButton
#pragma mark - Constructor
+ (instancetype)buttonWithTitle:(NSString *)title origin:(CGPoint)origin inView:(UIView *)superView {
    
    ZHButton *button = [[[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class])
                                                     owner: nil
                                                    options: nil] firstObject];
    [superView addSubview: button];
    [button updateButtonWithTitle: title origin: origin];
    return button;
}


#pragma mark - Override Getter/Setter Methods
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    // Configure UI
    [self configureUI];
}

- (void)setAModel:(AModel *)aModel {
    _aModel = aModel;
    
    [self configureUI];
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = buttonTitle;
    
    

    // Button title
    [self.titleButton setTitle: buttonTitle forState: UIControlStateNormal];
    
    
    // Update frame
    [self updateFrame];
}

- (NSString *)title {
    return self.buttonTitle;
}

#pragma mark - Public methods
- (void)updateButtonWithTitle:(NSString *)title origin:(CGPoint)origin {
    self.origin = origin;
    self.buttonTitle = title;
    
}

#pragma mark - Private methods
- (void)configureUI {
    
    if (self.aModel.isSelected) {
        [self.titleButton setTitleColor: [UIColor colorWithRed:30/255.0 green:157/255.0 blue:252/255.0 alpha:1]
                               forState: UIControlStateNormal];
        self.bottomView.hidden = NO;
    } else {
        [self.titleButton setTitleColor: [UIColor blackColor]
                               forState: UIControlStateNormal];
        self.bottomView.hidden = YES;
    }
    
    if (self.aModel.ASCType == EnumASCTypeNone) {
        self.backgroundColor = [UIColor whiteColor];
    } else if (self.aModel.ASCType == EnumASCTypeJiang) {
        self.backgroundColor = [UIColor redColor];
    } else if (self.aModel.ASCType == EnumASCTypeSheng) {
        self.backgroundColor = [UIColor greenColor];
    }
}

- (void)updateFrame {
    
    CGFloat buttonWidth = [self.titleButton.titleLabel.text boundingRectWithSize: CGSizeMake(kButtonMaxWidth, 20)
                                                                         options: NSStringDrawingUsesLineFragmentOrigin
                                                                      attributes: @{NSFontAttributeName : kButtonFont}
                                                                         context: nil].size.width;
    
    if (buttonWidth + kButtonTitleLeftMargin + kButtonTitleRightMargin <= kButtonMinWidth) buttonWidth = kButtonMinWidth;
    
    self.frame = (CGRect){self.origin, {buttonWidth, kButtonHeight}};
}

#pragma mark - Actions
- (IBAction)buttonAction:(UIButton *)sender {
    
    self.aModel.selected = !self.aModel.selected;
    
    !self.buttonAction?:self.buttonAction(self,self.aModel);
}





@end
