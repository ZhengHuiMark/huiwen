//
//  UserModel.h
//  will ask
//
//  Created by 郑晖 on 2017/9/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/** 用户头像 */
@property(nonatomic , copy)NSString *avatar;
/** 用户昵称 */
@property(nonatomic , copy)NSString *nickname;
/** 性别 */
@property(nonatomic , copy)NSString *sex;
/** token */
@property (nonatomic, copy) NSString *token;
/** 资源上传id*/
@property(nonatomic , copy)NSString *resourceId;

@property(nonatomic,assign) NSNumber *tokenExpires;
/** 会员卡余额 */
@property(nonatomic,  copy)NSString *cardBalance;
/** 有多少人关注 */
@property(nonatomic,  copy)NSString *concernNum;
/** 是否是专家 */
@property(nonatomic,  copy)NSString *expertCertified;
/** 专家审核状态 */
@property(nonatomic,  copy)NSString *expertCheckStatus;
/** 专家昵称 */
@property(nonatomic,  copy)NSString * expertNickname;
/** 会员卡余额 */
@property(nonatomic,  copy)NSString *myEarnings;
/** 会员卡余额 */
@property(nonatomic,  copy)NSString *realPhoto;
/** */
@property(nonatomic,  copy)NSString *ConsultsNew;





@end
