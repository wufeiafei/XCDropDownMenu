//
//  XCRightTableViewCell.m
//  XCDropDownMenu
//
//  Created by wufei on 16/5/23.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCRightTableViewCell.h"
#import "XCArrow.h"
#import "XCHamulus.h"

@interface XCRightTableViewCell()

@property(nonatomic,strong) UILabel *titleLB;

@property(nonatomic,strong) XCHamulus *hamulus;


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

    
    _titleLB = [[UILabel alloc] init];
    _titleLB.frame = CGRectMake(0, 0, self.frame.size.width - 60, self.frame.size.height);
    _titleLB.textAlignment = NSTextAlignmentLeft;
    _titleLB.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:_titleLB];
    
    _hamulus = [[XCHamulus alloc] initWithFrame:CGRectMake(0,0, 10,10)];
    _hamulus.hamulusColor = [UIColor blackColor];
    [self addSubview:_hamulus];
    
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    line.backgroundColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1.0];
    [self addSubview:line];
    
}

-(void)setTitle:(NSString *)title{
    
    CGFloat titleWidth = [self calculateTitleSizeWithString:title].width;
    
    _titleLB.frame = CGRectMake(20, 0, titleWidth, self.frame.size.height);
    _titleLB.text = title;
    
    _hamulus.frame = CGRectMake(20 + titleWidth + 5, (self.frame.size.height - 10)/2, 10, 10);
    
    

}


- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.frame.size.width - 20 - 10, 0)
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:dic
                                       context:nil].size;
    return size;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    
}

@end
