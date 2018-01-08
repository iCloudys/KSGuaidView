//
//  KSGuaidViewManager.h
//  KSGuaidViewDemo
//
//  Created by Mac on 2018/1/3.
//  Copyright © 2018年 iCloudys. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <UIKit/UIWindow.h>

#ifndef KSGuaidManager
#define KSGuaidManager [KSGuaidViewManager manager]
#endif

#if DEBUG
#define KSLog(...) NSLog(__VA_ARGS__)
#else
#define KSLog(...)
#endif

@interface KSGuaidViewManager : NSObject

@property (nonatomic, strong, readonly) UIWindow* window;

@property (nonatomic, strong ) NSArray<UIImage*>* images;

/**
 Default is NO.
 */
@property (nonatomic, assign) BOOL shouldDismissWhenDragging;

@property (nonatomic, strong) UIImage* dismissButtonImage;

@property (nonatomic, assign) CGPoint dismissButtonCenter;

@property (nonatomic, strong) UIColor* pageIndicatorTintColor;

@property (nonatomic, strong) UIColor* currentPageIndicatorTintColor;

/**
 Default UIInterfaceOrientationMaskPortrait
 */
@property (nonatomic, assign) UIInterfaceOrientationMask supportedInterfaceOrientation;

+ (instancetype)manager;

- (void)begin;

@end
