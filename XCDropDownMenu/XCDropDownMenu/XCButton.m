//
//  XCButton.m
//  XCDropDownMenu
//
//  Created by Kevin on 16/5/18.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCButton.h"
#import "XCArrow.h"

@interface XCButton()

@property(nonatomic,strong) UILabel *titleLB;

@property(nonatomic,strong) XCArrow *arrow;

@end


@implementation XCButton

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
    
   
    _titleLB = [[UILabel alloc] init];
    _titleLB.frame = CGRectMake(10, 0, self.frame.size.width - 30, self.frame.size.height);
    _titleLB.textColor = _titleColor;
    _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.font = [UIFont systemFontOfSize:15];
    _titleLB.text = _title;
    [self addSubview:_titleLB];
    
    _arrow = [[XCArrow alloc] initWithFrame:CGRectMake(self.frame.size.width - 15, (self.frame.size.height - 10)/2, 10, 10)];
    _arrow.arrowColor = _titleColor;
    [self addSubview:_arrow];
    
    
}

-(void)setTitle:(NSString *)title
{

    _titleLB.text = title;

}



@end
