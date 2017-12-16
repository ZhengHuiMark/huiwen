//
//  ZHInvoiceModel.h
//  will ask
//
//  Created by 郑晖 on 2017/12/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHInvoiceModel : NSObject

/** 银行账户 */
@property(nonatomic,copy)NSString *bankAccount;
/** 公司地址 */
@property(nonatomic,copy)NSString *companyAddress;
/** 开户银行 */
@property(nonatomic,copy)NSString *depositBank;
/** 税号 */
@property(nonatomic,copy)NSString *dutyParagraph;
/** 抬头 */
@property(nonatomic,copy)NSString *invoiceTitle;
/** 电话号码 */
@property(nonatomic,copy)NSString *phone;
/** 邮编 */
@property(nonatomic,copy)NSString *postcode;
/** 收件人 */
@property(nonatomic,copy)NSString *recipient;
/** 收件地址 */
@property(nonatomic,copy)NSString *recipientAddress;
/** 收件人手机号 */
@property(nonatomic,copy)NSString *recipientMobile;

@end
