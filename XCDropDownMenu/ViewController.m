//
//  ViewController.m
//  XCDropDownMenu
//
//  Created by wufei on 16/5/8.
//  Copyright © 2016年 wufei. All rights reserved.
//

#import "ViewController.h"
#import "XCDropDownMenu.h"

@interface ViewController ()<XCDropDownMenuDataSource,XCDropDownMenuDelegate>{
    
    NSMutableArray *_data0;
    NSMutableArray *_data1;
    NSMutableArray *_data2;
   
    NSInteger _currentData0Index;
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
  
    NSInteger _currentData0SelectedIndex;
    XCDropDownMenu *menu;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout =  UIRectEdgeNone;
    
    self.title = @"下拉菜单";
    

    // 指定默认选中
    _currentData0Index = 1;
    _currentData0SelectedIndex = 1;
    
    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐"];
    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    
    _data0 = [NSMutableArray arrayWithObjects:@{@"title":@"哈哈哈", @"data":food}, @{@"title":@"嘿嘿嘿", @"data":travel}, nil];
    _data1 = [NSMutableArray arrayWithObjects:@{@"title":@"美食", @"data":food}, @{@"title":@"旅游", @"data":travel}, nil];
    _data2 = [NSMutableArray arrayWithObjects:@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
   
    
    menu = [[XCDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];

    
    
    
}





- (NSInteger)numberOfColumnsInMenu:(XCDropDownMenu *)menu {
    
    return 3;
}



-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column == 0 ||column == 1) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column == 0 || column == 1) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column == 0) {
        
        return _currentData0Index;
        
    }
    if (column == 1) {
        
        return _currentData1Index;
        
    }
    if (column == 2) {
        
        return _currentData2Index;
    }
    
    return 0;
}

- (NSInteger)menu:(XCDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    if (column == 0) {
        if (leftOrRight== kXCIndexPathLeft) {
            
            return _data0.count;
        } else{
            
            NSDictionary *menuDic = [_data0 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    }
    else if (column == 1) {
        if (leftOrRight == kXCIndexPathLeft) {
            
            return _data1.count;
        } else{
            
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column == 2){
        
        return _data2.count;
        
    }
    
    return 0;
}

- (NSString *)menu:(XCDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            return [[_data0[_currentData1Index] objectForKey:@"data"] objectAtIndex:0];
            break;
        case 1:
            return [[_data1[_currentData1Index] objectForKey:@"data"] objectAtIndex:0];
            break;
        case 2:
            return _data2[_currentData2Index];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(XCDropDownMenu *)menu titleForRowAtIndexPath:(XCIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        if (indexPath.leftOrRight == kXCIndexPathLeft) {
            
            NSDictionary *menuDic = [_data0 objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
            
        } else{
            
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data0 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    }
    else if (indexPath.column == 1) {
        if (indexPath.leftOrRight == kXCIndexPathLeft) {
            
            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
            
        } else{
            
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column == 2) {
        
        return _data2[indexPath.row];
        
    }
    return nil;
}

- (void)menu:(XCDropDownMenu *)menu didSelectRowAtIndexPath:(XCIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight == kXCIndexPathLeft){
            
            _currentData0Index = indexPath.row;
            
            return;
        }
        
    }
    else if (indexPath.column == 1) {
        
        if(indexPath.leftOrRight== kXCIndexPathLeft){
            
            _currentData1Index = indexPath.row;
            
            return;
        }
        
    } else if(indexPath.column == 2){
        
        _currentData2Index = indexPath.row;
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
