//
//  PriceDataBottomCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDataBottomCell.h"
#import "FL_Button.h"
@implementation PriceDataBottomCell
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
    [titBtn setTitle:@"交易所占比例" forState:UIControlStateNormal];;
    [self.contentView addSubview:titBtn];
    
    [titBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(14);
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(22));
        make.width.mas_equalTo(kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(13));
    }];

    
    
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
