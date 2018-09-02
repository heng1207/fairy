//
//  HomeSubVC.h
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSubVC : UIViewController

@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isRefresh;

@property(nonatomic,strong) NSString *headTypeID;//标题类型ID


@end
