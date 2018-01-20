//
//  EditPersonal.h
//  will ask
//
//  Created by 郑晖 on 2017/9/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#ifndef EditPersonal_h
#define EditPersonal_h

static NSInteger const kValidationViewControllerSectionRowCountInSectionAvatar = 1;

static NSInteger const kValidationViewControllerSectionRowCountInSectionUserInfo = 7;

static NSInteger const kValidationViewControllerSection_UserInfo = 1;


static NSInteger const kValidationViewControllerSection_Avatar = 0;

/** 用户信息 Section 的第一行是 用户昵称 Cell */
static NSInteger const kValidationViewControllerRow_NickName = 0;

/** 用户信息 Section 的第一行是 用户真实姓名 Cell */
static NSInteger const kValidationViewControllerRow_RealName = 1;

/** 用户信息 Section 的第二行是 用户性别    Cell */
static NSInteger const kValidationViewControllerRow_Gender = 2;

/** 用户信息 Section 的第三行是 用户位置    Cell */
static NSInteger const kValidationViewControllerRow_Location = 3;

/** 用户信息 Section 的第一行是 出生日期 Cell */
static NSInteger const kValidationViewControllerRow_Date = 4;

/** 用户信息 Section 的第一行是 公司名称 Cell */
static NSInteger const kValidationViewControllerRow_Company = 5;

/** 用户信息 Section 的第一行是 职务 Cell */
static NSInteger const kValidationViewControllerRow_Position = 6;





#endif /* EditPersonal_h */
