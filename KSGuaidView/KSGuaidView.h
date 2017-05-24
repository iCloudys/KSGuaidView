//
//  KSGuaidView.h
//  KSGuaidViewDemo
//
//  Created by Mr.kong on 2017/5/24.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSGuaidView : UIView

@property (nonatomic, strong) NSArray<NSString*>* imageNames;

+ (void)show;

@end


UIKIT_EXTERN NSString * const kLastNullImageName;
