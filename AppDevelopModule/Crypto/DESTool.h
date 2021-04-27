//
//  DESTool.h
//  testOC
//
//  Created by 王立 on 2021/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DESTool : NSObject

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key ivStr:(NSString *)ivStr;
 
+ (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key ivStr:(NSString *)ivStr;


@end

NS_ASSUME_NONNULL_END
