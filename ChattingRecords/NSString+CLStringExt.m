//
//  NSString+CLStringExt.m
//  ChattingRecords
//
//  Created by LongCh on 2017/10/23.
//  Copyright © 2017年 LongCh. All rights reserved.
//

#import "NSString+CLStringExt.h"

@implementation NSString (CLStringExt)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font {
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font {
    return [self sizeWithText:text maxSize:maxSize font:font];
}

@end
