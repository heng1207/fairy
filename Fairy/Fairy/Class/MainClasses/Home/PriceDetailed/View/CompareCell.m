//
//  CompareCell.m
//  Fairy
//
//  Created by 张恒 on 2018/8/25.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "CompareCell.h"
@interface CompareCell()
@property (weak, nonatomic) IBOutlet UIButton *trendBtn;
@property (weak, nonatomic) IBOutlet UIButton *platformBtn;


@end


@implementation CompareCell
- (IBAction)trendClick:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellTrendClick)]) {
        [_delegate cellTrendClick];
    }
}
- (IBAction)platformClick:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(cellPlatformClick)]) {
        [_delegate cellPlatformClick];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.trendBtn.layer.cornerRadius = 3;
    self.trendBtn.layer.masksToBounds = YES;
    
    self.platformBtn.layer.cornerRadius = 3;
    self.platformBtn.layer.masksToBounds = YES;
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
