//
//  EncryptionAndDecryption.h
//  NewGoldUnion
//
//  Created by lzhl_iOS on 2017/5/22.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionAndDecryption : NSObject

/** 解密 */
+ (NSString*)decryptUseDES:(NSString *)cipherText key:(NSString*)key;

/** 加密 */
+ (NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key;


@end
