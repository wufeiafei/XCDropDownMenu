//
//  XCIndexPath.m
//  XCDropDownMenu
//
//  Created by wufei on 16/5/8.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "XCIndexPath.h"

@implementation XCIndexPath

- (instancetype)initWithColumn:(NSInteger)column leftOrRight:(XCIndexPathType)leftOrRight  leftRow:(NSInteger)leftRow row:(NSInteger)row {
    self = [super init];
    if (self) {
        _column = column;
        _leftOrRight = leftOrRight;
        _leftRow = leftRow;
        _row = row;
    }
    return self;
}

+ (instancetype)indexPathWithCol:(NSInteger)col leftOrRight:(XCIndexPathType)leftOrRight leftRow:(NSInteger)leftRow row:(NSInteger)row {
    XCIndexPath *indexPath = [[self alloc] initWithColumn:col leftOrRight:leftOrRight leftRow:leftRow row:row];
    return indexPath;
}

@end
