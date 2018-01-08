//
//  KSGuaidViewManager.m
//  KSGuaidViewDemo
//
//  Created by Mac on 2018/1/3.
//  Copyright © 2018年 iCloudys. All rights reserved.
//

#import "KSGuaidViewManager.h"
#import <objc/runtime.h>
#import "KSGuaidViewController.h"

static NSString* const CFBundleVersion =
@"CFBundleVersion";
static NSString* const SETIMAGEASSERTSTRING =
@"Please set images for KSGuaidManager";
static NSString* const SETDISMISSBUTTONIMAGEASSERTSTRING =
@"You should set dismissButtonImage when shouldDismissWhenDragging is NO";
static NSString* const SETDISMISSBUTTONCENTERASSERTSTRING =
@"[DEBUG] Waring: Suggested setting KSGuaidManager.dismissButtonCenter values.";

@implementation KSGuaidViewManager

static KSGuaidViewManager* _manager = nil;
static dispatch_once_t _onceToken;

+ (instancetype)manager{
    dispatch_once(&_onceToken, ^{
        _manager = [[super allocWithZone:NULL] init];
    });
    return _manager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{return _manager;}
- (id)copyWithZone:(NSZone *)zone{return _manager;}

- (void)begin{
    
    NSAssert(self.images && self.images.count != 0, SETIMAGEASSERTSTRING);
    
    NSAssert(self.shouldDismissWhenDragging || self.dismissButtonImage , SETDISMISSBUTTONIMAGEASSERTSTRING);
    
    if (self.shouldDismissWhenDragging == NO && CGPointEqualToPoint(CGPointZero, self.dismissButtonCenter)) {
        KSLog(SETDISMISSBUTTONCENTERASSERTSTRING);
    }
    
    if ([current_version() compare:prev_version()] == NSOrderedDescending) {
    
        _window = [[UIWindow alloc] init];
        
        _window.frame = [UIScreen mainScreen].bounds;
        
        _window.backgroundColor = [UIColor clearColor];
        
        _window.windowLevel = UIWindowLevelStatusBar;
        
        [_window makeKeyAndVisible];
        
        
        KSGuaidViewController* vc = [[KSGuaidViewController alloc] init];
        
        __weak typeof(self) weakSelf = self;
        
        vc.willDismissHandler = ^{
            
            save_current_version();

            [weakSelf end];
        };
        
        _window.rootViewController = vc;
        
    }else{

        [self end];

    }

}

- (void)end{
    
    _window.hidden = YES;
    _window = nil;
    _images = nil;
    _manager = nil;
    _onceToken = 0l;
}

- (void)dealloc{
    KSLog(@"[DEBUG] delloc:%@",self);
}

NS_INLINE
NSString* current_version(){
    return [NSString stringWithFormat:@"%@",[NSBundle mainBundle].infoDictionary[CFBundleVersion]];
}

NS_INLINE
NSString* prev_version(){
    return [NSString stringWithContentsOfFile:version_path() encoding:NSUTF8StringEncoding error:nil];
}

NS_INLINE
void save_current_version(){
    [current_version() writeToFile:version_path() atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

NS_INLINE
NSString* version_path(){
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Version.data"];;
}

@end
