//
//  ViewController.m
//  PickView
//
//  Created by 阮巧华 on 2017/4/13.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import "ViewController.h"
#import "ZQPickViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *titleBtn;

@property (nonatomic, weak) IBOutlet UIButton *titleBtn1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 代码创建button
    _titleBtn = [ZQPickViewController arrowButtonWithTitle:@"Test1" frame:CGRectMake(100, 200, 120, 50)];
    [self.view addSubview:_titleBtn];
    [_titleBtn addTarget:self action:@selector(showPickView:) forControlEvents:UIControlEventTouchUpInside];
    // xib创建button
    [ZQPickViewController addArrowImageView:_titleBtn1];
    [_titleBtn1 addTarget:self action:@selector(showPickView:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)showPickView:(UIButton *)sender {
    
    NSArray *titleList = @[@"Test1",@"Test2",@"Test3",@"Test4",@"Test5"];
    ZQPickViewController *vc = [ZQPickViewController initWithTitleButton:sender titleList:titleList];
    [vc selectedCallBack:^(ZQPickViewController *pickViewController, NSInteger index) {
        [sender setTitle:titleList[index] forState:UIControlStateNormal];
        [pickViewController hidden];
    }];
    [vc show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
