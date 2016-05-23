//
//  XCRightTableViewCell.m
//  XCDropDownMenu
//
//  Created by wufei on 16/5/23.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCRightTableViewCell.h"
#import "XCArrow.h"
@interface XCRightTableViewCell()


@property(nonatomic,strong) UIView *backView;

@property(nonatomic,strong) UILabel *titleLB;

@property(nonatomic,strong) XCArrow *arrow;


@end

@implementation XCRightTableViewCell


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
    _titleLB.frame = CGRectMake(20, 0, self.frame.size.width - 60, self.frame.size.height -1);
    _titleLB.textAlignment = NSTextAlignmentLeft;
    _titleLB.font = [UIFont systemFontOfSize:14.0f];
    [_backView addSubview:_titleLB];
    
    _arrow = [[XCArrow alloc] initWithFrame:CGRectMake(80, 0, 40,self.frame.size.height)];
    
    [_backView addSubview:_arrow];
    
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    line.backgroundColor = [UIColor grayColor];
    [_backView addSubview:line];
    
}

-(void)setTitle:(NSString *)title{
    
    _titleLB.text = title;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
