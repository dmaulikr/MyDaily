//
//  MDThemeColorManager.m
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDThemeColorManager.h"
#import "NSString+MDJSON.h"
#import "UIColor+MDHexColor.h"
#import <ChameleonFramework/Chameleon.h>


#define kMDDefaultThemeFileName @"MDDefaultTheme"
#define kMDTheme_EmotionColor @"kEmotionColor"
#define kMDTheme_NaviColor @"kNavigationBarColor"


@interface MDThemeColorManager ()

@property (nonatomic,strong) NSDictionary *currentThemeData;

@end

@implementation MDThemeColorManager

+ (instancetype)sharedInstance {
    static MDThemeColorManager *manager = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        manager = [[MDThemeColorManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadDefaultTheme];
    }
    return self;
}

- (void)loadDefaultTheme {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:kMDDefaultThemeFileName ofType:@"json"];
    NSString *rawString = [NSString stringWithContentsOfFile:filePath
                                                    encoding:NSUTF8StringEncoding
                                                       error:NULL];
    if (!rawString) {
        return;
    }
    rawString = [rawString MD_stringWithNoEscapeCharacter];
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[rawString dataUsingEncoding:NSUTF8StringEncoding]
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
    if (jsonDict) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addEntriesFromDictionary:jsonDict[kMDTheme_EmotionColor]];
        [dict setObject:jsonDict[kMDTheme_NaviColor] forKey:kMDTheme_NaviColor];
        self.currentThemeData = dict;
    }
}

- (UIColor *)positiveColor {
//    return [self.currentThemeData objectForKey:@"positive"];
    return [UIColor MD_ColorWithHexString:@"#f7cac9"];
}

- (UIColor *)neutralColor {
//    return [self.currentThemeData objectForKey:@"neutral"];
    return [UIColor MD_ColorWithHexString:@"#e1e1e1"];
}

- (UIColor *)negativeColor {
//    return [self.currentThemeData objectForKey:@"negative"];
    return [UIColor MD_ColorWithHexString:@"#92a8d1"];
}

- (UIColor *)fontColor {
    return [UIColor whiteColor];
}

- (UIColor *)colorForEmotion:(MDEmotionType)emotionType {
    switch (emotionType) {
        case MDEmotionTypePositive:
            return [self positiveColor];
            break;
        case MDEmotionTypeNeutral:
            return [self neutralColor];
            break;
        case MDEmotionTypeNegative:
            return [self negativeColor];
            break;
    }
}

- (UIColor *)fontColorForEmotion:(MDEmotionType)emotionType {
    return [UIColor colorWithContrastingBlackOrWhiteColorOn:[self colorForEmotion:emotionType] isFlat:YES];
}

@end
