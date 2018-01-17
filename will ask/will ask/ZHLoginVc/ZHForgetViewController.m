//
//  ZHForgetViewController.m
//  will ask
//
//  Created by 郑晖 on 2018/1/17.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHForgetViewController.h"
#import "ZHTabBarViewController.h"
#import "ZHNavigationVC.h"
#import "MLTextField.h"
#import "ZHMD5.h"

@interface ZHForgetViewController ()

@property(nonatomic,copy)MLTextField *PhoneNumberL;

//@property(nonatomic,copy)UIView *LineView;

@property(nonatomic,copy)MLTextField *validationTf;

@property(nonatomic,copy)UIButton *validationBtn;

//@property(nonatomic,copy)UIView *LineView1;

@property(nonatomic,copy)MLTextField *PasswordT;

//@property(nonatomic,copy)UIView *LineView2;

@property(nonatomic,copy)UIButton *RegisteredBtn;

@property(nonatomic,copy)NSMutableAttributedString *MString;

@property(nonatomic,copy)UILabel *AgreementL;



@end

@implementation ZHForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

/*
 
 NSMutableString *stringA = [NSMutableString string];
     //按字典key升序排序
     NSArray *sortKeys = [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
     //拼接格式 “key0=value0&key1=value1&key2=value2”
     for (NSString *key in sortKeys) {
         [stringA appendString:[NSString stringWithFormat:@"%@=%@&", key, dic[key]]];
     }
     //拼接商户签名,,,,kShopSign 要和微信平台上填写的密钥一样，（密钥就是签名）
     [stringA appendString:[NSString stringWithFormat:@"key=%@", kShopSign]];
     //MD5加密
     NSString *stringB = [PaymentAlgorithmObject MD5:[stringA copy]];
     //返回大写字母
     return stringB.uppercaseString;
 
 */
//返回16位大小写字母和数字
+(NSString *)return16LetterAndNumber{
    //定义一个包含数字，大小写字母的字符串
    NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //定义一个结果
    NSString * result = [[NSMutableString alloc]initWithCapacity:16];
    for (int i = 0; i < 16; i++)
    {
        //获取随机数
        NSInteger index = arc4random() % (strAll.length-1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}



- (void)ClickRegistered{
    
    
    
    NSMutableDictionary *dict = [ZHNetworkTools parameters];
    [dict setObject: _validationTf.ml_textfiled.text
             forKey: @"authcode"];
    [dict setObject: _PhoneNumberL.ml_textfiled.text
             forKey: @"mobile"];
    [dict setObject: _PasswordT.ml_textfiled.text
             forKey: @"password"];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/user/resetPassword",kIP];
    
    
    [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dict andCallBlock:^(id response, NSError *error) {
        // 2. 判断错误
        if (error) {
            NSLog(@"网络请求异常: %@", error);
            
            return;
        }
        NSLog(@"%@",response);
        [UserManager sharedManager].userModel = [UserModel yy_modelWithJSON:response[@"data"]];
        [[UserManager sharedManager]saveUserModel];
        
    }];
    
    
    
}


// 获取验证码
- (void)clickBtn{
    
    ZHNetworkTools *net = [[ZHNetworkTools alloc]init];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] *1000;
    net.timestamp = interval;
    
    net.nonce = [ZHForgetViewController return16LetterAndNumber];
    NSLog(@"nonce = %@",net.nonce);
    
    NSString *inStr = [NSString stringWithFormat: @"%ld", (long)net.timestamp];
    NSLog(@"时间戳 = %@",inStr);
    
    
    NSMutableString *contentString  =[NSMutableString string];
    
    NSDictionary *dict = @{
                           @"nonce":net.nonce,
                           @"timestamp":inStr,
                           //                           @"client_secret":@"0d908XAIzx6OjpSJg0Yo"
                           };
    
    NSArray *keys = [dict allKeys];
    
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![[dict objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[dict objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    
    
    NSString *client_secret = @"0d908XAIzx6OjpSJg0Yo";
    
    [contentString appendFormat:@"client_secret=%@",client_secret];
    NSLog(@"contentString = %@",contentString);
    
    
    net.signature = [ZHMD5 MD5ForLower32Bate:contentString];
    
    
    NSDictionary *dic = @{
                          @"mobile":_PhoneNumberL.ml_textfiled.text,
                          @"type":@"3",
                          @"timestamp":inStr,
                          @"nonce":net.nonce,
                          @"signature":net.signature
                          };
    NSString *url = @"http://192.168.0.58:7000/api/sms/sendAuthcode";
    
    [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
        // 2. 判断错误
        if (error) {
            NSLog(@"网络请求异常: %@", error);
            
            return;
        }
        
        
        
    }];
    
    
}


- (void)configUI{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 62, 20)] ;
    titleLabel.text  = @"忘记密码";
    //    titleLabel.backgroundColor  = [UIColor blueColor]   ;
    
    titleLabel.textColor = [UIColor blackColor] ;
    
    titleLabel.font= [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    CGFloat PhoneNumWidth = [UIScreen mainScreen].bounds.size.width - 80;
    CGFloat PhoneNumHeight = 40;
    CGFloat PhoneNumX = CGRectGetMinX(self.view.frame) + 40;
    CGFloat PhoneNumY = CGRectGetMinY(self.view.frame) + 141;
    
    _PhoneNumberL = [MLTextField textFieldWithFrame:CGRectMake(PhoneNumX, PhoneNumY, PhoneNumWidth, PhoneNumHeight) inView:self.view];
    _PhoneNumberL.ml_textfiled.placeholder = @"请输入手机号";
    _PhoneNumberL.ml_textfiled.textColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    _PhoneNumberL.ml_textfiled.font = [UIFont systemFontOfSize:15];
    [_PhoneNumberL.ml_textfiled setBorderStyle:UITextBorderStyleNone];
    
    
    
    
    // 验证码
    CGFloat validationWidth = [UIScreen mainScreen].bounds.size.width - 80;
    CGFloat validationHeight = 40;
    CGFloat validationX = CGRectGetMinX(self.view.frame) + 41;
    CGFloat validationY = CGRectGetMaxY(_PhoneNumberL.frame);
    
    _validationTf = [MLTextField textFieldWithFrame:CGRectMake(validationX, validationY + 30, validationWidth, validationHeight) inView:self.view];
    _validationTf.ml_textfiled.placeholder = @"请输入短信验证码";
    _validationTf.ml_textfiled.textColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    _validationTf.ml_textfiled.font = [UIFont systemFontOfSize:15];
    [_validationTf.ml_textfiled setBorderStyle:UITextBorderStyleNone];
    
    
    //    [self.view addSubview:_validationTf];
    
    // 获取验证码
    CGFloat AccordingBtnWidth = 80;
    CGFloat AccordingBtnHeight = 15;
    CGFloat AccordingX = CGRectGetMaxX(_validationTf.frame) - AccordingBtnWidth;
    CGFloat AccordingY = CGRectGetMinY(_validationTf.frame) + 15;
    
    _validationBtn = [[UIButton alloc]init];
    _validationBtn.frame = CGRectMake(AccordingX, AccordingY, AccordingBtnWidth, AccordingBtnHeight);
    //    [_validationBtn setBackgroundImage:[UIImage imageNamed:@"look"] forState:UIControlStateNormal];
    [_validationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_validationBtn setTitleColor:[UIColor colorWithRed:242/255.0  green:90/255.0 blue:41/255.0 alpha:1] forState:UIControlStateNormal];
    _validationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_validationBtn addTarget:self action:@selector(clickBtn)  forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_validationBtn];
    
    
    
    
    CGFloat PwdWidth = [UIScreen mainScreen].bounds.size.width - 80;
    CGFloat PwdHeight = 40;
    CGFloat PwdX = CGRectGetMinX(self.view.frame) + 41;
    CGFloat PwdY = CGRectGetMaxY(_validationTf.frame) + 30;
    
    _PasswordT = [MLTextField textFieldWithFrame:CGRectMake(PwdX, PwdY, PwdWidth, PwdHeight) inView:self.view];
    _PasswordT.ml_textfiled.placeholder = @"请输入新密码";
    _PasswordT.ml_textfiled.textColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    _PasswordT.ml_textfiled.font = [UIFont systemFontOfSize:15];
    [_PasswordT.ml_textfiled setBorderStyle:UITextBorderStyleNone];
    
    
    
    
    CGFloat LoginBtnWidth = 300;
    CGFloat LoginBtnHeight = 45;
    CGFloat LoginBtnX = (self.view.frame.size.width - LoginBtnWidth) / 2;
    CGFloat LoginBtnY = CGRectGetMaxY(_PasswordT.frame);
    
    _RegisteredBtn = [[UIButton alloc]initWithFrame:CGRectMake(LoginBtnX, LoginBtnY + 47, LoginBtnWidth, LoginBtnHeight)];
    _RegisteredBtn.layer.cornerRadius = 22.5;
    [_RegisteredBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_RegisteredBtn setBackgroundColor:[UIColor colorWithRed:242/255.0 green:90/255.0 blue:41/255.0 alpha:1]];
    [_RegisteredBtn addTarget:self action:@selector(ClickRegistered) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_RegisteredBtn];
    
    
    
//    CGFloat MStringWidth = 296;
//    CGFloat MStringHeight = 13;
//    CGFloat MStringX = CGRectGetMinX(self.view.frame) + 55;
//    CGFloat MStringY = CGRectGetMaxY(_RegisteredBtn.frame) + 11;
//    
//    _AgreementL = [[UILabel alloc]initWithFrame:CGRectMake(MStringX, MStringY, MStringWidth, MStringHeight)];
//    
//    _MString = [[NSMutableAttributedString alloc] initWithString:@"点击注册，表示您本人同意 会问用户协议"];
//    
//    [_MString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:242.0f / 255.0f green:90.0f / 255.0f blue:41.0f / 255.0f alpha:1.0f] range:NSMakeRange(13, 6)];
//    
//    _AgreementL.attributedText = _MString;
//    _AgreementL.font = [UIFont systemFontOfSize:12];
//    
//    [self.view addSubview:_AgreementL];
//    
    
}


@end
