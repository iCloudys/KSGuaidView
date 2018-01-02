//
//  KSGuardOptions.m
//  KSGuaidViewDemo
//
//  Created by Mac on 2017/12/29.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import "KSGuardOptions.h"

@implementation KSGuardOptions

static KSGuardOptions* _options = nil;
static dispatch_once_t _onceToken;

+ (instancetype)global{
    dispatch_once(&_onceToken, ^{
        _options = [[super allocWithZone:NULL] init];
    });
    return _options;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [KSGuardOptions global];
}

- (id)copyWithZone:(NSZone *)zone{
    return [KSGuardOptions global];
}

+ (void)deinit{
    _onceToken = 0l;
    _options.images = nil;
    _options = nil;
}

@end
