//
//  XCArrow.m
//  XCDropDownMenu
//
//  Created by Kevin on 16/5/18.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCArrow.h"

@interface XCArrow()

@end


@implementation XCArrow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _m_init];
    }
    return self;
}


-(void)_m_init
{
    
    
    [self drawRect:self.frame];
    
}


-(void)drawRect:(CGRect)rect

{
    
    //设置背景颜色
    [[UIColor clearColor] set];
    
    UIRectFill([self bounds]);
    
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    
    CGContextMoveToPoint(context,0, 0);//设置起点
    
    CGContextAddLineToPoint(context,10, 0);
    
    CGContextAddLineToPoint(context,10, 10);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor redColor] setFill]; //设置填充色
    
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
    
}





@end
