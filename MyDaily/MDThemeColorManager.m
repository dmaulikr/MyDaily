//
//  MDThemeColorManager.m
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDThemeColorManager.h"
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

- (NSString *)positiveColor {
    return [self.currentThemeData objectForKey:@"positive"];
}

- (NSString *)neutralColor {
    return [self.currentThemeData objectForKey:@"neutral"];
}

- (NSString *)negativeColor {
    return [self.currentThemeData objectForKey:@"negative"];
}

@end
