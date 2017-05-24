//
//  KSGuaidView.m
//  KSGuaidViewDemo
//
//  Created by Mr.kong on 2017/5/24.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import "KSGuaidView.h"
#import "KSGuaidViewCell.h"

@interface KSGuaidView ()<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, assign) UIWindowLevel originLevel;

@end

@implementation KSGuaidView


- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    self.imageNames = @[@"guid01",@"guid02",@"guid03",@"guid04"];
    
    self.backgroundColor = [UIColor clearColor];
    
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
    self.collectionView.backgroundColor = self.backgroundColor;
    [self.collectionView registerClass:[KSGuaidViewCell class] forCellWithReuseIdentifier:KSGuaidViewCellID];
    
    [self addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.numberOfPages = self.imageNames.count;
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    CGSize size = [self.pageControl sizeForNumberOfPages:self.imageNames.count];
    self.pageControl.frame = CGRectMake((CGRectGetWidth(self.frame) - size.width) / 2,
                                        CGRectGetHeight(self.frame) - size.height,
                                        size.width, size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageNames.count;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KSGuaidViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:KSGuaidViewCellID forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    long current = lroundf(scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame));
    self.pageControl.currentPage = current;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSString* lastImageName = self.imageNames.lastObject;
    if (![lastImageName isEqualToString:kLastNullImageName]) {
        return;
    }
    
    int current = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    if (current == self.imageNames.count - 1) {
        [self hide];
    }
}

/// MARK:- 展示
+ (void)show{
    KSGuaidView* guaidView = [[KSGuaidView alloc] init];
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    guaidView.originLevel = keyWindow.windowLevel;
    keyWindow.windowLevel = UIWindowLevelAlert;
    [keyWindow addSubview:guaidView];
}

- (void)hide{
    [UIApplication sharedApplication].keyWindow.windowLevel = self.originLevel;
    [self removeFromSuperview];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end

NSString * const kLastNullImageName = @"kLastNullImageName";
