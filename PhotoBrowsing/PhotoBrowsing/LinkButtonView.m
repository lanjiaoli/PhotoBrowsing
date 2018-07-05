//
//  LinkButtonView.m
//  PhotoBrowsing
//
//  Created by L on 2018/2/8.
//  Copyright © 2018年 L. All rights reserved.
//

#import "LinkButtonView.h"
#define btn_Height 30
#define btn_Width 100
#define image_Width 16
@interface LinkButtonView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end
@implementation LinkButtonView
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUI];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, btn_Width, btn_Height);
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button addSubview:self.imageView];
    [button addSubview:self.label];
}

#pragma mark - Btn Method
- (void)btnAction:(id)sender{
    if (self.clickBtnBlock) {
        self.clickBtnBlock();
    }
}
#pragma mark - set Value
-(void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    self.imageView.image = [UIImage imageNamed:imageStr];
}
- (void)setNumStr:(NSString *)numStr{
    _numStr = numStr;
    self.label.text = numStr;
}
#pragma mark - lazy loading
-(UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(btn_Width/2-image_Width, btn_Height/2 - image_Width, image_Width, image_Width);
        _imageView = imageView;
    }
    return _imageView;
}
- (UILabel *)label{
    if (!_label) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(_imageView.frame.origin.x +image_Width + 2, _imageView.frame.origin.y+3, btn_Width -  _imageView.frame.origin.x +image_Width + 2, image_Width);
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.text = @"999";
        _label = label;
    }
    return _label;
}
@end
