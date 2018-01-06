//
//  alertString.m
//  demo
//
//  Created by lzhl_iOS on 2017/10/16.
//  Copyright © 2017年 lianzhonghulian. All rights reserved.
//

#import "alertString.h"

@implementation alertString

static alertString* _instance = nil;


+ (void)showString:(NSString *)message Delay:(NSInteger)delay {
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [alertview show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertview dismissWithClickedButtonIndex:0 animated:YES];
    });
}

@end
