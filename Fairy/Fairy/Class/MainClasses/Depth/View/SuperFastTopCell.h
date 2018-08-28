//
//  SuperFastTopCell.h
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperFastTopCell : UITableViewCell
@property (nonatomic,strong)UILabel *NowPrice;
@property (nonatomic,strong)UIView *RedView;
@property (nonatomic,strong)UILabel *NowHelp;
@property (nonatomic,strong)UILabel *UpdateTime;

//时间
@property (nonatomic,strong)UILabel *time1;
@property (nonatomic,strong)UILabel *time2;
@property (nonatomic,strong)UILabel *time3;

//短期
@property (nonatomic,strong)UILabel *shouyi1;
@property (nonatomic,strong)UILabel *shouyi2;
@property (nonatomic,strong)UILabel *shouyi3;

//基准
@property (nonatomic,strong)UILabel *jizhun1;
@property (nonatomic,strong)UILabel *jizhun2;
@property (nonatomic,strong)UILabel *jizhun3;


@end
