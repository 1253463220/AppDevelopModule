//
//  DESTool.m
//  testOC
//
//  Created by 王立 on 2021/1/15.
//


#import "DESTool.h"
#import <CommonCrypto/CommonCryptor.h>
 
@implementation DESTool
 
/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key ivStr:(NSString *)ivStr
{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    const void *iv = (const void*)[ivStr UTF8String];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [self encodeData:data];
    }
    return ciphertext;
}
 
//解密
+ (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key ivStr:(NSString *)ivStr
{
    NSData* cipherData = [self decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    const void *iv = (const void*)[ivStr UTF8String];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
 
+ (NSString *)encodeData:(NSData *)originData{
    
    NSString* encodeResult = [originData base64EncodedStringWithOptions:0];
    //    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}
+ (NSData *)decodeString:(NSString *)encodeResult{
    
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:encodeResult options:0];
    //    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    return decodeData;
}
 
@end
