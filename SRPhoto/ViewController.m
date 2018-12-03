//
//  ViewController.m
//  SRPhoto
//
//  Created by 索晓晓 on 2018/8/8.
//  Copyright © 2018年 SXiao.RR. All rights reserved.
//

#import "ViewController.h"
#import "InputVerificationCodeView.h"

@interface ViewController ()

@property (nonatomic , strong) InputVerificationCodeView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UICollectionViewFlowLayout
//    UICollectionView
//    
//    NSLog(@"%p \n %p \n %p \n %p",
//          self.class,
//          [ViewController class],
//          [[ViewController class] class],
//          [self.superclass class]);
//    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (InputVerificationCodeView *)topView
{
    if (!_topView) {
        _topView = [[InputVerificationCodeView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
        _topView.backgroundColor = [UIColor cyanColor];
    }
    return _topView;
}

@end
