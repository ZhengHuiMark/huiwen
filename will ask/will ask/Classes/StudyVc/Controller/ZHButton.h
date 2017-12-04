//
//  ZHButton.h
//  Test Home Page
//
//  Created by  Liguoan on 13/02/2017.
//  Copyright © 2017 LinkBike. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHButton, AModel;

/** 按钮最小宽度 */
static NSInteger const kButtonMinWidth = 80;
/** 按钮最大宽度 */
static NSInteger const kButtonMaxWidth = 200;
/** 按钮高度 */
static NSInteger const kButtonHeight = 90;

typedef void(^ZHButtonAction)(ZHButton *button ,AModel *model);

@interface ZHButton : UIView

@property (nonatomic, strong) AModel *aModel;


+ (instancetype)buttonWithTitle:(NSString *)title origin:(CGPoint)origin inView:(UIView *)superView;

@property (nonatomic, copy) ZHButtonAction buttonAction;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

- (void)updateButtonWithTitle:(NSString *)title origin:(CGPoint)origin;

@property (nonatomic, copy, readonly) NSString *title;

@property (weak, nonatomic) IBOutlet UIImageView *BtnImage;

- (void)configureUI;





@end



typedef NS_ENUM(NSUInteger, EnumASCType) {
    EnumASCTypeNone = 0,
    EnumASCTypeSheng,
    EnumASCTypeJiang
};

@interface AModel : NSObject

@property (nonatomic, assign, getter=isSelected) BOOL selected; // 是否选中
@property (nonatomic, copy) NSString *order; // 请求类型
@property (nonatomic, assign) EnumASCType ASCType; // 排序方式

@end
