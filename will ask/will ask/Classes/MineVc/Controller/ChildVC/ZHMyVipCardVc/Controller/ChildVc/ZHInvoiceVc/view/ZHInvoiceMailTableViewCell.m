//
//  ZHInvoiceMailTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHInvoiceMailTableViewCell.h"
#import "Invoice.h"
#import "ZHInvoiceModel.h"


@interface ZHInvoiceMailTableViewCell()<UITextFieldDelegate>

@end

@implementation ZHInvoiceMailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.contentTextFiled.delegate = self;
    
    //    _NameTextF.layer.borderWidth = 0;
    //    _NameTextF.layer.borderColor = [[UIColor grayColor]CGColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_contentTextFiled setBorderStyle:UITextBorderStyleNone];
}

- (void)setModel:(ZHInvoiceModel *)model{
    _model = model;
    
    switch (self.indexPath.row) {
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptName:{
            self.contentTextFiled.text = self.model.recipient;
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptPhoneNumber:{
            self.contentTextFiled.text = self.model.recipientMobile;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptAddress:{
            self.contentTextFiled.text = self.model.recipientAddress;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptCode:{
            self.contentTextFiled.text = self.model.postcode;

        }
            break;
        default:
            break;
    }
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    switch (indexPath.row) {
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptName:{
            self.titleLable.text = @"收件人姓名:";
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptPhoneNumber:{
            self.titleLable.text = @"收件人手机号:";

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptAddress:{
            self.titleLable.text = @"收件人地址:";

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptCode:{
            self.titleLable.text = @"邮编:";
            
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    switch (self.indexPath.row) {
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptName:{
            return YES;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptPhoneNumber:{
            return YES;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptAddress:{
            return YES;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSectionInvoice_ReceiptCode:{
            return YES;

        }
            break;
            
            
        default:
            break;
    }

    
    return YES;
}

@end
