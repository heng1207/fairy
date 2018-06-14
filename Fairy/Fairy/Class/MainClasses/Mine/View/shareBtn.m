//
//  shareBtn.m
//  zhcxuser
//
//  Created by 恒 on 2018/1/4.
//  Copyright © 2018年 orilme. All rights reserved.
//

#import "shareBtn.h"

@implementation shareBtn 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        self.photoIM = [UIImageView new];
        [self addSubview:self.photoIM];
        [self.photoIM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(AdaptedWidth(108));
            make.height.mas_equalTo(AdaptedWidth(108));
        }];
        
        
        self.littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, AdaptedHeight(40))];
        self.littleLabel.font = AdaptedFontSize(30);
        self.littleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.littleLabel];
        [self.littleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.photoIM.mas_bottom).mas_offset(AdaptedHeight(10));
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(AdaptedWidth(40));
        }];
  
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
