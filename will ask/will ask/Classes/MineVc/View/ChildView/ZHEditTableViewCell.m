//
//  ZHEditTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHEditTableViewCell.h"
#import "EditPersonal.h"
#import "UserInfoModel.h"


@interface ZHEditTableViewCell () <UITextFieldDelegate>

@end

@implementation ZHEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.NameTextF.delegate = self;

//    _NameTextF.layer.borderWidth = 0;
//    _NameTextF.layer.borderColor = [[UIColor grayColor]CGColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [_NameTextF setBorderStyle:UITextBorderStyleNone];
    
}

- (void)setUserInfoModel:(UserInfoModel *)UserInfoModel{
    
    _UserInfoModel = UserInfoModel;
    
    switch (self.indexPath.row) {
        case kValidationViewControllerRow_NickName: {
            self.NameTextF.text = UserInfoModel.nickname;
        }
            break;
            
        case kValidationViewControllerRow_RealName: {
            self.NameTextF.text = UserInfoModel.realname;
        }
            break;
            
        case kValidationViewControllerRow_Gender: {
            if ([UserInfoModel.sex isEqualToString:@"1"] || [UserInfoModel.sex isEqualToString:@"男"]) {
                self.NameTextF.text = @"男";
            }else{
                self.NameTextF.text = @"女";
            }
            
//            self.NameTextF.text = UserInfoModel.sex;
        }
            break;
        case kValidationViewControllerRow_Location: {
            self.NameTextF.text = UserInfoModel.locus;
        }
            break;
        case kValidationViewControllerRow_Date: {
            self.NameTextF.text = UserInfoModel.birthdate;
        }
            break;
            
        case kValidationViewControllerRow_Company: {
            self.NameTextF.text = UserInfoModel.company;
        }
            break;
        case kValidationViewControllerRow_Position: {
            self.NameTextF.text = UserInfoModel.duty;
        }
            break;
        default:
            break;
    }

}


- (void)setIndexPath:(NSIndexPath *)indexPath {

    _indexPath = indexPath;
    
    switch (indexPath.row) {
        case kValidationViewControllerRow_NickName: {
            self.NameTextF.placeholder = @"必填";
            self.labelTitle.text = @"昵称:        ";
        }
            break;
            
        case kValidationViewControllerRow_RealName: {
            self.NameTextF.placeholder = @"选填";
            self.labelTitle.text = @"姓名:        ";
        }
            break;
            
        case kValidationViewControllerRow_Gender: {
            self.NameTextF.placeholder = @"选填";
            self.labelTitle.text = @"性别:        ";
        }
            break;
            
        case kValidationViewControllerRow_Location: {
            self.NameTextF.placeholder = @"选填";
            self.labelTitle.text = @"所在地:    ";
        }
            break;
            
            
            
        case kValidationViewControllerRow_Date: {
            self.NameTextF.placeholder = @"选填";
            self.labelTitle.text = @"出生日期:";
        }
            break;
            
            
        case kValidationViewControllerRow_Company: {
            self.NameTextF.placeholder = @"选填";
            self.labelTitle.text = @"企业名称:";
        }
            break;
            
        case kValidationViewControllerRow_Position: {
            self.NameTextF.placeholder = @"选填";
            self.labelTitle.text = @"职务:       ";
        }
            break;
            
        default:
            break;
    }

}



#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (self.indexPath.row) {
            
//            !self.didClick?:self.didClick(self.indexPath);
    
            
        case kValidationViewControllerRow_NickName: {
            return YES;
        }
            break;
            
        case kValidationViewControllerRow_RealName: {
            return YES;
        }
            break;
            
        case kValidationViewControllerRow_Gender: {
            !self.didClick?:self.didClick(self.indexPath);

            return NO;
        }
            break;
            
        case kValidationViewControllerRow_Location: {
           
            !self.LocationClick?:self.LocationClick(self.indexPath);

            
           return NO;
        }
            break;

        case kValidationViewControllerRow_Date: {
            !self.DateClick?:self.DateClick(self.indexPath);

            return NO;
        }
            break;
            
            
        case kValidationViewControllerRow_Company: {
            return YES;
        }
            break;
            
        case kValidationViewControllerRow_Position: {
           return YES;
        }
            break;
            

        default:
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    NSString *tempStr = @"";
    switch (self.indexPath.row) {
            
        case kValidationViewControllerRow_NickName:
            tempStr = @"nickname";
            break;
            
        case kValidationViewControllerRow_RealName:
            tempStr = @"realname";
            break;
            
        case kValidationViewControllerRow_Company:
            tempStr = @"company";
            break;
            
        case kValidationViewControllerRow_Position:
            tempStr = @"duty";
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textName" object:self userInfo:@{tempStr:textField.text}];
    
    return YES;
}

@end
