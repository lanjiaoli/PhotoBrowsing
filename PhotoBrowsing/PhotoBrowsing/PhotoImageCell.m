//
//  PhotoImageCell.m
//  PhotoBrowsing
//
//  Created by L on 2017/8/26.
//  Copyright © 2017年 L. All rights reserved.
//

#import "PhotoImageCell.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height
#define kRECT(x,y,w,h) CGRectMake(x, y, w, h)
@interface PhotoImageCell()<UIScrollViewDelegate>
{
    UIImageView *imageView;
}
@end
@implementation PhotoImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.backGroundView];
    [self setLayoutWithImage];
    //双击手势
    UITapGestureRecognizer *doubleGestureRecgnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleGestureRecgnizer:)];
    doubleGestureRecgnizer.numberOfTapsRequired = 2;
    [_backGroundView addGestureRecognizer:doubleGestureRecgnizer];
}
#pragma mark - Set ImageView Size
- (void)setLayoutWithImage{
    if (imageView.image == nil) {
        return;
    }
    CGFloat imageWidth = imageView.image.size.width;
    CGFloat imageHeight = imageView.image.size.height;
    
    CGFloat scale = kScreenWidth/imageWidth;
    
    CGFloat sizeWidth = imageWidth*scale;
    
    CGFloat sizeHight = imageHeight*scale;
    CGRect imageFrame = kRECT(0, 0, sizeWidth, sizeHight);
    if (sizeHight < kScreenHight) {
        imageFrame.origin.y = floorf((kScreenHight - sizeHight)/2);
    }
    self.backGroundView.contentSize = CGSizeMake(0, imageFrame.size.height);
    imageView.frame = imageFrame;
}
#pragma mark - layz Loading
- (UIScrollView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIScrollView alloc]initWithFrame:kRECT(0, 0, kScreenWidth, kScreenHight)];
        _backGroundView.maximumZoomScale = 3.0;
        _backGroundView.minimumZoomScale = 1.0;
        _backGroundView.delegate = self;
        _backGroundView.showsVerticalScrollIndicator = NO;
        _backGroundView.backgroundColor = [UIColor blackColor];
        imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"3.jpg"];
        imageView.center = _backGroundView.center;
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_backGroundView addSubview:imageView];
        
    }
    return _backGroundView;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}
#pragma mark - TapGestureRecohnizer

- (void)doubleGestureRecgnizer:(UITapGestureRecognizer *)sender
{
    if (self.backGroundView.zoomScale == self.backGroundView.maximumZoomScale) {
        [self.backGroundView setZoomScale:self.backGroundView.minimumZoomScale animated:YES];
    }else{
        CGPoint ponit= [sender locationInView:sender.view];
        CGFloat touchX = ponit.x;
        CGFloat touchY = ponit.y;
        touchY *=1/self.backGroundView.zoomScale;
        touchX *=1/self.backGroundView.zoomScale;
        touchX += self.backGroundView.contentOffset.x;
        touchY += self.backGroundView.contentOffset.y;
        CGRect zoomRect = [self zoomRectForScale:self.backGroundView.maximumZoomScale withCenter:CGPointMake(touchX, touchY)];
        [self.backGroundView zoomToRect:zoomRect animated:YES];;

    }
}
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height =self.frame.size.height / scale;
    zoomRect.size.width  =self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height /2.0);
    return zoomRect;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    imageView.center = [self centerOfScrollViewContent:scrollView];

}

#pragma mark    -   private method - 手势处理,缩放图片

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

- (void)prepareForReuse{
    [self.backGroundView setZoomScale:1.0f animated:NO];
}
@end
