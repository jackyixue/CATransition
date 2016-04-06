//
//  ViewController.m
//  CATransition图片轮播
//
//  Created by Jack on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "XYPageControlView.h"
#import "XYPageControl1.h"
@interface ViewController ()

@property (strong, nonatomic)NSArray *picturs;

@property (strong, nonatomic) XYPageControlView *pageControlView;
@property (strong, nonatomic) XYPageControl *pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pageControlView];
    //更新轮播器
    [self.pageControlView updateUIWithImages:self.picturs];
    
    //图片点击回调
    [self.pageControlView setClickImage:^(NSString *nn) {
        NSLog(@"点击%@",nn);
    }];
    
   // [self.view addSubview:self.pageControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pageControlChanged:(XYPageControl *)sender{
    [sender setCurrentPage:sender.currentPage];
    
}
#pragma mark -- getter
//懒加载，初始化
- (XYPageControlView *)pageControlView{
    if (!_pageControlView) {
        _pageControlView = [[XYPageControlView alloc]initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.view.frame), 300)];
    }
    return _pageControlView;
}

- (NSArray *)picturs{
    if (!_picturs) {
        _picturs = @[@"0", @"1", @"2", @"3"];
    }
    return _picturs;
}

//@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14"]


- (XYPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[XYPageControl alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];
        _pageControl.backgroundColor = [UIColor orangeColor];
        _pageControl.numberOfPages = 4;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
@end
