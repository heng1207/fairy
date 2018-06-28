//
//  IndexCellCell.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "IndexCellCell.h"
@interface IndexCellCell()
@property (weak, nonatomic) IBOutlet UILabel *biHangQingLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *RMBLab;
@property (weak, nonatomic) IBOutlet UILabel *USLab;


@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UILabel *RMBLab2;
@property (weak, nonatomic) IBOutlet UILabel *USLab2;

@property (weak, nonatomic) IBOutlet UILabel *nameLab3;
@property (weak, nonatomic) IBOutlet UILabel *RMBLab3;
@property (weak, nonatomic) IBOutlet UILabel *USLab3;



@end

@implementation IndexCellCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.biHangQingLab.textColor = [UIColor colorWithHex:@"#000000"];
    self.biHangQingLab.font = AdaptedFontSize(35);
    
    self.nameLab.textColor = [UIColor colorWithHex:@"#000000"];
    self.nameLab.font = AdaptedFontSize(23);

    self.RMBLab.textColor = [UIColor colorWithHex:@"#f63842"];
    self.RMBLab.font = AdaptedFontSize(45);
    
    self.USLab.textColor = [UIColor colorWithHex:@"#000000"];
    self.USLab.font = AdaptedFontSize(18);
    
    
    self.nameLab2.textColor = [UIColor colorWithHex:@"#000000"];
    self.nameLab2.font = AdaptedFontSize(23);
    
    self.RMBLab2.textColor = [UIColor colorWithHex:@"#f63842"];
    self.RMBLab2.font = AdaptedFontSize(45);
    
    self.USLab2.textColor = [UIColor colorWithHex:@"#000000"];
    self.USLab2.font = AdaptedFontSize(18);
    
    self.nameLab3.textColor = [UIColor colorWithHex:@"#000000"];
    self.nameLab3.font = AdaptedFontSize(23);
    
    self.RMBLab3.textColor = [UIColor colorWithHex:@"#f63842"];
    self.RMBLab3.font = AdaptedFontSize(45);
    
    self.USLab3.textColor = [UIColor colorWithHex:@"#000000"];
    self.USLab3.font = AdaptedFontSize(18);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
