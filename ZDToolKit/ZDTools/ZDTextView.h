//
//  ZDTextView.h
//  ZDToolKitDemo
//
//  Created by 符现超 on 16/6/17.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 自适应高度变化
@interface ZDTextView : UITextView

/// 占位文字颜色
@property (nonatomic, strong) UIColor *placeholderTextColor;
/// 占位文字
@property (nonatomic, copy) NSString *placeholder;
/// 占位富文本
@property (nonatomic, copy) NSAttributedString *attributedPlaceholder;
/// 当前文字行数
@property (nonatomic, assign, readonly) NSUInteger numberOfLines;

@end