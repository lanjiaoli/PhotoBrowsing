//
//  PhotoImageViewController.m
//  PhotoBrowsing
//
//  Created by L on 2017/8/26.
//  Copyright © 2017年 L. All rights reserved.
//

#import "PhotoImageViewController.h"
#import "PhotoImageCell.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height
@interface PhotoImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
{
    NSArray *array;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation PhotoImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"PhotoImageCell" bundle:nil];
    [self.collection registerNib:nib forCellWithReuseIdentifier:@"cell"];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.pagingEnabled = YES;
    self.flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHight);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.flowLayout.minimumLineSpacing = 0;
    self.collection.contentOffset = CGPointMake(kScreenWidth*_index, kScreenHight);
    array = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoImageCell *photoCell = (PhotoImageCell *)cell;
    [photoCell.backGroundView setZoomScale:1.0 animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
