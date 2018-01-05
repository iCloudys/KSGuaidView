# KSGuaidView([中文版](/README_CN.md))
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
![Pod version](http://img.shields.io/cocoapods/v/KSGuaidView.svg?style=flat)
![Platform info](http://img.shields.io/cocoapods/p/KSGuaidView.svg?style=flat)
***
## Summary

KSGuaidView is the tool to display new features when APP is first installed or updated.
<br/>

![图一](https://github.com/iCloudys/KSGuaidView/blob/master/Gif/QQ20170531-143315.gif)
![图二](https://github.com/iCloudys/KSGuaidView/blob/master/Gif/QQ20170531-143634.gif)<br/><br/>


## Installation

    pod 'KSGuaidView'      

## Usage
Style 1:
```objective-c
    #import <KSGuaidViewManager.h>
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {                  
        KSGuaidManager.images = @[[UIImage imageNamed:@"guid01"],
                                    [UIImage imageNamed:@"guid02"],
                                    [UIImage imageNamed:@"guid03"],
                                    [UIImage imageNamed:@"guid04"]];
                                    
        CGSize size = [UIScreen mainScreen].bounds.size;
        KSGuaidManager.dismissButtonCenter = CGPointMake(size.width / 2, size.height - 80);
        
        KSGuaidManager.dismissButtonImage = [UIImage imageNamed:@"hidden"];
        
        [KSGuaidManager begin];
        
        return YES;
    }
```
Style 2:

```objective-c

    #import <KSGuaidViewManager.h>
 
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        KSGuaidManager.images = @[[UIImage imageNamed:@"guid01"],
                                    [UIImage imageNamed:@"guid02"],
                                    [UIImage imageNamed:@"guid03"],
                                    [UIImage imageNamed:@"guid04"]];
        
        KSGuaidManager.shouldDismissWhenDragging = YES;
        [KSGuaidManager begin];
        
        return YES;
    }   
```

***
## Attention
* You should set  up```KSGuaidManager.images ``` .<br/>
* Style 1 will ignore if you set up ```KSGuaidManager.shouldDismissWhenDragging = YES ``` .<br/>
* You should set up```KSGuaidManager.dismissButtonImage``` if you didn\`t set up ```KSGuaidManager.shouldDismissWhenDragging ``` or ``` KSGuaidManager.shouldDismissWhenDragging = NO``` .<br/>
* Finally you need to call``` [KSGuaidManager begin]```.


