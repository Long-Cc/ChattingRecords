//
//  CLMessage.m
//  ChattingRecords
//
//  Created by LongCh on 2017/10/22.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import "CLMessage.h"

@implementation CLMessage

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)messageWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
