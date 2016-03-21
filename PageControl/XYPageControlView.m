//
//  XYPageControlView.m
//  CATransition图片轮播
//
//  Created by Jack on 16/3/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "XYPageControlView.h"

@interface XYPageControlView()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)NSArray *imageList;
@property (strong, nonatomic)NSTimer *timer;
@end

@implementation XYPageControlView

#pragma mark -- initWithFrame
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSwipeGesture];
        
    }
    return self;
}


- (void)dealloc{
    @autoreleasepool {
        [self.timer invalidate];
    }
}

#pragma mark -- 更新视图
- (void)updateUIWithImages:(NSArray *)images{
    [self.imageView setImage:[UIImage imageNamed:images[0]]];
    
    [self removewNSTimer];
    
   // self.imageList = images;
    [self addSubview:self.pageControl];
    [self addNSTimer];
}

#pragma mark -- 图片轮播处理

- (void)addSwipeGesture{
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addGestureRecognizer:leftSwipeGesture];
    [self addGestureRecognizer:rightSwipeGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPicture)];
    [self addGestureRecognizer:tapGesture];
}


-(void)transitionAnimation:(BOOL)isNext{
    CATransition *transition = [[CATransition alloc]init];
    /*
     1.#define定义的常量
     kCATransitionFade   交叉淡化过渡
     kCATransitionMoveIn 新视图移到旧视图上面
     kCATransitionPush   新视图把旧视图推出去
     kCATransitionReveal 将旧视图移开,显示下面的新视图
     
     2.用字符串表示
     pageCurl            向上翻一页
     pageUnCurl          向下翻一页
     rippleEffect        滴水效果
     suckEffect          收缩效果，如一块布被抽走
     cube                立方体效果
     oglFlip             上下翻转效果
     
     */
    transition.type = kCATransitionMoveIn;
    
    if(isNext){
        transition.subtype = kCATransitionFromRight;
    }else{
        transition.subtype = kCATransitionFromLeft;
    }
    
    transition.duration = 2.0f;
    
    [self.imageView setImage:[self getImage:isNext]];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}


#pragma mark -- IBAction

- (void)leftSwipe:(UISwipeGestureRecognizer *)sender{
    [self removewNSTimer];
    [self transitionAnimation:YES];
    [self addNSTimer];
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)sender{
    [self removewNSTimer];
    [self transitionAnimation:NO];
    [self addNSTimer];
}

- (IBAction)pageControlChanged:(UIPageControl *)sender{
    [self removewNSTimer];
    [self.imageView setImage:[UIImage imageNamed:self.imageList[sender.currentPage]]];
    [self addNSTimer];
}

//自动轮播
- (void)autoPlayCarousel{
    [self transitionAnimation:YES];
    
}

//图片点击回调
- (void)clickPicture{
    self.clickImage([NSString stringWithFormat:@"%ld",self.pageControl.currentPage]);
}


#pragma mark -- addNSTimer
- (void)addNSTimer{

    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}


- (void)removewNSTimer{
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    NSInteger currentIndex = self.pageControl.currentPage;
    if (isNext) {
        currentIndex = (currentIndex+1) % self.imageList.count;
    }else{
        currentIndex = (currentIndex-1 + self.imageList.count)%self.imageList.count;
    }
    NSString *imageName=[NSString stringWithFormat:@"%@.jpg",@(currentIndex)];
    self.pageControl.currentPage = currentIndex;

    return [UIImage imageNamed:imageName];
}


#pragma mark -- getter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-10, self.imageList.count * 20, 20)];
        [_pageControl.layer setPosition:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)-20)];
        _pageControl.backgroundColor = [UIColor orangeColor];
        _pageControl.numberOfPages = [self.imageList count];
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
    
    
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(autoPlayCarousel) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (NSArray *)imageList{
    if (!_imageList) {
        _imageList = @[@"0", @"1", @"2", @"3"];
    }
    return _imageList;
}
@end
