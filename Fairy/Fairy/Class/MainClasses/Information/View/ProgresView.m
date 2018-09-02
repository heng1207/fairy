//
//  ProgresView.m
//  Fairy
//
//  Created by 张恒 on 2018/9/2.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "ProgresView.h"

@interface ProgresView ()
@property(nonatomic,strong)UIImageView *progressIM;
@property(nonatomic,strong)UIImageView *logoIM;


@end

@implementation ProgresView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    
    UIView *progresBgView =[[UIView alloc]initWithFrame:CGRectMake(0, 2.5, 80, 10)];
    [self addSubview:progresBgView];
    progresBgView.backgroundColor =[UIColor grayColor];
    progresBgView.layer.cornerRadius = 5;
    progresBgView.layer.masksToBounds = YES;
    
    UIImage *progressImage = [UIImage imageNamed:@"icon_hot_bar_bg"];
    //不让图片拉伸变形
    CGFloat top = 0; // 顶端盖高度
    CGFloat bottom = 0 ; // 底端盖高度
    CGFloat left = 0; // 左端盖宽度
    CGFloat right = 0; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    progressImage = [progressImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    UIImageView *progressIM = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2.5, self.frame.size.width*0.7, 10)];
    self.progressIM = progressIM;
    progressIM.image =progressImage;
    [self addSubview:progressIM];
    
    
    
    UIImageView *logoIM = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*0.7-7.5, 0, 15, 15)];
    self.logoIM = logoIM;
    logoIM.image = [UIImage imageNamed:@"icon_hot_bar_hot"];
    [self addSubview:logoIM];

    
    
}

-(void)setProgress:(float)progress{
    _progress = progress;
    self.progressIM.frame = CGRectMake(0, 2.5, self.frame.size.width*progress, 10);
    self.logoIM.frame = CGRectMake(self.frame.size.width*progress-7.5, 0, 15, 15);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
