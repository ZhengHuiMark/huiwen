//
//  MLTableView.h
//  Test Home Page
//
//  Created by  Liguoan on 13/02/2017.
//  Copyright © 2017 LinkBike. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAllModel;


@protocol ZHDropMenuProtocol <NSObject>

- (NSString *)title;

- (NSString *)searchCode;

@end

@interface ZHFoucsTableView : UIView

+ (instancetype)tableViewWithDropMenu:(NSArray <NSArray <id <ZHDropMenuProtocol>>*>*)dropMenuData frame:(CGRect)frame inView:(UIView *)superView;

@property (nonatomic, strong) NSArray <NSArray <id <ZHDropMenuProtocol>>*>* dropMenuData;

@property (nonatomic, assign) NSInteger requestType; // 用这个字段判断 用哪个接口

@property(nonatomic,copy) void(^FocusCellSelectPush)(ZHAllModel *model);

@end
