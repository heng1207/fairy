//
//  HeadCell.m
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 . All rights reserved.
//

#import "HeadCell.h"
@interface HeadCell()
@property (weak, nonatomic) IBOutlet UIImageView *headIM;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *explainLab;

@end
@implementation HeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLab.font = AdaptedFontSize(27);
    self.explainLab.font = AdaptedFontSize(27);
    self.headIM.userInteractionEnabled = YES;
    self.nameLab.userInteractionEnabled = YES;
    self.explainLab.userInteractionEnabled = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
