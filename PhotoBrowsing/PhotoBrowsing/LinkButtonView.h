//
//  LinkButtonView.h
//  PhotoBrowsing
//
//  Created by L on 2018/2/8.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkButtonView : UIView
@property (nonatomic,copy) void(^clickBtnBlock)(void);
@property (nonatomic,copy) NSString *imageStr;
@property (nonatomic,copy) NSString *numStr;
@end
