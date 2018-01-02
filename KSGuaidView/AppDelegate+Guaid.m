//
//  AppDelegate+Guaid.m
//  KSGuaidViewDemo
//
//  Created by Mr.kong on 2017/5/31.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import "AppDelegate+Guaid.h"
#import "KSGuaidViewController.h"
#import "KSGuardOptions.h"
#import <objc/runtime.h>

const char* kGuaidWindowKey = "kGuaidWindowKey";
NSString * const kLastVersionKey = @"kLastVersionKey";

@implementation AppDelegate (Guaid)

+ (void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString* lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kLastVersionKey];
        NSString* curtVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
        
        if ([curtVersion compare:lastVersion] == NSOrderedDescending) {
            Method originMethod = class_getInstanceMethod(self.class, @selector(application:didFinishLaunchingWithOptions:));
            Method customMethod = class_getInstanceMethod(self.class, @selector(guaid_application:didFinishLaunchingWithOptions:));
            
            method_exchangeImplementations(originMethod, customMethod);

        }
    });
}

- (BOOL)guaid_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL ret = [self guaid_application:application didFinishLaunchingWithOptions:launchOptions];
    
    self.guaidWindow = [[UIWindow alloc] init];
    self.guaidWindow.frame = [UIScreen mainScreen].bounds;
    self.guaidWindow.backgroundColor = [UIColor clearColor];
    self.guaidWindow.windowLevel = UIWindowLevelStatusBar;
    [self.guaidWindow makeKeyAndVisible];
    
    KSGuaidViewController* vc = [[KSGuaidViewController alloc] init];

    __weak typeof(self) weakSelf = self;
    
    vc.willDismissHandler = ^{
        
        NSString* curtVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] setObject:curtVersion forKey:kLastVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [weakSelf.window makeKeyAndVisible];
        
        weakSelf.guaidWindow.hidden = YES;
        
        weakSelf.guaidWindow = nil;

        [KSGuardOptions deinit];
        
    };
    
    self.guaidWindow.rootViewController = vc;
    
    return ret;
}

- (UIWindow *)guaidWindow{
    return  objc_getAssociatedObject(self, kGuaidWindowKey);
}
- (void)setGuaidWindow:(UIWindow *)guaidWindow{
    objc_setAssociatedObject(self, kGuaidWindowKey, guaidWindow, OBJC_ASSOCIATION_RETAIN);
}

@end
