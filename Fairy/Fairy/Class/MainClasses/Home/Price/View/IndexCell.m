//
//  IndexCell.m
//  Fairy
//
//  Created by 张恒 on 2018/8/26.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "IndexCell.h"

@interface IndexCell()
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *gloadLab1;
@property (weak, nonatomic) IBOutlet UILabel *RMBLab1;
@property (weak, nonatomic) IBOutlet UILabel *USBLab1;

@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UILabel *gloadLab2;
@property (weak, nonatomic) IBOutlet UILabel *RMBLab2;
@property (weak, nonatomic) IBOutlet UILabel *USBLab2;

@property (weak, nonatomic) IBOutlet UILabel *nameLab3;
@property (weak, nonatomic) IBOutlet UILabel *gloadLab3;
@property (weak, nonatomic) IBOutlet UILabel *RMBLab3;
@property (weak, nonatomic) IBOutlet UILabel *USBLab3;


@end

@implementation IndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor =[UIColor colorWithHex:@"#d8d8d8"];
    
    self.nameLab1.textColor = [UIColor colorWithHex:@"#ffffff"];
    self.nameLab1.font = AdaptedFontSize(24);
    self.gloadLab1.textColor = [UIColor colorWithHex:@"#92dcff"];
    self.gloadLab1.font = AdaptedFontSize(22);
    self.RMBLab1.textColor = [UIColor colorWithHex:@"#ffffff"];
    self.RMBLab1.font = AdaptedFontSize(26);
    self.USBLab1.textColor = [UIColor colorWithHex:@"#92dcff"];
    self.USBLab1.font = AdaptedFontSize(22);
    
    
    
    self.nameLab2.textColor = [UIColor colorWithHex:@"#ffffff"];
    self.nameLab2.font = AdaptedFontSize(24);
    self.gloadLab2.textColor = [UIColor colorWithHex:@"#92dcff"];
    self.gloadLab2.font = AdaptedFontSize(22);
    self.RMBLab2.textColor = [UIColor colorWithHex:@"#ffffff"];
    self.RMBLab2.font = AdaptedFontSize(26);
    self.USBLab2.textColor = [UIColor colorWithHex:@"#92dcff"];
    self.USBLab2.font = AdaptedFontSize(22);
    
    
    self.nameLab3.textColor = [UIColor colorWithHex:@"#ffffff"];
    self.nameLab3.font = AdaptedFontSize(24);
    self.gloadLab3.textColor = [UIColor colorWithHex:@"#92dcff"];
    self.gloadLab3.font = AdaptedFontSize(22);
    self.RMBLab3.textColor = [UIColor colorWithHex:@"#ffffff"];
    self.RMBLab3.font = AdaptedFontSize(26);
    self.USBLab3.textColor = [UIColor colorWithHex:@"#92dcff"];
    self.USBLab3.font = AdaptedFontSize(22);
    
    
    UITapGestureRecognizer *firstTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstTapClick:)];
    [self.firstView addGestureRecognizer:firstTapGesture];
    UITapGestureRecognizer *secondTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondTapClick:)];
    [self.secondView addGestureRecognizer:secondTapGesture];
    UITapGestureRecognizer *thirdTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(thirdTapClick:)];
    [self.thirdView
     addGestureRecognizer:thirdTapGesture];
    
    
    // Initialization code
}

-(void)setGlobalIndexData:(NSArray *)globalIndexData{
    _globalIndexData = globalIndexData;
    
    if (globalIndexData.count==0) {
        return;
    }
    
    self.nameLab1.text = globalIndexData[0][@"platformCnName"];
    self.RMBLab1.text = globalIndexData[0][@"rmbPrice"];
    self.USBLab1.text = globalIndexData[0][@"lastPrice"];
    
    self.nameLab2.text = globalIndexData[1][@"platformCnName"];
    self.RMBLab2.text = globalIndexData[1][@"rmbPrice"];
    self.USBLab2.text = globalIndexData[1][@"lastPrice"];
    
    self.nameLab3.text = globalIndexData[2][@"platformCnName"];
    self.RMBLab3.text = globalIndexData[2][@"rmbPrice"];
    self.USBLab3.text = globalIndexData[2][@"lastPrice"];
    
    
}


-(void)firstTapClick:(UIGestureRecognizer*)tap{
    
}
-(void)secondTapClick:(UIGestureRecognizer*)tap{
    
}
-(void)thirdTapClick:(UIGestureRecognizer*)tap{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
