//
//  KSGuardOptions.h
//  KSGuaidViewDemo
//
//  Created by Mac on 2017/12/29.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <UIKit/UIImage.h>

#define KSGuardGlobal [KSGuardOptions global]

@interface KSGuardOptions : NSObject

@property (nonatomic, strong ) NSArray<UIImage*>* images;

@property (nonatomic, assign) BOOL shouldDismissWhenDragging;

@property (nonatomic, strong) UIImage* dismissButtonImage;

@property (nonatomic, assign) CGPoint dismissButtonCenter;

@property (nonatomic, strong) UIColor* pageIndicatorTintColor;

@property (nonatomic, strong) UIColor* currentPageIndicatorTintColor;

+ (instancetype)global;

+ (void)deinit;

@end
