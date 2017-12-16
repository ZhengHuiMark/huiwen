//
//  ZHInvoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHInvoiceTableViewCell.h"
#import "Invoice.h"
#import "ZHInvoiceModel.h"

@interface ZHInvoiceTableViewCell()<UITextFieldDelegate>

@end

@implementation ZHInvoiceTableViewCell

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
        case kInvoiceViewControllerSectionRowCountInSection_title:{
            self.contentTextFiled.text = self.model.invoiceTitle;
            
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_ein:{
            self.contentTextFiled.text = self.model.dutyParagraph;
            
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_address:{
            self.contentTextFiled.text = self.model.companyAddress;
            
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_phoneNumber:{
            self.contentTextFiled.text = self.model.phone;
            
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_bank:{
            self.contentTextFiled.text = self.model.depositBank;
            
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_bankNumber:{
            self.contentTextFiled.text = self.model.bankAccount;
            
        }
            break;
            

        default:
            break;
    }
    
}


-(void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
    
    switch (indexPath.row) {
        case kInvoiceViewControllerSectionRowCountInSection_title:{
            self.titleLabel.text = @"抬头:";
            
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_ein:{
            self.titleLabel.text = @"税号:";

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_address:{
            self.titleLabel.text = @"单位地址:";

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_phoneNumber:{
            self.titleLabel.text = @"电话号码:";

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_bank:{
            self.titleLabel.text = @"开户银行:";

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_bankNumber:{
            self.titleLabel.text = @"银行账号:";

        }
            break;
       
            
        default:
            break;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    switch (self.indexPath.row) {
            
        case kInvoiceViewControllerSectionRowCountInSection_title:{
            return YES;
        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_ein:{
            return YES;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_address:{
            return YES;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_phoneNumber:{
            return YES;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_bank:{
            return YES;

        }
            break;
        case kInvoiceViewControllerSectionRowCountInSection_bankNumber:{
            return YES;

        }
            break;
            
        default:
            break;
    }
 
    
    return YES;
}

@end
