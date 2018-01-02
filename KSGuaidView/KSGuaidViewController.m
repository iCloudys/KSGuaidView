//
//  KSGuaidViewController.m
//  KSGuaidViewDemo
//
//  Created by Mr.kong on 2017/5/24.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import "KSGuaidViewController.h"
#import "KSGuardOptions.h"
#import "KSGuaidViewCell.h"

@interface KSGuaidViewController ()<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) UIButton* dismissButton;

@end

@implementation KSGuaidViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    [self.collectionView registerClass:[KSGuaidViewCell class] forCellWithReuseIdentifier:KSGuaidViewCellID];
    
    [self.view addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.numberOfPages = KSGuardGlobal.images.count;
    self.pageControl.pageIndicatorTintColor = KSGuardGlobal.pageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = KSGuardGlobal.currentPageIndicatorTintColor;
    [self.view addSubview:self.pageControl];
    
    if (KSGuardGlobal.shouldDismissWhenDragging == NO) {
        NSAssert(KSGuardGlobal.dismissButtonImage, @"[KSGuardOptions global].dismissButtonImage can not be nil when [KSGuardOptions global].shouldDismissWhenDragging is NO ");
        
        self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dismissButton.hidden = YES;
        [self.dismissButton setImage:KSGuardGlobal.dismissButtonImage forState:UIControlStateNormal];
        [self.dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.dismissButton sizeToFit];
        [self.view addSubview:self.dismissButton];
        
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
    
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    
    self.pageControl.frame = CGRectMake((CGRectGetWidth(self.view.frame) - size.width) / 2,
                                        CGRectGetHeight(self.view.frame) - size.height,
                                        size.width, size.height);
    
//    NSString* centerStr = self.property[kHiddenBtnCenter];
//    CGPoint point = CGPointFromString(centerStr);
    
    self.dismissButton.center = KSGuardGlobal.dismissButtonCenter;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (KSGuardGlobal.shouldDismissWhenDragging) {
        
        return KSGuardGlobal.images.count + 1;
        
    }
    
    return KSGuardGlobal.images.count;
    
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KSGuaidViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:KSGuaidViewCellID forIndexPath:indexPath];
    
    if (indexPath.row >= KSGuardGlobal.images.count) {
        
        cell.imageView.image = nil;
        
    }else{
       
        cell.imageView.image = KSGuardGlobal.images[indexPath.row];
        
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    long current = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);

    self.pageControl.currentPage = lroundf(current);

    if (KSGuardGlobal.shouldDismissWhenDragging == NO) {
        
        self.dismissButton.hidden = KSGuardGlobal.images.count != current + 1;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (KSGuardGlobal.shouldDismissWhenDragging == YES) {
        int current = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
        if (current == KSGuardGlobal.images.count) {
            [self dismiss];
        }
    }
}

/// MARK:- 隐藏
- (void)dismiss{
    if (self.willDismissHandler) {
        self.willDismissHandler();
    }
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}

- (void)dealloc{
#if DEBUG
    NSLog(@"[DEBUG] dealloc:%@",self);
#endif
}

@end


