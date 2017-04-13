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

@property (nonatomic, weak) IBOutlet UIButton *titleBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showPickView:(UIButton *)sender {
    
    ZQPickViewController *vc = [ZQPickViewController initWithTitleButton:_titleBtn titleList:@[@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello"]];
    [vc show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
