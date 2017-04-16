![Image](https://github.com/ruanqiaohua/PickView/blob/master/image.png)

```Objective-C
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
```
