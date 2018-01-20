//
//  ExpertInformation.h
//  ZH
//
//  Created by 旭东 on 2018/1/2.
//  Copyright © 2018年 yangxudong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 专家模型对象(自己可更改)
 */
@class certifications;
@interface expert : NSObject

@property (nonatomic, copy) NSString *birthdate;
@property (nonatomic, copy) NSString *business;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *duty;
@property (nonatomic, copy) NSString *identityCardFront;
@property (nonatomic, copy) NSString *identityCardReverse;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *locus;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *realPhoto;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSMutableArray<certifications *> *certifications;

@end

/**
 birthdate 出生日期 string
 business 擅长业务 string
 
 certifications 专家身份认证 array<object>
 certificate1 证书1 string
 certificate2 证书2 string
 certificate3 证书3 string
 type 认证类型（专家身份） number
 
 company 企业名称 string
 duty 职务 string
 identityCardFront 身份证_正面 string
 identityCardReverse 身份证_反面 string
 intro 个人简介 string
 locus 所在地 string
 nickname 专家昵称 string
 realPhoto 真实照片 string
 realname 真实姓名 string
 sex 性别
 */
