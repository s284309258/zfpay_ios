//
//  RASManage.m
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/1.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RSAManage.h"
#import "RSA.h"

static NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCLRBwD8Lpk70Ys9pjcnOx53A6Fd/p0Lq644pfvIzUx3RucOztVrK1QBj707ARipC5cZ2TtyNQMK/Eo2REatG9RZCULu4kNT7AXDS1vWP9X9K1kFBoCpEvLVAXjmxEKmksdc1xdOVeTMgGu0GGtNDK4FVYjvfWTNi81N/F8XDIZ+QIDAQAB\n-----END PUBLIC KEY-----";

static NSString *privkey = @"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKjDC7x+0z788+Ubmw0WMW2I0bjOwwJFOZ9C4xcroHphX0WzWT1rrPqxRU6yq8LZ/dB5xo63ahs2zxR0/D8SV45xiT/xntqxVUlwBFxgeJDw2QFSY/JRAoAWIqNW+G0ekJ9ZkN+6scRAj+sTaYYIH2cw0ly9pIyMr9TS7IQzB6prAgMBAAECgYEAmGZi/9sMC5LE8b4HPD8xbbgjpB/bzP4UtjTh/LeiGUI7licLTMMjF9TkQNhq8fCIHC8MVy9dO6w4P0IR1SdMNtfx674b3H6WjSpCXT9B4GVqzv6xiAh1r0wDoE7mJtLiAI5EkPxZm+IEim6D89mVn8/aUjkqkQ7ZLwAu2uvOHKkCQQDSm2rJP3o31pCpEGN2vJMg3Cy2R5woGUejmnnVM6ot8+up0L4z5Q9AmRaEXt1TGyateSt44/yGNEIsRiPYy90VAkEAzSLAwzU68awJmMwDznK44QMdIDGkIweLNJcRD5SO/ne4giQmYnDQTfB4Q48QIiYKp0RwJJRc7PTcxbVF7vJJfwJAWRo16KT5gUw+8bgkTKTlnl5ocEoFsBVZ8Ma3StNL6ZssFjFhdzUu6caa9y/ndXSkPXppQQE74k+Tu4WFPwCpLQJBALfFFXkLe8W7QFGxGwvcvIFfv7zym7+B55RybSdPCBcxe4qjBfwUYpggAC1Nwb9F4y9b4Tbz7pec+RbpQUBBr9MCQEGl3q9ZX/Qh7YFt9bVVHew/WAzJLapCdcrV3mgQQQFHaTvdEGtwYh4t/VwGVFNRHqCN5yS4LlD9YS5sGOf1U3s=\n-----END PRIVATE KEY-----";

@implementation RSAManage
// return base64 encoded string
+ (NSString *)encryptString:(NSString *)orginStr {
    return [RSA encryptString:orginStr publicKey:pubkey];
}

+ (NSString *)decryptString:(NSString *)encryptStr {
    return [RSA decryptString:encryptStr privateKey:privkey];
}

+ (NSString *)encrypt2String:(NSString *)orginStr {
    return [RSA encryptString:orginStr publicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBSL+6u2OaFjG2ceNgt3Xnhfb/DJyzzjYx08dLPQAWA1cq75c4Xe5957xbQZwXa3m6PSkrcO9BkXOafgUoApc3cdzcR/wTeQhkZZpReM/WCi1WvGFIM4idQcO6P/aTGM4DpAW71zIu+wpu0gaR9GmbWTwqOskkyd5uFPyrrUUg2wIDAQAB\n-----END PUBLIC KEY-----"];
}

+ (NSString *)encrypt3String:(NSString *)orginStr {
    return [RSA encryptString:orginStr publicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDkNW5nbXHwHUHQfQ3O2/fpAs0TgYzn86hHQPzc/51/zl58y4DGxCoacxsPwcAaklEAb2kKJRUbqbvcaqpy+KnJN0qu3AihLTdY+GS71+W/7sc3ZOCcaFRLqlFAshQRxy11GgcEe3qItuSGdhNYp76Lrd1ivtCv3xL0SAjfLMf/DQIDAQAB\n-----END PUBLIC KEY-----"];
}
@end
