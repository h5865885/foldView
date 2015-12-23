//
//  WHFoldView.m
//  折叠动画
//
//  Created by xxoo on 15/12/22.
//  Copyright © 2015年 xxoo. All rights reserved.
//

#import "WHFoldView.h"

@interface WHFoldView ()

@end

@implementation WHFoldView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 20)];
        label.text = @"大大的飒飒大苏打";
        [self addSubview:label];
        self.clipsToBounds = YES;
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 250, 200, 20)];
        label1.text = @"啊阿斯达撒飒飒大苏打";
        [self addSubview:label1];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, 200, 20)];
        label2.text = @"大打算打打阿斯达撒飒飒大苏打";
        [self addSubview:label2];

        
        UIView * viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 2)];
        viewLine.backgroundColor = [UIColor redColor];
        [self addSubview:viewLine];
    }
    return self;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


@end
