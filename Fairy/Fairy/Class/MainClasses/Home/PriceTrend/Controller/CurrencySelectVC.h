//
//  CurrencySelectVC.h
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLOCK) (NSString *content);

@interface CurrencySelectVC : UIViewController

@property(nonatomic,strong)BLOCK block;
@end