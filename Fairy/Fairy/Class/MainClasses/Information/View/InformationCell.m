//
//  InformationCell.m
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "InformationCell.h"

@interface InformationCell()
@property (weak, nonatomic) IBOutlet UIImageView *newsIM;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *liuYanLab;
@property (weak, nonatomic) IBOutlet UILabel *seeLab;


@end


@implementation InformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentLab.textColor = [UIColor colorWithHex:@"#000000"];
    self.contentLab.font = AdaptedFontSize(36);
    self.timeLab.textColor = [UIColor colorWithHex:@"#929292"];
    self.timeLab.font = AdaptedFontSize(31);
    self.liuYanLab.textColor = [UIColor colorWithHex:@"#929292"];
    self.liuYanLab.font = AdaptedFontSize(24);
    self.seeLab.textColor = [UIColor colorWithHex:@"#929292"];
    self.seeLab.font = AdaptedFontSize(24);
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
