//
//  KSGuaidViewManager.h
//  KSGuaidViewDemo
//
//  Created by Mac on 2018/1/3.
//  Copyright © 2018年 iCloudys. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <UIKit/UIWindow.h>

#define KSGuaidManager [KSGuaidViewManager manager]

@interface KSGuaidViewManager : NSObject

@property (nonatomic, strong, readonly) UIWindow* window;

@property (nonatomic, strong ) NSArray<UIImage*>* images;

@property (nonatomic, assign) BOOL shouldDismissWhenDragging;

@property (nonatomic, strong) UIImage* dismissButtonImage;

@property (nonatomic, assign) CGPoint dismissButtonCenter;

@property (nonatomic, strong) UIColor* pageIndicatorTintColor;

@property (nonatomic, strong) UIColor* currentPageIndicatorTintColor;

+ (instancetype)manager;

- (void)begin;

@end
