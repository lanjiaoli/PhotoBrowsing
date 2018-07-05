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
    UILabel *titleLabel;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic)  UIView *topView;


@end

@implementation PhotoImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubViews];
    [self.view addSubview:self.topView];
}

#pragma mark - Setup UI
- (void)setupSubViews{
    UINib *nib = [UINib nibWithNibName:@"PhotoImageCell" bundle:nil];
    array = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg"];
    [self.collection registerNib:nib forCellWithReuseIdentifier:@"cell"];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.pagingEnabled = YES;
    self.flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHight);
    self.flowLayout.minimumLineSpacing = 0;
    self.collection.contentOffset = CGPointMake(kScreenWidth*_index, 0);
}
- (void)setupTopViewWithSubView{
    CGFloat topSpacing = 20.0;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, topSpacing,kScreenWidth, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment  = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@"%ld / %lu",(long)self.index,(unsigned long)array.count];
    [self.topView addSubview:titleLabel];
    //左边返回按钮
    UIButton *leftBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBackBtn.frame = CGRectMake(0, topSpacing, 44, 44);
    leftBackBtn.tag = 1;
    [leftBackBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 7, 13)];
    leftImageView.image = [UIImage imageNamed:@"bigleftarrow"];
    [leftBackBtn addSubview:leftImageView];
    [self.topView addSubview:leftBackBtn];
    
    //更多按钮
    UIButton *moreBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBackBtn.frame = CGRectMake(kScreenWidth - 44, topSpacing, 44, 44);
    moreBackBtn.tag = 2;
    [moreBackBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(24, 10, 4, 18)];
    moreImageView.image = [UIImage imageNamed:@"more"];
    moreImageView.userInteractionEnabled = YES;
    [moreBackBtn addSubview:moreImageView];
    [self.topView addSubview:moreBackBtn];

}
#pragma mark - Collection Delegate
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
#pragma mark - View Loading
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];

}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark - layz loading
- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _topView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
        [self setupTopViewWithSubView];
    }
    return _topView;
}
#pragma mark - BUtton Medth
- (void)topBtnAction:(UIButton *)sender
{
    NSInteger tags = sender.tag;
    if (tags == 1) {
//        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        NSLog(@"更多");
    }
}


#pragma mark - SolleView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    self.index = x/kScreenWidth+1;
    titleLabel.text = [NSString stringWithFormat:@"%ld / %lu",(long)self.index,(unsigned long)array.count];

}
@end
