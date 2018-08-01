//
//  PriceDetailedSubVC.h
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceDetailedSubVC : UIViewController

@property(nonatomic,strong) NSString *headType;

- (void)loadMainTableData:(NSString *)type isPull:(BOOL)isPull;

@end
