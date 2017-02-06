//
//  NSString+MDJSON.h
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(MDJSON)

- (NSString *)MD_stringWithNoComment;
- (NSString *)MD_stringWithNoEscapeCharacter;

@end
