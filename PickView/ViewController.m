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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleBtn = [ZQPickViewController arrowButtonWithTitle:@"Button" frame:CGRectMake(100, 200, 120, 50)];
    [self.view addSubview:_titleBtn];
    [_titleBtn addTarget:self action:@selector(showPickView:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showPickView:(UIButton *)sender {
    
    NSArray *titleList = @[@"Test1",@"Test2",@"Test3",@"Test4",@"Test5"];
    ZQPickViewController *vc = [ZQPickViewController initWithTitleButton:_titleBtn titleList:titleList];
    [vc selectedCallBack:^(ZQPickViewController *pickViewController, NSInteger index) {
        [_titleBtn setTitle:titleList[index] forState:UIControlStateNormal];
        [pickViewController hidden];
    }];
    vc.backViewColor = [UIColor purpleColor];
    [vc show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
