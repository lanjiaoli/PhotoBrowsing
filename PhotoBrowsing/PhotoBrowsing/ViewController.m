//
//  ViewController.m
//  PhotoBrowsing
//
//  Created by L on 2017/8/26.
//  Copyright © 2017年 L. All rights reserved.
//

#import "ViewController.h"
#import "PhotoImageViewController.h"
#import <MessageUI/MessageUI.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"测试";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:16] }];
}
#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PhotoImageViewController *vc = [[PhotoImageViewController alloc]init];
//    vc.index = indexPath.row;
//    vc.allNum = 4;
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    [picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];

    picker.messageComposeDelegate = self;
    // You can specify one or more preconfigured recipients.  The user has
    // the option to remove or add recipients from the message composer view
    // controller.
    picker.recipients = @[@"10010",@"10086"];
    
    // You can specify the initial message text that will appear in the message
    // composer view controller.
    picker.body = @"Hello from California!";
    
    [self presentViewController:picker animated:YES completion:NULL];//显示系统SMS界面
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
