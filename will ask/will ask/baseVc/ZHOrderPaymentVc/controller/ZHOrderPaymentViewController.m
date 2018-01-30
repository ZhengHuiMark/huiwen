//
//  ZHOrderPaymentViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHOrderPaymentViewController.h"
#import "ZHOrderPayContentTableViewCell.h"
#import "ZHPaymentOptionsTableViewCell.h"
#import "ZHOrderPayModel.h"
#import "ZHTheThirdPartyModel.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AskViewController.h"
static NSString *payContentCellid = @"payContentCellid";
static NSString *paymentOptionsCellid = @"paymentOptionsCellid";

@interface ZHOrderPaymentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ZHOrderPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview: self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 ) {
        return 140;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        ZHOrderPayContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payContentCellid forIndexPath:indexPath];
        
        
        cell.orderTitle.text = _payModel.goodsName;
        cell.orderState.text = _payModel.descriptions;
        cell.priceNumber.text = _payModel.amount;
        cell.creatTime.text = _payModel.createTime;
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        ZHPaymentOptionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:paymentOptionsCellid forIndexPath:indexPath];
        cell.indexPath = indexPath;
        
        return cell;
    }

    
    return cell?cell:[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                            reuseIdentifier: @"Cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];

    if (indexPath.section == 0) {
        return;
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            // 微信
            case 0:{
//                [self WXPay];
                self.payModel.payMode = @"1";
                NSMutableDictionary *dic = [ZHNetworkTools parameters];
                [dic setObject:self.payModel.payMode forKey:@"payMode"];
                [dic setObject:self.payModel.orderNum forKey:@"orderNum"];
                NSString *url = [NSString stringWithFormat:@"%@/api/ut/orderPay/payment",kIP];
                
                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }
                        NSLog(@"%@",response);
                    _model = [ZHTheThirdPartyModel yy_modelWithJSON:response[@"data"]];
                    
                    [self WXPay];
                }];
            }
                break;
            // 支付宝
            case 1:{
                
                self.payModel.payMode = @"2";
                NSMutableDictionary *dic = [ZHNetworkTools parameters];
                [dic setObject:self.payModel.payMode forKey:@"payMode"];
                [dic setObject:self.payModel.orderNum forKey:@"orderNum"];
                NSString *url = [NSString stringWithFormat:@"%@/api/ut/orderPay/payment",kIP];
                
                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }
                    NSLog(@"%@",response);
                    NSString *data = response[@"data"];
                    
                    [[AlipaySDK defaultService]payOrder:data fromScheme:@"2017102009403828" callback:^(NSDictionary *resultDic) {
                        
                        NSLog(@"reslut = %@",resultDic);
                        NSString * memo = resultDic[@"memo"];
                        NSLog(@"===memo:%@", memo);
                        
                        switch ([resultDic[@"ResultStatus"]integerValue]) {
                            case 9000:{
                                [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                                [SVProgressHUD dismissWithDelay:1.0f];
                                for (UIViewController *Vc in self.navigationController.viewControllers) {
                                    if ([Vc isKindOfClass:[AskViewController class]]) {
                                        [self.navigationController popToViewController:Vc animated:YES];
                                    }
                                }

                            }
                                break;
                            case 6001:{
                                [SVProgressHUD showSuccessWithStatus:@"中途取消支付"];
                                [SVProgressHUD dismissWithDelay:1.0f];
                                for (UIViewController *Vc in self.navigationController.viewControllers) {
                                    if ([Vc isKindOfClass:[AskViewController class]]) {
                                        [self.navigationController popToViewController:Vc animated:YES];
                                    }
                                }
                                
                            }
                                break;
                            case 6002:{
                                [SVProgressHUD showSuccessWithStatus:@"网络连接出错"];
                                [SVProgressHUD dismissWithDelay:1.0f];
                                for (UIViewController *Vc in self.navigationController.viewControllers) {
                                    if ([Vc isKindOfClass:[AskViewController class]]) {
                                        [self.navigationController popToViewController:Vc animated:YES];
                                    }
                                }
                                
                            }
                                break;
                                
                            case 6004:
                            {
                                [SVProgressHUD showSuccessWithStatus:@"支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态"];
                                [SVProgressHUD dismissWithDelay:1.0f];
                                for (UIViewController *Vc in self.navigationController.viewControllers) {
                                    if ([Vc isKindOfClass:[AskViewController class]]) {
                                        [self.navigationController popToViewController:Vc animated:YES];
                                    }
                                }
                            }
                                break;
                                
                            case 4000:
                            {
                                [SVProgressHUD showSuccessWithStatus:@"订单支付失败"];
                                [SVProgressHUD dismissWithDelay:1.0f];
                                for (UIViewController *Vc in self.navigationController.viewControllers) {
                                    if ([Vc isKindOfClass:[AskViewController class]]) {
                                        [self.navigationController popToViewController:Vc animated:YES];
                                    }
                                }
                            }
                                break;
                                
                            case 8000:
                            {
                                [SVProgressHUD showSuccessWithStatus:@"正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态"];
                                [SVProgressHUD dismissWithDelay:1.0f];
                                for (UIViewController *Vc in self.navigationController.viewControllers) {
                                    if ([Vc isKindOfClass:[AskViewController class]]) {
                                        [self.navigationController popToViewController:Vc animated:YES];
                                    }
                                }
                            }
                                break;
                                
                     
                            default:
                                break;
                        }
                        if ([resultDic[@"ResultStatus"] isEqualToString:@"9000"]) {
                            
                            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                            [SVProgressHUD dismissWithDelay:1.0f];
                            for (UIViewController *Vc in self.navigationController.viewControllers) {
                                if ([Vc isKindOfClass:[AskViewController class]]) {
                                    [self.navigationController popToViewController:Vc animated:YES];
                                }
                            }
                        }else{
                            //            [SVProgressHUD showErrorWithStatus:memo];
                        }
                        
                    }];

                }];

            }
                break;
                
            case 2:{
                self.payModel.payMode = @"3";
                NSMutableDictionary *dic = [ZHNetworkTools parameters];
                [dic setObject:self.payModel.payMode forKey:@"payMode"];
                [dic setObject:self.payModel.orderNum forKey:@"orderNum"];
                NSString *url = [NSString stringWithFormat:@"%@/api/ut/orderPay/payment",kIP];
                
                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }
                    NSLog(@"%@",response);
                    NSString *data = response[@"data"];
                    
                    NSInteger code = [response[@"errcode"] integerValue];
                    
                    if (code == 60000) {
                        [SVProgressHUD showInfoWithStatus: response[@"message"]];
                        [SVProgressHUD dismissWithDelay:1];
                    }else{
                        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                        [SVProgressHUD dismissWithDelay:1.0f];
                        for (UIViewController *Vc in self.navigationController.viewControllers) {
                            if ([Vc isKindOfClass:[AskViewController class]]) {
                                [self.navigationController popToViewController:Vc animated:YES];
                            }
                        }

                    }
                    
                }];
                
            }
                break;
                
            case 3:{
                
                self.payModel.payMode = @"4";
                NSMutableDictionary *dic = [ZHNetworkTools parameters];
                [dic setObject:self.payModel.payMode forKey:@"payMode"];
                [dic setObject:self.payModel.orderNum forKey:@"orderNum"];
                NSString *url = [NSString stringWithFormat:@"%@/api/ut/orderPay/payment",kIP];
                
                [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }
                    NSLog(@"%@",response);
                    NSString *data = response[@"data"];
                    
                    NSInteger code = [response[@"errcode"] integerValue];
                    
                    if (code == 60000) {
                        [SVProgressHUD showInfoWithStatus: response[@"message"]];
                        [SVProgressHUD dismissWithDelay:1];
                    }else{
                        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                        [SVProgressHUD dismissWithDelay:1.0f];
                        for (UIViewController *Vc in self.navigationController.viewControllers) {
                            if ([Vc isKindOfClass:[AskViewController class]]) {
                                [self.navigationController popToViewController:Vc animated:YES];
                            }
                        }

                    }
                }];
                
            }
                break;
                
            default:
                break;
        }
    }
    
    
}



#pragma mark 微信支付方法
- (void)WXPay{
    
    //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
    req.openID = _model.appid;
    
    // 商家id，在注册的时候给的
    req.partnerId = _model.partnerid;
    
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = _model.prepayid;
    
    // 根据财付通文档填写的数据和签名
    //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
    req.package   = _model.packageValue;
    
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = _model.noncestr;
    
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = _model.timestamp;
    req.timeStamp = stamp.intValue;
    
    // 这个签名也是后台做的
    req.sign = _model.sign;
    
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
}


- (UITableView *)tableView {
    //
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed: 245/255.0 green: 245/255.0 blue: 245/255.0 alpha: 1.0f];
        _tableView.sectionHeaderHeight = 43;
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHOrderPayContentTableViewCell" bundle:nil] forCellReuseIdentifier:payContentCellid];
        
        [_tableView registerNib:[UINib nibWithNibName:@"ZHPaymentOptionsTableViewCell" bundle:nil] forCellReuseIdentifier:paymentOptionsCellid];
        //

    }
    
    return _tableView;
}



@end
