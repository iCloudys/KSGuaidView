//
//  UIViewController+KSGuaidView.m
//  KSGuaidViewDemo
//
//  Created by Mr.kong on 2017/5/24.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import "UIViewController+KSGuaidView.h"
#import <objc/runtime.h>

#import "KSGuaidView.h"

@implementation UIViewController (KSGuaidView)

+ (void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod(self.class, @selector(viewDidLoad));
        Method customMethod = class_getInstanceMethod(self.class, @selector(ks_viewDidLoad));
        
        method_exchangeImplementations(originMethod, customMethod);
    });
}

- (void)ks_viewDidLoad{
    [self ks_viewDidLoad];

    [KSGuaidView show];
    
}

@end
