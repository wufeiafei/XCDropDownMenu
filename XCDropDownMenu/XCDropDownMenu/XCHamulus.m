//
//  XCHamulus.m
//  XCDropDownMenu
//
//  Created by wufei on 16/5/26.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCHamulus.h"

@interface XCHamulus()
{
    CAShapeLayer *hlayer;
    
}


@end

@implementation XCHamulus


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
    [self.layer addSublayer:hlayer];
    
}



- (void)createArrowWithPosition:(CGPoint)point {
    
    hlayer = [[CAShapeLayer alloc] init];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 2 * self.frame.size.height/3.0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/3, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    
    hlayer.path = path.CGPath;
    hlayer.lineWidth = 1.0;
    hlayer.fillColor = nil;
    
    
    
    
}

-(void)setHamulusColor:(UIColor *)hamulusColor
{
    
    hlayer.strokeColor = hamulusColor.CGColor;
    
    
    
}




@end
