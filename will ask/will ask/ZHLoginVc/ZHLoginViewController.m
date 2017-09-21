//
//  ZHLoginViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/9/5.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHLoginViewController.h"
#import "ZHRegisteredViewController.h"
#import "EncryptionAndDecryption.h"
#import "YYmodel.h"
#import "RSAEncryptor.h"

@interface ZHLoginViewController ()<UITextFieldDelegate>

//手机号输入框
@property(nonatomic,copy)UITextField *PhoneNumberL;
// 密码输入框
@property(nonatomic,copy)UITextField *PasswordNumberL;
// 底部线
@property(nonatomic,copy)UIView *LineView;
// 底部线2
@property(nonatomic,copy)UIView *LineView1;
// 登录按钮
@property(nonatomic,copy)UIButton *LoginBtn;
// 忘记密码按钮
@property(nonatomic,copy)UIButton *ForgetPwdBtn;
// QQ登录按钮
@property(nonatomic,copy)UIButton *QQLoginBtn;
// 微信登录按钮
@property(nonatomic,copy)UIButton *WeChatLoginBtn;
// 微博登录按钮
@property(nonatomic,copy)UIButton *WeiboLoginBtn;

@property(nonatomic,copy)UILabel *QQLabel;

@property(nonatomic,copy)UILabel *WeChatLabel;

@property(nonatomic,copy)UILabel *WeiboLabel;

// 显示密码按钮
@property(nonatomic,copy)UIButton *AccordingBtn;
// 一键删除按钮
@property(nonatomic,copy)UIButton *DeleteNumberBtn;


@end

@implementation ZHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    

    [self configUI];
    
}


- (void)clickBtnShow{
    if (_AccordingBtn.selected == NO) {
        _AccordingBtn.selected = YES;
        [_AccordingBtn setBackgroundImage:[UIImage imageNamed:@"eyelash"] forState:UIControlStateSelected];
        [_PasswordNumberL setSecureTextEntry:NO];
    }else{
        _AccordingBtn.selected = NO;
        [_AccordingBtn setBackgroundImage:[UIImage imageNamed:@"look"] forState:UIControlStateSelected];
        [_PasswordNumberL setSecureTextEntry:YES];

    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"点击1");
//    _LineView.backgroundColor = [UIColor orangeColor];
//    if (_PhoneNumberL.selected == YES) {
//        _LineView.backgroundColor = [UIColor orangeColor];
//    }else if (_PasswordNumberL.selected == YES) {
//        _PhoneNumberL.selected = NO;
//        
//        _LineView1.backgroundColor = [UIColor orangeColor];
//        _LineView.backgroundColor = [UIColor blackColor];
//
//    }
//    
    return YES;
}// return NO to disallow editing.



- (void)ceshi{
    


//原始数据
    NSString *str = @"ibuaiVcKdpRxkhJA_1491819233692";
    
    //使用.der和.p12中的公钥私钥加密解密
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    
     NSString *encryptStr = [RSAEncryptor encryptString:str publicKeyWithContentsOfFile:public_key_path];
    NSLog(@"加密前:%@", str);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"zhenghui"]);
   

//    NSString *str1 = [RSAEncryptor encryptString:str publicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCypBhs8fFzcaU1zTY4PXWImc2qOIIYbcNzbRMIOxAh7l37FlJEO+gIg/2lcMHOepPQVmWjYNBDZb7VgnOLJP939YUWeWkIO1hYhSX0sNasZ2Jma1D3m4CL9BhngPHD2qDu175O0ci2rL574y701Uzlh25mvbS084vBtxYBri6A8wIDAQAB"];
//    NSLog(@"%@",str1);
//    
//    NSLog(@"解密后:%@", [RSAEncryptor decryptString:str1 privateKey:@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALKkGGzx8XNxpTXNNjg9dYiZzao4ghhtw3NtEwg7ECHuXfsWUkQ76AiD/aVwwc56k9BWZaNg0ENlvtWCc4sk/3f1hRZ5aQg7WFiFJfSw1qxnYmZrUPebgIv0GGeA8cPaoO7Xvk7RyLasvnvjLvTVTOWHbma9tLTzi8G3FgGuLoDzAgMBAAECgYEAj0YQ2P/K2P4itN3bSIvyQhao3obnwFP4WBD5HLbSH4SgF4s1e8hYNsw1mISwy7t/5a4FYl15azSlM3Sm2shXozVZTnTakflKuFC49EZDFJ1Dxu0waF9ATIFY2jPKohmhcVZENCBk53q4u7p3S6sXIAkdCxpXwzcy6oUabtAk4tECQQDX4wBpal/sQH3Qv6Ni9DryxK6igBqUQmjepYOjka3vnviNw+fFZqbJHnEQp+x/YvUlpH8ZOunDM6Dze0eYT+QtAkEA09Vw57YS+2Lt3iIWbyccss9HT8Jt9udsyPTxV83qHymcyozazlke3NquH1HOyNyvmCC26W/cM5PcRCFxkk+NnwJBAK2M+o7ECjr1mW9QL/vj1OPHA5D1JOjc/ktGia3b9hU1GiF1RQRnQltaEpDOPgwmNGc/d0GEH9phzdkO2P5z8z0CQGmql5ZNwWw6bfMXR9+MQAmF0cmcb+PwjtgzLswgv/9pb3euCVtTI00BnEetNBwH0WNuNi99h/cGc6JcmF1mZ3sCQC/oJdJrqIrgWL742c7Kb9JRfMzlAliyolFDhFXlwfJMH6X3GuHOe33Pabhh7fU1Ow5uFqRZRrIiXJ812IsJYo0="]);
//    
//    
}




- (void)clickButton{
    ZHRegisteredViewController *registVc = [[ZHRegisteredViewController alloc]init];
    
    [self.navigationController pushViewController:registVc animated:YES];

}

- (void)configUI{
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    titleLabel.text  = @"会问登录";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor] ;
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];

    
    CGFloat PhoneNumWidth = 280;
    CGFloat PhoneNumHeight = 13.5;
    CGFloat PhoneNumX = CGRectGetMinX(self.view.frame) + 41;
    CGFloat PhoneNumY = CGRectGetMinY(self.view.frame) + 141;

    _PhoneNumberL = [[UITextField alloc]init];
    _PhoneNumberL.frame = CGRectMake(PhoneNumX , PhoneNumY, PhoneNumWidth, PhoneNumHeight);
    _PhoneNumberL.placeholder = @"手机号";
    _PhoneNumberL.textColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    _PhoneNumberL.font = [UIFont systemFontOfSize:15];
    
    _PhoneNumberL.delegate = self;
    [self.view addSubview:_PhoneNumberL];
    
    // 一键删除手机号按钮
    CGFloat DeleteBtnWidth = 15;
    CGFloat DeleteBtnHeight = 15;
    CGFloat DeleteX = CGRectGetMaxX(_PhoneNumberL.frame) + 10;
    CGFloat DeleteY = CGRectGetMinY(self.view.frame) + 141;
    
    _DeleteNumberBtn = [[UIButton alloc]init];
    _DeleteNumberBtn.frame = CGRectMake(DeleteX, DeleteY , DeleteBtnWidth, DeleteBtnHeight);
    [_DeleteNumberBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [self.view addSubview:_DeleteNumberBtn];
    
    
    
    // 线
    CGFloat LineWidth = 330;
    CGFloat LineHeight = .5;
    CGFloat LineX = (self.view.frame.size.width - LineWidth) / 2;
    CGFloat LineY = CGRectGetMaxY(_PhoneNumberL.frame);
    
    _LineView = [[UIView alloc]init];
    _LineView.frame = CGRectMake(LineX, LineY + 10, LineWidth, LineHeight);
    _LineView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview: _LineView];
    
    // 密码
    CGFloat pwdWidth = 280;
    CGFloat PwdHeight = 13.5;
    CGFloat PwdX = CGRectGetMinX(self.view.frame) + 41;
    CGFloat PwdY = CGRectGetMaxY(_LineView.frame);
    
    _PasswordNumberL = [[UITextField alloc]init];
    _PasswordNumberL.frame = CGRectMake(PwdX, PwdY + 30, pwdWidth, PwdHeight);
    _PasswordNumberL.placeholder = @"密码";
    _PasswordNumberL.textColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    _PasswordNumberL.font = [UIFont systemFontOfSize:15];

    
    _PasswordNumberL.delegate = self;
    [self.view addSubview:_PasswordNumberL];
    
    // 显示密码按钮
    CGFloat AccordingBtnWidth = 16;
    CGFloat AccordingBtnHeight = 10;
    CGFloat AccordingX = CGRectGetMaxX(_PasswordNumberL.frame) + 10;
    CGFloat AccordingY = CGRectGetMaxY(_LineView.frame) + 30;
    
    _AccordingBtn = [[UIButton alloc]init];
    _AccordingBtn.frame = CGRectMake(AccordingX, AccordingY, AccordingBtnWidth, AccordingBtnHeight);
    [_AccordingBtn setBackgroundImage:[UIImage imageNamed:@"look"] forState:UIControlStateNormal];
    [_AccordingBtn addTarget:self action:@selector(clickBtnShow) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_AccordingBtn];
                                       
    
    CGFloat Line1Width = 330;
    CGFloat Line1Height = .5;
    CGFloat Line1X = (self.view.frame.size.width - Line1Width) / 2;
    CGFloat Line1Y = CGRectGetMaxY(_PasswordNumberL.frame);
    
    _LineView1 = [[UIView alloc]init];
    _LineView1.frame = CGRectMake(Line1X, Line1Y + 10, Line1Width, Line1Height);
    _LineView1.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_LineView1];
    
    CGFloat LoginBtnWidth = 300;
    CGFloat LoginBtnHeight = 45;
    CGFloat LoginBtnX = (self.view.frame.size.width - LoginBtnWidth) / 2;
    CGFloat LoginBtnY = CGRectGetMaxY(_LineView1.frame);
    
    _LoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(LoginBtnX, LoginBtnY + 47, LoginBtnWidth, LoginBtnHeight)];
    _LoginBtn.layer.cornerRadius = 22.5;
    [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_LoginBtn setBackgroundColor:[UIColor colorWithRed:242/255.0 green:90/255.0 blue:41/255.0 alpha:1]];
  //
    [_LoginBtn addTarget:self action:@selector(ceshi) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_LoginBtn];
    
    CGFloat ForgetPwdBtnWidth = 55;
    CGFloat ForgetPwdBtnHeight = 13.5;
    CGFloat ForgetPwdBtnX = (self.view.frame.size.width - ForgetPwdBtnWidth) / 2;
    CGFloat ForgetPwdBtnY = CGRectGetMaxY(_LoginBtn.frame);
    
    _ForgetPwdBtn = [[UIButton alloc]initWithFrame:CGRectMake(ForgetPwdBtnX, ForgetPwdBtnY + 28, ForgetPwdBtnWidth, ForgetPwdBtnHeight)];
    [_ForgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_ForgetPwdBtn setTitleColor:[UIColor colorWithRed:242/255.0 green:90/255.0 blue:41/255.0 alpha:1] forState:UIControlStateNormal];
    _ForgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:_ForgetPwdBtn];
    
    
    // 第三方按钮布局
    CGFloat BtnWidth = 50;
    CGFloat BtnHeight = 50;
    CGFloat BtnCount = 3;
    
    CGFloat BtnTotalWidth = BtnWidth * BtnCount;
    CGFloat BtnTotalMargin = self.view.frame.size.width - BtnTotalWidth;
    CGFloat Margin = BtnTotalMargin / (BtnCount + 1);
    
    CGFloat x = Margin;
    CGFloat y = CGRectGetMaxY(_ForgetPwdBtn.frame) + 90.5;
    
    _QQLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _QQLoginBtn.frame = CGRectMake(x, y, BtnWidth, BtnHeight);
    [_QQLoginBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    
    [self.view addSubview:_QQLoginBtn];
    
    _WeChatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    x = CGRectGetMaxX(_QQLoginBtn.frame) + Margin;
    _WeChatLoginBtn.frame = CGRectMake(x, y, BtnWidth, BtnHeight);
    [_WeChatLoginBtn setBackgroundImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    
    [self.view addSubview:_WeChatLoginBtn];
    
    _WeiboLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    x = CGRectGetMaxX(_WeChatLoginBtn.frame) + Margin;
    
    _WeiboLoginBtn.frame = CGRectMake(x, y, BtnWidth, BtnHeight);
    [_WeiboLoginBtn setBackgroundImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
    
    [self.view addSubview:_WeiboLoginBtn];
    
    //文字布局
    CGFloat LabelHeight = 13;
    CGFloat LabelWidth = 30;
    CGFloat LabelCount = 3;
    
    CGFloat LabelTotalWidth = LabelWidth * LabelCount;
    CGFloat LabelTotalMargin = self.view.frame.size.width - LabelTotalWidth;
    CGFloat MarginL = LabelTotalMargin / (LabelCount + 1);
    CGFloat LabelX = MarginL;
    CGFloat LabelY = CGRectGetMaxY(_QQLoginBtn.frame) + 5;
    
    _QQLabel = [[UILabel alloc]initWithFrame:CGRectMake(LabelX, LabelY, LabelWidth , LabelHeight)];
    _QQLabel.text = @"QQ";
    _QQLabel.font = [UIFont systemFontOfSize:13];
    _QQLabel.textColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
    
    [self.view addSubview:_QQLabel];
    
    LabelX = CGRectGetMaxX(_QQLabel.frame) + MarginL;
    _WeChatLabel = [[UILabel alloc]initWithFrame:CGRectMake(LabelX, LabelY, 30, LabelHeight)];
    _WeChatLabel.text = @"微信";
    _WeChatLabel.font = [UIFont systemFontOfSize:13];
    _WeChatLabel.textColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
    
    [self.view addSubview:_WeChatLabel];
    
    LabelX = CGRectGetMaxX(_WeChatLabel.frame) + MarginL + 5;
    _WeiboLabel = [[UILabel alloc]initWithFrame:CGRectMake(LabelX, LabelY, 30, LabelHeight)];
    _WeiboLabel.text = @"微博";
    _WeiboLabel.font = [UIFont systemFontOfSize:13];
    _WeiboLabel.textColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
    
    [self.view addSubview:_WeiboLabel];


}





@end
