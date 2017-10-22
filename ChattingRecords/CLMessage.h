//
//  CLMessage.h
//  ChattingRecords
//
//  Created by LongCh on 2017/10/22.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CLMessageTypeMe = 0,
    CLMessageTypeOther = 1
} CLMessageType;

@interface CLMessage : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) CLMessage *type;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;
@end
