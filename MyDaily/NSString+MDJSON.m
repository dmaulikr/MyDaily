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
    
    while ([scanner isAtEnd] == NO) {
        if ([scanner scanUpToString:@"/*" intoString:&resultString]) {
            [finalString appendString:resultString];
        }
        if ([scanner scanUpToString:@"*/" intoString:&testString]) {
            [scanner scanString:@"*/" intoString:NULL];
        }
    }
    return finalString;
}

- (NSString *)MD_stringWithNoEscapeCharacter {
    if (self.length == 0) {
        return self;
    }
////    NSScanner *scanner = [NSScanner scannerWithString:self];
//    NSString *resultString = nil;
//    NSString *escapeChar = nil;
//    NSMutableString *finalString = [self mutableCopy];
//    for (int i = 0; i < finalString.length; i ++) {
//        escapeChar = [finalString substringWithRange:NSMakeRange(i, 1)];
//        if ([escapeChar isEqualToString:@"\\"]) {
//            [finalString deleteCharactersInRange:NSMakeRange(i, 1)];
//        }
//    }
////    while ([scanner isAtEnd] == NO) {
////        if ([scanner scanUpToString:@"\\" intoString:&resultString]) {
////            [finalString appendString:resultString];
////        }
////        scanner.scanLocation++;
////    }
//    return finalString;
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"\n\\"];
    return [self stringByTrimmingCharactersInSet:charSet];
}

@end
