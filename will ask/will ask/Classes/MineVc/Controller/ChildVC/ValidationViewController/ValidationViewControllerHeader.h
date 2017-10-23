//
//  ValidationViewControllerHeader.h
//  will ask
//
//  Created by 郑晖 on 2017/9/29.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#ifndef ValidationViewControllerHeader_h
#define ValidationViewControllerHeader_h



/** 专家认证页面 Section 数量*/
static NSInteger const kValidationViewControllerSectionCount = 4;
/** 用户头像 row 数量*/
static NSInteger const kValidationViewControllerSectionRowCountInSectionUserAvatar = 1;
/** 用户信息 row 数量*/
static NSInteger const kValidationViewControllerSectionRowCountInSectionUserInfo = 9;
/** 证书认证 row 数量*/
static NSInteger const kValidationViewControllerSectionRowCountInSectionCertificate = 4;
/** 专家选项 row 数量*/
static NSInteger const kValidationViewControllerSectionRowCountInSectionCertificateType = 1;
/** 身份证   row 数量*/
static NSInteger const kValidationViewControllerSectionRowCountInSectionIdentity = 1;

/** 用户头像 Section */
static NSInteger const kValidationViewControllerSection_Avatar = 0;
/** 用户信息 Section */
static NSInteger const kValidationViewControllerSection_UserInfo = 1;
/** 身份证 Section */
static NSInteger const kValidationViewControllerSection_Identity = 2;
/** 选择证书 Section */
static NSInteger const kValidationViewControllerSectionCertificateType = 3;
/** 用户证书 Section */
static NSInteger const kValidationViewControllerSection_Certificate = 4;


/** 用户头像 Section 的第一行是 用户选择头像 Cell */
static NSInteger const kValidationViewControllerRow_Avatar = 0;

/** 用户信息 Section 的第一行是 用户真实姓名 Cell */
static NSInteger const kValidationViewControllerRow_RealName = 0;
/** 用户信息 Section 的第二行是 用户性别    Cell */
static NSInteger const kValidationViewControllerRow_ExpertName = 1;
/** 用户信息 Section 的第二行是 用户性别    Cell */
static NSInteger const kValidationViewControllerRow_Gender = 2;
/** 用户信息 Section 的第三行是 用户位置    Cell */
static NSInteger const kValidationViewControllerRow_Location = 3;
/** 用户信息 Section 的第四行是 出生日期    Cell */
static NSInteger const kValidationViewControllerRow_Birthday = 4;
/** 用户信息 Section 的第五行是 公司名称    Cell */
static NSInteger const kValidationViewControllerRow_CompanyName = 5;
/** 用户信息 Section 的第六行是 用户位置    Cell */
static NSInteger const kValidationViewControllerRow_Position = 6;
/** 用户信息 Section 的第七行是 用户位置    Cell */
static NSInteger const kValidationViewControllerRow_Business = 7;
/** 用户信息 Section 的第八行是 用户位置    Cell */
static NSInteger const kValidationViewControllerRow_PersonalProfile = 8;

/** 用户身份证 Section 的第一行是 身份证正反面    Cell */
static NSInteger const kValidationViewControllerRow_Identity = 0;


/** 专家信息选择 Section 的第一行是 专家信息选择    Cell */
static NSInteger const kValidationViewControllerRow_CertificateType = 0;


/** 用户证书 Section 的第一行是 注册会计师    Cell */
static NSInteger const kValidationViewControllerRow_ZCKJS = 0;
/** 用户证书 Section 的第二行是 评估师       Cell */
static NSInteger const kValidationViewControllerRow_PGS = 1;
/** 用户证书 Section 的第三行是 税务师       Cell */
static NSInteger const kValidationViewControllerRow_SWS = 2;
/** 用户证书 Section 的第四行是 财务师       Cell */
static NSInteger const kValidationViewControllerRow_CWS = 3;

/** 用户头像 Cell 高度 */
static CGFloat const kValidationViewControllerRowHeight_Avatar = 115.0f;
/** 用户信息 Cell 高度 */
static CGFloat const kValidationViewControllerRowHeight_UserInfo = 44.0f;
/** 身份证 Cell 高度 */
static CGFloat const kValidationViewControllerRowHeight_Identity = 190.0f;
/** 专家选择 Cell 高度 */
static CGFloat const kValidationViewControllerRowHeight_CertificateType = 102.0f;
/** 专家图片 Cell 高度 */
static CGFloat const kValidationViewControllerRowHeight_Certificate = 217.0f;


/** Table footer view 高度 */
static CGFloat const kValidationViewControllerFooterViewHeight = 44.0f;
/** 立即认证按钮高度 */
static CGFloat const kValidationViewControllerBtnValidationHeight = 30.0f;
/** 立即认证按钮标题 */
static NSString *const kValidationViewcontrlllerBtnValidationTitle = @"立即认证";
/** 立即认证按钮左侧到屏幕左侧的间距 */
static CGFloat const kValidationViewControllerBtnValidationMarginLeft = 64.0f;
/** 立即认证按钮右侧到屏幕右侧的间距 */
static CGFloat const kValidationViewControllerBtnValidationMarginRight = 64.0f;



#endif /* ValidationViewControllerHeader_h */
