//
//  SuperFastBottomCell.h
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperFastBottomCell : UITableViewCell

@property (nonatomic ,strong)UILabel *describeLab;
@property (nonatomic ,strong)UILabel *dateLab;
@property (nonatomic ,strong)UILabel *btcLab;
@property (nonatomic ,strong)UILabel *closeLab;
@property (nonatomic ,strong)UILabel *descriptionLab;
@property (nonatomic ,strong)UIImageView *describeIM;
@property (nonatomic ,copy)NSString*coinName;

-(void)ValueForDic:(NSMutableDictionary *)dic;

@end
