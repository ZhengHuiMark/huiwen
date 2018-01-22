//
//  UIAlertController+LPC_Extend.m
//  alertView
//
//  Created by lzhl_iOS on 2017/3/24.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import "UIAlertController+LPC_Extend.h"

@implementation UIAlertController (LPC_Extend)

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle andActionTitle:(NSString *)actionTitle style:(UIAlertActionStyle)style handler:(void(^)(UIAlertAction *action))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    
    if (actionTitle != nil && ![actionTitle  isEqual: @""]) {
        
        UIAlertAction *Action = [UIAlertAction actionWithTitle:actionTitle style:style handler:handler];
        
        [alert addAction:Action];
    }
    return alert;
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message andActionTitle:(NSString *)actionTitle handler:(void(^)(UIAlertAction *action))handler {
    
    return [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert andActionTitle:actionTitle style:UIAlertActionStyleDefault handler:handler];
}

+ (instancetype)alertSheetControllerWithTitle:(NSString *)title message:(NSString *)message andActionTitle:(NSString *)actionTitle handler:(void(^)(UIAlertAction *action))handler {
    
    return [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet andActionTitle:actionTitle style:UIAlertActionStyleDefault handler:handler];
}


@end
