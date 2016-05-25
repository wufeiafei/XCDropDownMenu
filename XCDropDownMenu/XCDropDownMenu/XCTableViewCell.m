//
//  XCTableViewCell.m
//  XCDropDownMenu
//
//  Created by wufei on 16/5/8.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCTableViewCell.h"

@interface XCTableViewCell()


@property(nonatomic,strong) UIView *backView;

@property(nonatomic,strong) UILabel *titleLB;


@end


@implementation XCTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    
        [self initSubView];
        
    }
    return self;
}



-(void)initSubView
{
    _backView = [[UIView alloc] init];
    _backView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.frame = CGRectMake(20, 0, self.frame.size.width - 20, self.frame.size.height -1);
    _titleLB.textAlignment = NSTextAlignmentLeft;
    _titleLB.font = [UIFont systemFontOfSize:14.0f];
    [_backView addSubview:_titleLB];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    line.backgroundColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1.0];
    [_backView addSubview:line];

}

-(void)setTitle:(NSString *)title{
    
    _titleLB.text = title;
    // 只取宽度

    
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
       
        _titleLB.textColor = [UIColor yellowColor];

    }
    else
    {
        _titleLB.textColor = [UIColor blackColor];
    
    }
   
    
}

@end
