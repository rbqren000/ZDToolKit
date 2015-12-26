//
//  NSString+ZDUtility.h
//  ZDUtility
//
//  Created by 符现超 on 15/12/26.
//  Copyright © 2015年 Fate.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZDUtility)

- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

- (NSString *)filterEmoji;
- (NSString *)reservedNumberOnly;
- (NSString *)reverse;
- (BOOL)isContainsString:(NSString *)string;
- (BOOL)isAllNumber;

- (NSDictionary *)dictionaryValue;
+ (NSString *)stringValueFromJson:(id)arrayOrDic;

- (NSString *)decodeHTMLCharacterEntities;
- (NSString *)encodeHTMLCharacterEntities;

@end