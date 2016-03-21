//
//  XYPageControlView.h
//  CATransition图片轮播
//
//  Created by Jack on 16/3/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPageControlView : UIView
@property (copy, nonatomic) void (^clickImage)(NSString *name);

- (void) updateUIWithImages:(NSArray *)images;

@end
