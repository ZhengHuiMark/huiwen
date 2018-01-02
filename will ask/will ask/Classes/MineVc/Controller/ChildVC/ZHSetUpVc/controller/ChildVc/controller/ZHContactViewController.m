//
//  ZHContactViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHContactViewController.h"
#import "ZHNetworkTools.h"
#import "SVProgressHUD.h"
#import "Macro.h"
#import "UserManager.h"
#import "UserModel.h"

@interface ZHContactViewController ()<UITextViewDelegate>{
    UITextView *_FeedbackContenTextV;
    UITextField *_NumberTextF;
    UILabel *_placeHolderLabel;
}

@end

@implementation ZHContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1];
    
    [self setupUI];
    [self.navigationItem setTitle:@"用户反馈"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(clickButton)];

}


- (void)clickButton{
    //http://123.206.94.48:8080/app/webappController/addfeedback?backcontent=反馈内容
    
    //    NSDictionary *dic = @{
    //                          @"backcontent":_FeedbackContenTextV.text,
    //                          @"contact":_NumberTextF.text
    //                          };
    if ([UserManager sharedManager].userModel) {
        if (!_FeedbackContenTextV.text.length) {
            
            [SVProgressHUD showInfoWithStatus:@"请输入您的反馈内容"];
        }else if (!_NumberTextF.text.length){
            [SVProgressHUD showInfoWithStatus:@"请输入您的联系方式"];
            
        }else{
            NSString *url = [NSString stringWithFormat:@"%@/app/webappController/addfeedback?backcontent=%@&contact=%@",kIP,_FeedbackContenTextV.text,_NumberTextF.text];
            
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[ZHNetworkTools sharedTools]requestWithType:GET andUrl:url andParams:nil andCallBlock:^(id response, NSError *error) {
                
                if (error) {
                    NSLog(@"%@",error);
                    return ;
                }
                
                NSInteger code = [response[@"code"] integerValue];
                if (code == 0) {
                    
                    [SVProgressHUD showInfoWithStatus: response[@"message"]];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
        
    }else{
        if (!_FeedbackContenTextV.text.length) {
            
            [SVProgressHUD showInfoWithStatus:@"请输入您的反馈内容"];
        }else if (!_NumberTextF.text.length){
            [SVProgressHUD showInfoWithStatus:@"请输入您的联系方式"];
            
        }else{
            [SVProgressHUD show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showInfoWithStatus:@"反馈成功"];
            });
            
        }
    }
}

- (void)setupUI{
    
    _FeedbackContenTextV = [[UITextView alloc]initWithFrame:CGRectMake(20,10 , self.view.bounds.size.width - 40, 150)];
    //    _FeedbackContenTextV.layer.borderWidth = 0.6f;
    
    _FeedbackContenTextV.delegate = self;
    [self.view addSubview:_FeedbackContenTextV];
    
    
    _NumberTextF = [[UITextField alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(_FeedbackContenTextV.frame)+16, self.view.bounds.size.width -40, 30)];
    _NumberTextF.backgroundColor = [UIColor whiteColor];
    _NumberTextF.font = [UIFont systemFontOfSize:13];
    //    _NumberTextF.layer.borderWidth = 0.6f;
    
    _NumberTextF.placeholder = @"可输入手机号，QQ，或者邮箱";
    
    
    [self.view addSubview:_NumberTextF];
    
    _placeHolderLabel = [[UILabel alloc]init];
    _placeHolderLabel.text = @"请输入您反馈的内容，我们收到后将及时与您联系";
    _placeHolderLabel.frame = CGRectMake(10, 5, self.view.bounds.size.width - 10, 20);
    _placeHolderLabel.textColor = [UIColor grayColor];
    _placeHolderLabel.font = [UIFont systemFontOfSize:13];
    
    [_FeedbackContenTextV addSubview: _placeHolderLabel];
    
}


- (void)textViewDidChange:(UITextView *)textView{
    
    if ([textView.text length] == 0) {
        
        [_placeHolderLabel setHidden:NO];
        
    }else{
        
        [_placeHolderLabel setHidden:YES];
        
    }
}



@end
