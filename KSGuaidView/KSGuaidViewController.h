//
//  KSGuaidViewController.h
//  KSGuaidViewDemo
//
//  Created by Mr.kong on 2017/5/24.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSGuaidViewController : UIViewController

@property (nonatomic, strong) NSArray<NSString*>* imageNames;

@property (nonatomic, copy) dispatch_block_t shouldHidden;

@end

UIKIT_EXTERN NSString * const kLastNullImageName;

UIKIT_EXTERN NSString * const kImageNamesArray;

UIKIT_EXTERN NSString * const kHiddenBtnImageName;

UIKIT_EXTERN NSString * const kHiddenBtnCenter;

