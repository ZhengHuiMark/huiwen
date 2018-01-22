//
//  JPushMessageModel.h
//  demoPushMessage
//
//  Created by 郑晖 on 2018/1/16.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPushMessageModel : NSObject
/** 时间 yyyy-MM-dd HH:mm:ss*/
@property(nonatomic,copy)NSString *time;
/** 对象ID  点击消息跳转对应页面的业务ID*/
@property(nonatomic,copy)NSString *objectId;
/** 链接类型 
 链接类型
 编码
 无链接
 0
 专家服务页
 11
 专家认证申请页
 12
 悬赏问详情页
 21
 悬赏问提问-选择分类页
 22
 专家服务-我的案例详解
 31
 我的咨询详情页
 41
 专家服务-咨询我的详情页
 42
 专家服务-咨询我的问题列表页
 43
 点击消息跳转页面的类型 */
@property(nonatomic,copy)NSString *linkType;
/** 消息类型
 消息类型
 编码
 系统消息   1
 悬赏问    2
 案例详解   3
 咨询      4
 */
@property(nonatomic,copy)NSString *msgType;
/** 消息内容 */
@property(nonatomic,copy)NSString *content;
/** 消息标题 */
@property(nonatomic,copy)NSString *title;
/** 推送类型 固定值：1*/
@property(nonatomic,copy)NSString *pushType;

/** 选中状态 */
@property(nonatomic,assign) BOOL isMessageSelection;

/** 是否隐藏按钮 */
@property(nonatomic,assign) BOOL isHiddenChooseBtn;

/** 是否阅读 */
@property(nonatomic,assign) BOOL isRead;

@end
