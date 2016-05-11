//
//  NSString+Tools.h
//  KillAllFree
//
//  Created by JackWong on 15/9/24.
//  Copyright (c) 2015年 JackWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)
NSString * URLEncodedString(NSString *str);
NSString * MD5Hash(NSString *aString);
@end
