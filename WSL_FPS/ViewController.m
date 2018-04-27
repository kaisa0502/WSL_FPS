//
//  ViewController.m
//  WSL_FPS
//
//  Created by 王双龙 on 2018/4/24.
//  Copyright © 2018年 https://www.jianshu.com/p/a3a4b060b9fd All rights reserved.
//

#import "ViewController.h"
#import "WSLFPS.h"
#import "WSLSuspendingView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WSLSuspendingView * suspendingView = [WSLSuspendingView sharedSuspendingView];
    
    WSLFPS * fps = [WSLFPS sharedFPSIndicator];
    [fps startMonitoring];
    fps.FPSBlock = ^(float fps) {
       suspendingView.fpsLabel.text = [NSString stringWithFormat:@"FPS = %.2f",fps];
        NSLog(@"FPS = %@",suspendingView.fpsLabel.text);
    };
    
}

#pragma mark -- UITableViewDelegate  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    
    if (_listStyle == listStyle3) {
        //会一直存在内存中
        cell.imageView.image = [UIImage imageNamed:@"piao"];
    }else{
        //不会一直占用内存，但需要进行IO并每次都解压图片
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"piao" ofType:@"png"];
        cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    }
   
    if (_listStyle == listStyle1) {
        //阴影效果
        cell.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.imageView.layer.shadowOpacity = 0.8f;
        cell.imageView.layer.shadowRadius = 34;
        cell.imageView.layer.shadowOffset = CGSizeMake(4,4);
    }else if (_listStyle == listStyle2){
        //裁剪
        cell.imageView.layer.cornerRadius = 30;
        cell.imageView.clipsToBounds = YES;
    }
    
    cell.textLabel.text = @"FPS 性能测试";
    
    return cell;
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 获取指定的Storyboard，name填写Storyboard的文件名
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 从Storyboard上按照identifier获取指定的界面（VC），identifier必须是唯一的
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"vc"];
     vc.listStyle = (ListStyle)arc4random() % 3;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
