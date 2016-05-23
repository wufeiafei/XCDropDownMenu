//
//  XCDropDownMenu.m
//  XCDropDownMenu
//
//  Created by wufei on 16/5/8.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCDropDownMenu.h"
#import "XCTableViewCell.h"
#import "XCButton.h"
#import "XCRightTableViewCell.h"

#define BackColor [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1.0]

// 选中颜色加深
#define SelectColor [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]


@interface XCDropDownMenu ()

@property (nonatomic, assign) NSInteger currentSelectedMenuIndex;

@property (nonatomic, assign) BOOL show;

@property (nonatomic, assign) NSInteger numberOfMenu;

@property (nonatomic, assign) CGPoint origin;


@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UITableView *rightTableView;

//data source
@property (nonatomic, copy) NSArray *array;
//layers array
@property (nonatomic, copy) NSArray *titlesArray;

@property (nonatomic, copy) NSArray *indicatorsArray;

@property (nonatomic, copy) NSArray *bgLayersArray;

@property (nonatomic, assign) NSInteger leftSelectedRow;

@property (nonatomic, assign) BOOL hadSelected;

@end

@implementation XCDropDownMenu


#pragma mark - getter
- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor blackColor];
    }
    return _indicatorColor;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor blackColor];
    }
    return _separatorColor;
}

- (void)setSelectIndex:(XCIndexPath *)indexPath
{
    
    
    
}



- (NSString *)titleForRowAtIndexPath:(XCIndexPath *)indexPath {
    
    return [self.dataSource menu:self titleForRowAtIndexPath:indexPath];
}


#pragma mark - setter
- (void)setDataSource:(id<XCDropDownMenuDataSource>)dataSource {
    _dataSource = dataSource;
    
    //configure view
    if ([_dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        _numberOfMenu = [_dataSource numberOfColumnsInMenu:self];
    } else {
        _numberOfMenu = 1;
    }
    
    
    CGFloat bgLayerInterval = self.frame.size.width/_numberOfMenu;
    
    NSMutableArray *tempTitlesArray = [[NSMutableArray alloc] initWithCapacity:_numberOfMenu];
    NSMutableArray *tempIndicatorsArray = [[NSMutableArray alloc] initWithCapacity:_numberOfMenu];
    NSMutableArray *tempBgLayersArray = [[NSMutableArray alloc] initWithCapacity:_numberOfMenu];
    
    
    for (int i = 0; i < _numberOfMenu; i++) {
        
        XCButton *btn = [[XCButton alloc] initWithFrame:CGRectMake(i * bgLayerInterval, 0, bgLayerInterval, self.frame.size.height)];
        btn.backgroundColor = [UIColor redColor];
        btn.tag = i + 1;
        btn.title = [self.dataSource menu:self titleForColumn:i];
        btn.titleColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    
    }
    
    for (int i = 1; i < _numberOfMenu; i++) {
        
        UILabel *line  = [[UILabel alloc] init];
        line.frame = CGRectMake(bgLayerInterval * i, 3,1 , self.frame.size.height - 6);
        line.backgroundColor = [UIColor greenColor];
        [self addSubview:line];
        
    }
 
    
    
    _titlesArray = [tempTitlesArray copy];
    _indicatorsArray = [tempIndicatorsArray copy];
    _bgLayersArray = [tempBgLayersArray copy];
    
}

#pragma mark - init method
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];
    if (self) {
        _origin = origin;
        _currentSelectedMenuIndex = 0;
        _show = NO;
        
        _hadSelected = NO;
        
        //tableView init
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x, self.frame.origin.y + self.frame.size.height, 0, 0)];
        _leftTableView.rowHeight = 38;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width, self.frame.origin.y + self.frame.size.height, 0, 0)];
        _rightTableView.rowHeight = 38;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;;
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        
        
        self.autoresizesSubviews = NO;
        _leftTableView.autoresizesSubviews = NO;
        _rightTableView.autoresizesSubviews = NO;
    
        
    }
    return self;
}

#pragma mark - init support
- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, self.frame.size.width/self.numberOfMenu, self.frame.size.height - 1);
    layer.backgroundColor = color.CGColor;
    
    return layer;
}

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
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




- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

#pragma mark -- action

-(void)btnPressed:(UIButton*)btn
{
    
    _hadSelected = NO;
    _currentSelectedMenuIndex = btn.tag - 1;
    
    BOOL haveRightTableView = [_dataSource haveRightTableViewInColumn:_currentSelectedMenuIndex];
    
    UITableView *rightTableView = nil;
    
    if (haveRightTableView) {
        rightTableView = _rightTableView;
        // 修改左右tableview显示比例
        
    }
    
    if ([_dataSource respondsToSelector:@selector(currentLeftSelectedRow:)]) {
        
        _leftSelectedRow = [_dataSource currentLeftSelectedRow:_currentSelectedMenuIndex];
    }
    
    if (rightTableView) {
        [rightTableView reloadData];
    }
    [_leftTableView reloadData];
    
    CGFloat ratio = [_dataSource widthRatioOfLeftColumn:_currentSelectedMenuIndex];
    if (_leftTableView) {
        
        _leftTableView.frame = CGRectMake(_leftTableView.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width * ratio, 0);
    }
    
    if (_rightTableView) {
        
        _rightTableView.frame = CGRectMake(_origin.x + _leftTableView.frame.size.width, self.frame.origin.y + self.frame.size.height, self.frame.size.width * (1 - ratio), 0);
    }
    
    [self animateLeftTableView:_leftTableView
                rightTableView:rightTableView
                          show:YES
                      complete:^{
                      }];



}



#pragma mark - animation method
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[@(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    complete();
}

- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

/**
 *动画显示下拉菜单
 */
- (void)animateLeftTableView:(UITableView *)leftTableView rightTableView:(UITableView *)rightTableView show:(BOOL)show complete:(void(^)())complete {
    
    CGFloat ratio = [_dataSource widthRatioOfLeftColumn:_currentSelectedMenuIndex];
    
     CGFloat heigtw = [UIScreen mainScreen].bounds.size.height;
    
    if (show) {
        
        CGFloat leftTableViewHeight = 0;
        
        CGFloat rightTableViewHeight = 0;
        
        if (leftTableView) {
            
            leftTableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width * ratio, 0);
            [self.superview addSubview:leftTableView];
            
            leftTableViewHeight = ([leftTableView numberOfRowsInSection:0] * leftTableView.rowHeight > heigtw - self.frame.origin.y - self.frame.size.height) ? (heigtw - self.frame.origin.y - self.frame.size.height) : ([leftTableView numberOfRowsInSection:0] * leftTableView.rowHeight);
            
        }
        
        if (rightTableView) {
            
           
            rightTableView.frame = CGRectMake(_origin.x + leftTableView.frame.size.width, self.frame.origin.y + self.frame.size.height, self.frame.size.width * (1 - ratio), 0);
            
            [self.superview addSubview:rightTableView];
            
            rightTableViewHeight = ([rightTableView numberOfRowsInSection:0] * rightTableView.rowHeight > heigtw - self.frame.origin.y - self.frame.size.height) ? (heigtw - self.frame.origin.y - self.frame.size.height) : ([rightTableView numberOfRowsInSection:0] * rightTableView.rowHeight);
        }
        
        CGFloat tableViewHeight = MAX(leftTableViewHeight, rightTableViewHeight);
        
        [UIView animateWithDuration:0.2 animations:^{
            if (leftTableView) {
                leftTableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width * ratio, tableViewHeight);
            }
            if (rightTableView) {
                rightTableView.frame = CGRectMake(_origin.x+leftTableView.frame.size.width, self.frame.origin.y + self.frame.size.height, self.frame.size.width*(1 - ratio), tableViewHeight);
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            
            if (leftTableView) {
                leftTableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width * ratio, 0);
            }
            if (rightTableView) {
                rightTableView.frame = CGRectMake(_origin.x + leftTableView.frame.size.width, self.frame.origin.y + self.frame.size.height, self.frame.size.width * (1-ratio), 0);
            }
            
        } completion:^(BOOL finished) {
            
            if (leftTableView) {
                [leftTableView removeFromSuperview];
            }
            if (rightTableView) {
                [rightTableView removeFromSuperview];
            }
        }];
    }
    complete();
}



- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete {
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numberOfMenu) - 25) ? size.width : self.frame.size.width / _numberOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background leftTableView:(UITableView *)leftTableView rightTableView:(UITableView *)rightTableView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateLeftTableView:leftTableView rightTableView:rightTableView show:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}



#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 0 左边   1 右边
    NSInteger leftOrRight = kXCIndexPathLeft;
    if (_rightTableView == tableView) {
        leftOrRight = kXCIndexPathRight;
    }
    
    NSAssert(self.dataSource != nil, @"menu's dataSource shouldn't be nil");
    if ([_dataSource respondsToSelector:@selector(menu:numberOfRowsInColumn:leftOrRight: leftRow:)]) {
        return [_dataSource menu:self numberOfRowsInColumn:_currentSelectedMenuIndex leftOrRight:leftOrRight leftRow:_leftSelectedRow];
    } else {
        NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == _leftTableView) {

        static NSString *identifier = @"XCDropDownMenuCell";
    
        XCTableViewCell *leftCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (leftCell == nil) {
            leftCell = [[XCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:identifier];
        }
        
        [leftCell setTitle:[_dataSource menu:self titleForRowAtIndexPath:[XCIndexPath indexPathWithCol:_currentSelectedMenuIndex leftOrRight:kXCIndexPathLeft leftRow:_leftSelectedRow row:indexPath.row]]];
    
        cell = leftCell;
    }
    
    if (tableView == _rightTableView) {
        static NSString *identifier = @"XCDropDownMenuRightCell";
        
        XCRightTableViewCell *rightCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (rightCell == nil) {
            rightCell = [[XCRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:identifier];
        }
        
        [rightCell setTitle:[_dataSource menu:self titleForRowAtIndexPath:[XCIndexPath indexPathWithCol:_currentSelectedMenuIndex leftOrRight:kXCIndexPathRight leftRow:_leftSelectedRow row:indexPath.row]]];
        
        cell = rightCell;
    }
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger leftOrRight = kXCIndexPathLeft;
    if (_rightTableView == tableView) {
        
        leftOrRight = kXCIndexPathRight;
        
    } else {
        
        _leftSelectedRow = indexPath.row;
    }
    
    if (_delegate || [_delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
        
        BOOL haveRightTableView = [_dataSource haveRightTableViewInColumn:_currentSelectedMenuIndex];
        
        if ((leftOrRight == kXCIndexPathLeft && !haveRightTableView) || leftOrRight == kXCIndexPathRight) {
            
            [self confiMenuWithSelectRow:indexPath.row leftOrRight:leftOrRight];
        }
        
        [_delegate menu:self didSelectRowAtIndexPath:[XCIndexPath indexPathWithCol:_currentSelectedMenuIndex leftOrRight:leftOrRight leftRow:_leftSelectedRow row:indexPath.row]];
        
        if (leftOrRight == kXCIndexPathLeft && haveRightTableView) {
            if (!_hadSelected) {
                _hadSelected = YES;
                [_leftTableView reloadData];
                NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:_leftSelectedRow inSection:0];
                
                [_leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
            
            [_rightTableView reloadData];
        }
        
    } else {
        
        
    }
}

- (void)confiMenuWithSelectRow:(NSInteger)row leftOrRight:(NSInteger)leftOrRight{
    
    XCButton *btn = [self viewWithTag:_currentSelectedMenuIndex + 1];
  
    NSString *string = [_dataSource menu:self titleForRowAtIndexPath:[XCIndexPath indexPathWithCol:_currentSelectedMenuIndex leftOrRight:leftOrRight leftRow:_leftSelectedRow row:row]];
    
    [btn setTitle:string];
   
    [self animateLeftTableView:_leftTableView
                rightTableView:_rightTableView
                          show:NO
                      complete:^{
        
    }];
    
   
}




@end
