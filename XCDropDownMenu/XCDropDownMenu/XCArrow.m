//
//  XCArrow.m
//  XCDropDownMenu
//
//  Created by Kevin on 16/5/18.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCArrow.h"

@interface XCArrow()
{
    CAShapeLayer *shlayer;

}


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
    
    [self createArrowWithPosition:CGPointMake((self.frame.size.width - 8)/2, (self.frame.size.height - 5)/2)];
    [self.layer addSublayer:shlayer];
    
}



- (void)createArrowWithPosition:(CGPoint)point {
    
    shlayer = [[CAShapeLayer alloc] init];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height)];
    [path closePath];
    
    shlayer.path = path.CGPath;
    shlayer.lineWidth = 1.0;

    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(shlayer.path, nil, shlayer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, shlayer.miterLimit);
    shlayer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    shlayer.position = point;
    
   
}

-(void)setArrowColor:(UIColor *)arrowColor
{

    shlayer.fillColor = arrowColor.CGColor;
    
    

}

@end
