//
//  LoginRegModel.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/6.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "LoginRegModel.h"

@implementation LoginRegModel

-(id)init{
    if (self = [super init]) {
        self.img_id = @"";
        self.img_io = @"";
    }
    return self;
}

-(UIImage*)ioImage{
    if(self.img_io == nil) {
        return nil;
    }
    NSData * decodeData = [[NSData alloc] initWithBase64EncodedString:self.img_io options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    if (decodeData) {
        UIImage *decodedImage = [UIImage imageWithData:decodeData];
        if (decodedImage) {
            return decodedImage;
        }
    }
    
    return nil;
}
@end
