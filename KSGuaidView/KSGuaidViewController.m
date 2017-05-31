//
//  KSGuaidViewController.m
//  KSGuaidViewDemo
//
//  Created by Mr.kong on 2017/5/24.
//  Copyright © 2017年 Bilibili. All rights reserved.
//

#import "KSGuaidViewController.h"

#import "KSGuaidViewCell.h"

@interface KSGuaidViewController ()<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) UIButton* hiddenBtn;

@property (nonatomic, strong) NSDictionary* property;

@end

@implementation KSGuaidViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"KSGuaidProperty.plist" ofType:nil];
    
    self.property = [NSDictionary dictionaryWithContentsOfFile:path];
    
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.imageNames = self.property[kImageNamesArray];
    
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
    self.pageControl.numberOfPages = self.imageNames.count;
    [self.view addSubview:self.pageControl];
    
    NSString* hiddenBtnImageName = self.property[kHiddenBtnImageName];
    
    self.hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hiddenBtn.hidden = YES;
    [self.hiddenBtn setImage:[UIImage imageNamed:hiddenBtnImageName] forState:UIControlStateNormal];
    [self.hiddenBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.hiddenBtn sizeToFit];
    [self.view addSubview:self.hiddenBtn];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
    CGSize size = [self.pageControl sizeForNumberOfPages:self.imageNames.count];
    self.pageControl.frame = CGRectMake((CGRectGetWidth(self.view.frame) - size.width) / 2,
                                        CGRectGetHeight(self.view.frame) - size.height,
                                        size.width, size.height);
    
    NSString* centerStr = self.property[kHiddenBtnCenter];
    CGPoint point = CGPointFromString(centerStr);
    
    self.hiddenBtn.center = CGPointMake(CGRectGetWidth(self.view.frame) * point.x,
                                        CGRectGetHeight(self.view.frame) * point.y);
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
    long current = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);

    self.pageControl.currentPage = lroundf(current);
    
    NSString* lastImageName = self.imageNames.lastObject;

    self.hiddenBtn.hidden = [lastImageName isEqualToString:kLastNullImageName] || self.imageNames.count - 1 != current ;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
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

/// MARK:- 隐藏
- (void)hide{
    if (self.shouldHidden) {
        self.shouldHidden();
    }
}

- (void)dealloc{

}


@end

NSString * const kLastNullImageName = @"kLastNullImageName";

NSString * const kImageNamesArray = @"kImageNamesArray";

NSString * const kHiddenBtnImageName = @"kHiddenBtnImageName";

NSString * const kHiddenBtnCenter = @"kHiddenBtnCenter";

