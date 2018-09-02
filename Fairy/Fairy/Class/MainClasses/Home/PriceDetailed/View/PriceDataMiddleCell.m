//
//  PriceDataMiddleCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDataMiddleCell.h"
#import "FL_Button.h"
#import "DVPieChart.h"
#import "DVFoodPieModel.h"


@interface PriceDataMiddleCell ()

@end

@implementation PriceDataMiddleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self) {
    
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        [self sutpeUI];
    }
    return self;
}
-(void)sutpeUI{
    
    FL_Button *titBtn = [[FL_Button alloc]initWithAlignmentStatus:FLAlignmentStatusRight];
    titBtn.titleLabel.font = [UIFont systemFontOfSize:kScreenValue(13)];
    [titBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [titBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titBtn setTitle:@"交易对比量(24H)" forState:UIControlStateNormal];;
    [self.contentView addSubview:titBtn];
    
    [titBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(14);
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(22));
        make.width.mas_equalTo(kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(13));
    }];
    
    
    DVPieChart *chart = [[DVPieChart alloc] init];
    
    [self.contentView addSubview:chart];
    [chart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(42);
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(22));
        make.width.mas_equalTo(kScreenWidth/2);
        make.height.mas_equalTo(kScreenValue(113));
    }];
    
    DVFoodPieModel *model1 = [[DVFoodPieModel alloc] init];
    
    model1.rate = 0.7261;
    model1.name = @"哈哈哈哈哈哈";
    model1.value = 423651.23;
    
    
    DVFoodPieModel *model2 = [[DVFoodPieModel alloc] init];
    
    model2.rate = 0.068;
    model2.name = @"哈哈哈哈哈哈";
    model2.value = 423651.23;
    
    
    DVFoodPieModel *model3 = [[DVFoodPieModel alloc] init];
    
    model3.rate = 0.068;
    model3.name = @"哈哈";
    model3.value = 423651.23;
    
    
    DVFoodPieModel *model4 = [[DVFoodPieModel alloc] init];
    
    model4.rate = 0.0594;
    model4.name = @"哈哈哈哈哈哈";
    model4.value = 423651.23;
    
    
    DVFoodPieModel *model5 = [[DVFoodPieModel alloc] init];
    
    model5.rate = 0.0393;
    model5.name = @"哈哈";
    model5.value = 423651.23;
    
    
    DVFoodPieModel *model6 = [[DVFoodPieModel alloc] init];
    
    model6.rate = 0.0391;
    model6.name = @"哈哈哈哈哈哈哈哈哈哈哈哈";
    model6.value = 423651.23;
    
    
    NSArray *dataArray = @[model1, model2, model3, model4, model5, model6];
    
    chart.dataArray = dataArray;
    
    
    [chart draw];

    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
