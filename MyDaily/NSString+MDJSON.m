//
//  NSString+MDJSON.m
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "NSString+MDJSON.h"

@implementation NSString(MDJSON)

- (NSString *)MD_stringWithNoComment {
    if (self.length == 0) {
        return self;
    }
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSString *resultString = nil;
    NSString *testString = nil;
    NSMutableString *finalString = [NSMutableString string];
}

@end
