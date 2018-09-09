//
//  DepthBtnCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/26.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "DepthBtnCell.h"
@implementation DepthBtnCell


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    NSArray *arrImage = @[@"Hourglass",@"Radio",@"Bag"];
    NSArray *titleImage = @[@"热搜榜",@"实时热点",@"金币助手"];

   
    for (int i=0; i<3; i++) {
        FL_Button *btnn = [[FL_Button alloc]initWithAlignmentStatus:FLAlignmentStatusTop];
        [btnn setImage:[UIImage imageNamed:arrImage[i]] forState:UIControlStateNormal];
        btnn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [btnn setTintColor:[UIColor grayColor]];
        btnn.alpha=0.4;
        btnn.titleLabel.font = [UIFont systemFontOfSize:kScreenValue(14)];
        [btnn setTitle:titleImage[i] forState:UIControlStateNormal];
        [btnn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnn.frame = CGRectMake(i * SCREEN_WIDTH /4,  0  ,SCREEN_WIDTH/4, SCREEN_WIDTH/4);

        
//        if (i== 0) {
//            btnn.center = CGPointMake( SCREEN_WIDTH /8  , SCREEN_WIDTH/8);
//
//        }else if (i == 1) {
//            btnn.center = CGPointMake( SCREEN_WIDTH * 3/8  , SCREEN_WIDTH/8);
//
//        }
//        else{
//            btnn.center = CGPointMake( SCREEN_WIDTH * 5/8  , SCREEN_WIDTH/8);
//        }
//
        [self.contentView addSubview:btnn];

    }
    
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
