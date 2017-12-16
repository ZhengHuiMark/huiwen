//
//  Invoice.h
//  will ask
//
//  Created by 郑晖 on 2017/12/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#ifndef Invoice_h
#define Invoice_h

/** 发票详细信息 section 一共有多少个cell */
static NSInteger const kInvoiceViewControllerSectionRowCountInSection = 6;
/** 发票邮寄信息 section 一共有多少个cell */
static NSInteger const kInvoiceViewControllerSectionRowCountInSectionInvoice = 4;




/** 发票详细信息 section 第一行是 抬头 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSection_title = 0;
/** 发票详细信息 section 第二行是 税号 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSection_ein = 1;
/** 发票详细信息 section 第三行是 单位地址 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSection_address = 2;
/** 发票详细信息 section 第四行是 电话号码 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSection_phoneNumber = 3;
/** 发票详细信息 section 第五行是 开户银行 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSection_bank = 4;
/** 发票详细信息 section 第六行是 银行账号 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSection_bankNumber = 5;

/** 发票邮寄信息 section 第一行是 收件人姓名 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptName = 0;
/** 发票邮寄信息 section 第二行是 收件人手机号 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptPhoneNumber = 1;
/** 发票邮寄信息 section 第三行是 收件人地址 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptAddress = 2;
/** 发票邮寄信息 section 第四行是 邮编 */
static NSInteger const kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptCode = 3;

#endif /* Invoice_h */
