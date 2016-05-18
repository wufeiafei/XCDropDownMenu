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
    
    CAShapeLayer *arrowLayer = [self createArrowWithColor:[UIColor yellowColor] andPosition:CGPointMake((self.frame.size.width - 8)/2, (self.frame.size.height - 5)/2)];
    [self.layer addSublayer:arrowLayer];
    
}



- (CAShapeLayer *)createArrowWithColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}

-(void)setArrowColor:(UIColor *)arrowColor
{

    

}

@end
