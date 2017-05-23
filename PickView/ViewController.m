//
//  ViewController.m
//  PickView
//
//  Created by 阮巧华 on 2017/4/13.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import "ViewController.h"
#import "ZQPickViewController.h"
#import "UIImage+Add.h"

@interface ViewController ()

@property (nonatomic, strong) ZQPickButton *titleBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titleBtn = [ZQPickViewController buttonWithFrame:CGRectMake(100, 200, 120, 30)];
    _titleBtn.titleLabel.text = [NSString stringWithFormat:@"Test1"];
    _titleBtn.arrowImageView.image = [UIImage imageNamed:@"botton"];
    _titleBtn.imageView.image = [[UIImage imageNamed:@"cat"] circleImage];
    [self.view addSubview:_titleBtn];
    [_titleBtn addTarget:self action:@selector(showPickView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showPickView:(ZQPickButton *)sender {
    
    NSArray *titleList = @[@"Test1",@"Test2",@"Test3",@"Test4",@"Test5"];
    ZQPickViewController *vc = [ZQPickViewController initWithTitleButton:sender titleList:titleList];
    [vc selectedCallBack:^(ZQPickViewController *pickViewController, NSInteger index) {
        sender.titleLabel.text = titleList[index];
        [pickViewController hidden];
    }];
    [vc show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
