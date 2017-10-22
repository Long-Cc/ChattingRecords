//
//  CLMessageFrame.h
//  ChattingRecords
//
//  Created by LongCh on 2017/10/22.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CLMessage;

@interface CLMessageFrame : NSObject

@property (nonatomic, strong) CLMessage *message;

@property (nonatomic, assign, readonly)  CGRect *timeFrame;
@property (nonatomic, assign, readonly)  CGRect *iconFrame;
@property (nonatomic, assign, readonly)  CGRect *textFrame;
@property (nonatomic, assign, readonly)  CGFloat rowHeight;

@end
