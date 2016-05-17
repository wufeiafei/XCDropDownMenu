//
//  XCDropDownMenu.h
//  XCDropDownMenu
//
//  Created by wufei on 16/5/8.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCIndexPath.h"


#pragma mark - data source protocol
@class XCDropDownMenu;

@protocol XCDropDownMenuDataSource <NSObject>

@required
- (NSInteger)menu:(XCDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow;

- (NSString *)menu:(XCDropDownMenu *)menu titleForRowAtIndexPath:(XCIndexPath *)indexPath;

- (NSString *)menu:(XCDropDownMenu *)menu titleForColumn:(NSInteger)column;
/**
 * 表视图显示时，左边表显示比例
 */
- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column;
/**
 * 表视图显示时，是否需要两个表显示
 */
- (BOOL)haveRightTableViewInColumn:(NSInteger)column;

/**
 * 返回当前菜单左边表选中行
 */
- (NSInteger)currentLeftSelectedRow:(NSInteger)column;

@optional
//default value is 1
- (NSInteger)numberOfColumnsInMenu:(XCDropDownMenu *)menu;



@end

#pragma mark - delegate
@protocol XCDropDownMenuDelegate <NSObject>
@optional
- (void)menu:(XCDropDownMenu *)menu didSelectRowAtIndexPath:(XCIndexPath *)indexPath;


@end



@interface XCDropDownMenu : UIView<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) id <XCDropDownMenuDataSource> dataSource;

@property (nonatomic, weak) id <XCDropDownMenuDelegate> delegate;

/*
 选择器的颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/*
 字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/*
分割线的颜色
 */
@property (nonatomic, strong) UIColor *separatorColor;

/**
 *  the width of menu will be set to screen width defaultly
 *
 *  @param origin the origin of this view's frame
 *  @param height menu's height
 *
 *  @return menu
 */

- (void)setSelectIndex:(XCIndexPath *)indexPath;

/*
 初始化方法
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;


/*
 
 */
- (NSString *)titleForRowAtIndexPath:(XCIndexPath *)indexPath;


@end




