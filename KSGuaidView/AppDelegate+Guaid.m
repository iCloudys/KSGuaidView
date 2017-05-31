//
//  AppDelegate+Guaid.m
//  KSGuaidViewDemo
//
//  Created by Mr.kong on 2017/5/31.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import "AppDelegate+Guaid.h"
#import "KSGuaidViewController.h"

#import <objc/runtime.h>

const char* kGuaidWindowKey = "kGuaidWindowKey";

@implementation AppDelegate (Guaid)

+ (void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method originMethod = class_getInstanceMethod(self.class, @selector(application:didFinishLaunchingWithOptions:));
        Method customMethod = class_getInstanceMethod(self.class, @selector(guaid_application:didFinishLaunchingWithOptions:));

        method_exchangeImplementations(originMethod, customMethod);
    });
}

- (BOOL)guaid_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    printf("%s\n",__func__);
    
    self.guaidWindow = [[UIWindow alloc] init];
    self.guaidWindow.frame = self.guaidWindow.screen.bounds;
    self.guaidWindow.backgroundColor = [UIColor clearColor];
    self.guaidWindow.windowLevel = UIWindowLevelStatusBar + 1;
    [self.guaidWindow makeKeyAndVisible];
    
    KSGuaidViewController* vc = [[KSGuaidViewController alloc] init];

    __weak typeof(self) weakSelf = self;
    
    vc.shouldHidden = ^{
        
        [weakSelf.guaidWindow resignKeyWindow];
        
        weakSelf.guaidWindow.hidden = YES;
        weakSelf.guaidWindow = nil;
    };
    
    self.guaidWindow.rootViewController = vc;
    
    return [self guaid_application:application didFinishLaunchingWithOptions:launchOptions];
}

- (UIWindow *)guaidWindow{
    return  objc_getAssociatedObject(self, kGuaidWindowKey);
}
- (void)setGuaidWindow:(UIWindow *)guaidWindow{
    objc_setAssociatedObject(self, kGuaidWindowKey, guaidWindow, OBJC_ASSOCIATION_RETAIN);
}

@end
