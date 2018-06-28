//
//  BaseTypeView.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "BaseTypeView.h"


@interface BaseTypeView()
@property(nonatomic,strong)UIButton *btnReply;
@property(nonatomic,strong)UIButton *btnDianLiang;
@property(nonatomic,strong)UIButton *btnZhuanFa;
@end
@implementation BaseTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    
    /// 创建分割线
    UIView *viewDivider = [[UIView alloc] init];
    viewDivider.backgroundColor =[UIColor grayColor];
    viewDivider.alpha = 0.6;
    viewDivider.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    [self addSubview:viewDivider];
    
    UIView *viewDivider1 = [[UIView alloc] init];
    viewDivider1.backgroundColor = [UIColor grayColor];
    viewDivider1.alpha = 0.6;
    viewDivider1.frame = CGRectMake(self.frame.size.width/ 3.0, 0, 0.5, self.frame.size.height);
    [self addSubview:viewDivider1];
    
    UIView *viewDivider2 = [[UIView alloc] init];
    viewDivider2.backgroundColor = [UIColor grayColor];
    viewDivider2.alpha = 0.6;
    viewDivider2.frame = CGRectMake(self.frame.size.width/ 3.0 * 2, 0, 0.5, self.frame.size.height);
    [self addSubview:viewDivider2];
    
    UIView *viewDividerBom = [[UIView alloc] init];
    viewDividerBom.backgroundColor = [UIColor grayColor];
    viewDividerBom.alpha = 0.6;
    viewDividerBom.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
    [self addSubview:viewDividerBom];
    
    
    CGFloat fltBtnW = self.frame.size.width / 3;
    CGFloat fltBtnY = CGRectGetMaxY(viewDivider.frame);
    CGFloat fltBtnH = self.frame.size.height - 2*fltBtnY;
    
    // 分析
    UIButton *btnReply = [[UIButton alloc] init];
    [btnReply setTitle:@"分析" forState:UIControlStateNormal];
    [btnReply setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnReply setTitleColor:[UIColor colorWithHex:@"#0e5f9f"] forState:UIControlStateSelected];
    btnReply.titleLabel.font = AdaptedFontSize(34);
    [btnReply setImage:[UIImage imageNamed:@"icon_fenxihui_tab"] forState:UIControlStateNormal];
    [btnReply setImage:[UIImage imageNamed:@"icon_fenxi_tab"] forState:UIControlStateSelected];
    btnReply.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [btnReply addTarget:self action:@selector(btnReplyClick:) forControlEvents:UIControlEventTouchUpInside];
    btnReply.frame = CGRectMake(0, fltBtnY, fltBtnW, fltBtnH);
    _btnReply = btnReply;
    btnReply.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    btnReply.selected = YES;
    [self addSubview:btnReply];
 
    
    
    // 预测
    UIButton *btnDianLiang = [[UIButton alloc] init];
     [btnDianLiang setTitle:@"预测" forState:UIControlStateNormal];
    [btnDianLiang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDianLiang setTitleColor:[UIColor colorWithHex:@"#0e5f9f"] forState:UIControlStateSelected];
    btnDianLiang.titleLabel.font = AdaptedFontSize(34);
    [btnDianLiang setImage:[UIImage imageNamed:@"icon_yucehui_tab"] forState:UIControlStateNormal];
    [btnDianLiang setImage:[UIImage imageNamed:@"icon_yuce_tab"] forState:UIControlStateSelected];
    btnDianLiang.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [btnDianLiang addTarget:self action:@selector(btnDianLiangClick:) forControlEvents:UIControlEventTouchUpInside];
    btnDianLiang.frame = CGRectMake(fltBtnW, fltBtnY, fltBtnW, fltBtnH);
    btnDianLiang.selected = NO;
    _btnDianLiang = btnDianLiang;
    //button标题的偏移量，这个偏移量是相对于图片的
    btnDianLiang.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    [self addSubview:btnDianLiang];
    
    // 预警
    UIButton *btnZhuanFa = [[UIButton alloc] init];
    [btnZhuanFa setTitle:@"预警" forState:UIControlStateNormal];
    [btnZhuanFa setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnZhuanFa setTitleColor:[UIColor colorWithHex:@"#0e5f9f"] forState:UIControlStateSelected];
    btnZhuanFa.titleLabel.font = AdaptedFontSize(34);
    [btnZhuanFa setImage:[UIImage imageNamed:@"icon_yujinghui_tab"] forState:UIControlStateNormal];
    [btnZhuanFa setImage:[UIImage imageNamed:@"icon_yujing_tab"] forState:UIControlStateSelected];
    btnZhuanFa.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [btnZhuanFa addTarget:self action:@selector(btnZhuanFaClick:) forControlEvents:UIControlEventTouchUpInside];
    btnZhuanFa.frame = CGRectMake(fltBtnW * 2, fltBtnY, fltBtnW, fltBtnH);
    btnZhuanFa.selected = NO;
    _btnZhuanFa = btnZhuanFa;
    btnZhuanFa.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    [self addSubview:btnZhuanFa];
    
}


-(void)btnReplyClick:(UIButton*)btn{
    if(!btn.selected){
        btn.selected = YES;
        self.btnDianLiang.selected = NO;
        self.btnZhuanFa.selected = NO;
        
        if ([_delegate respondsToSelector:@selector(gmdOpFenXiClick)])
        {
            [_delegate gmdOpFenXiClick];
        }
        
    }

}
-(void)btnDianLiangClick:(UIButton*)btn{
    if(!btn.selected){
        btn.selected = YES;
        self.btnReply.selected = NO;
        self.btnZhuanFa.selected = NO;
        if ([_delegate respondsToSelector:@selector(gmdOpYuCeClick)])
        {
            [_delegate gmdOpYuCeClick];
        }
        
    }
}

-(void)btnZhuanFaClick:(UIButton*)btn{
    if(!btn.selected){
        btn.selected = YES;
        self.btnReply.selected = NO;
        self.btnDianLiang.selected = NO;
        if ([_delegate respondsToSelector:@selector(gmdOpYuJingClick)])
        {
            [_delegate gmdOpYuJingClick];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
