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
    _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLB];
    
    _arrow = [[XCArrow alloc] initWithFrame:CGRectMake(self.frame.size.width - 15, (self.frame.size.height - 10)/2, 10, 10)];
    [self addSubview:_arrow];
    
    
}

-(void)setTitle:(NSString *)title
{
    _titleLB.text = title;

    CGSize size = [self calculateTitleSizeWithString:title];
    CGFloat width = MIN(size.width, self.frame.size.width - 30);
    _titleLB.frame = CGRectMake(self.frame.size.width/2.0 - width/2.0, 0, width, self.frame.size.height);
    _arrow.frame = CGRectMake(_titleLB.frame.origin.x + width + 5, (self.frame.size.height - 10)/2, 10, 10);

   

}


-(void)setTitleColor:(UIColor *)titleColor
{

    _titleLB.textColor = titleColor;
    _arrow.arrowColor = titleColor;

}



- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.frame.size.width, 0)
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:dic
                                       context:nil].size;
    return size;
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    CGAffineTransform transform = selected ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
    [UIView animateWithDuration:.15f animations:^{
        _arrow.transform = transform;
    }];
}


- (void)setHighlighted:(BOOL)highlighted {
    [super setSelected:highlighted];
    
    CGAffineTransform transform = highlighted ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
    [UIView animateWithDuration:.15f animations:^{
        _arrow.transform = transform;
    }];
}


@end
