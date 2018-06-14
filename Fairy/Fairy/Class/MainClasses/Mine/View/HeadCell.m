//
//  HeadCell.m
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "HeadCell.h"
@interface HeadCell()
@property (weak, nonatomic) IBOutlet UIImageView *headIM;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end
@implementation HeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
