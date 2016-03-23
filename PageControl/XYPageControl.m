//
//  XYPageControl.m
//  CATransition图片轮播
//
//  Created by Jack on 16/3/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "XYPageControl.h"

@implementation XYPageControl

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.hidesForSinglePage = YES;
        self.defersCurrentPageDisplay = YES;
    }
    return self;
}

- (void)updateCurrentPageDisplay{
    [super updateCurrentPageDisplay];
    [self updatePages];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updatePages];
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount{
    
    return CGSizeMake(20, 20);
}

- (void)updatePages
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView* pageView = [self.subviews objectAtIndex:i];
        
        //CGPoint point = pageView.frame.origin;
        
       // [pageView setFrame:CGRectMake(point.x, point.y+4, 15, 15)];
        
        if (i == self.currentPage) {
            pageView.backgroundColor = [UIColor blackColor];
        }
    }
    
}

@end
