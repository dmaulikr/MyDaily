//
//  MDThemeColorManager.h
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MDThemeColorManager : NSObject

+ (instancetype)sharedInstance;

- (NSString *)positiveColor;
- (NSString *)neutralColor;
- (NSString *)negativeColor;


@end
