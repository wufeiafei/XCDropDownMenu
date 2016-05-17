//
//  XCIndexPath.h
//  XCDropDownMenu
//
//  Created by wufei on 16/5/8.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, XCIndexPathType) {
    kXCIndexPathLeft = 0,
    kXCIndexPathRight = 1,
};

@interface XCIndexPath : NSObject


@property (nonatomic, assign) NSInteger column;
// 0 左边   1 右边
//@property (nonatomic, assign) NSInteger leftOrRight;
@property (nonatomic, assign) XCIndexPathType leftOrRight;

// 左边行
@property (nonatomic, assign) NSInteger leftRow;
// 右边行
@property (nonatomic, assign) NSInteger row;

- (instancetype)initWithColumn:(NSInteger)column leftOrRight:(XCIndexPathType)leftOrRight leftRow:(NSInteger)leftRow row:(NSInteger)row;

+ (instancetype)indexPathWithCol:(NSInteger)col leftOrRight:(XCIndexPathType)leftOrRight leftRow:(NSInteger)leftRow row:(NSInteger)row;

@end
