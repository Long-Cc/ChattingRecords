//
//  CLMessageFrame.m
//  ChattingRecords
//
//  Created by LongCh on 2017/10/22.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import "CLMessageFrame.h"
#import <UIKit/UIKit.h>
#import "CLMessage.h"
#import "NSString+CLStringExt.h"

@implementation CLMessageFrame

- (void)setMessage:(CLMessage *)message {
    _message = message;
    //設置各個控件的Frame
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 5;
    //設置顯示時間的frame
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeH = 20;
    CGFloat timeW = screenW;
    if(!message.hideTime){
       _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    //設置頭像的Frame
    CGFloat iconH = 50;
    CGFloat iconW = 50;
    CGFloat iconX = message.type == CLMessageTypeOther ? margin : screenW - margin - iconW;
    CGFloat iconY =  CGRectGetMaxY(_timeFrame) + margin;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //設置正文的Frame
        //根據正文数字数目计算大小
    CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:textFont];
    CGFloat textW = textSize.width + 40;
    CGFloat textH = textSize.height + 30;
    CGFloat textY = iconY;
    CGFloat textX = message.type == CLMessageTypeOther ? (CGRectGetMaxX(_iconFrame) + margin) : (screenW - 2 * margin - iconW - textW);
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    //计算行高
        //获取头像的最大的Y值 和 正文的最大的Y值
    CGFloat MaxY = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHeight = 2 * margin + MaxY;
    
    
}

@end
