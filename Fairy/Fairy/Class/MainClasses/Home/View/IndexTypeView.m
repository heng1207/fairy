//
//  IndexTypeView.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/8.
//  Copyright © 2018年 . All rights reserved.
//

#import "IndexTypeView.h"

@interface IndexTypeView()
@property(nonatomic,strong)UILabel *historyLab;
@property(nonatomic,strong)UIButton *btcBtn;
@property(nonatomic,strong)UIButton *bchBtn;
@property(nonatomic,strong)UIButton *ethBtn;


@end


@implementation IndexTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    //历史价格:
    UILabel *historyLab =[UILabel new];
    [self addSubview:historyLab];
    historyLab.text = @"历史价格：";
    historyLab.font = [UIFont systemFontOfSize:10];
    CGSize historySize = [historyLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    historyLab.frame =CGRectMake(12, 5, historySize.width, 10);
    
    //btc
    UIButton *btcBtn =[UIButton new];
    self.btcBtn = btcBtn;
    btcBtn.frame =CGRectMake(CGRectGetMaxX(historyLab.frame)+7, 5, 22, 10);
    [self addSubview:btcBtn];
    btcBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    btcBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [btcBtn setTitle:@"btc" forState:UIControlStateNormal];
    [btcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btcBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btcBtn.selected =YES;
    [btcBtn addTarget:self action:@selector(btcClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //bch
    UIButton *bchBtn =[UIButton new];
    self.bchBtn = bchBtn;
    bchBtn.frame =CGRectMake(CGRectGetMaxX(btcBtn.frame)+7, 5, 22, 10);
    [self addSubview:bchBtn];
    bchBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    bchBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [bchBtn setTitle:@"bch" forState:UIControlStateNormal];
    [bchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bchBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    bchBtn.selected =NO;
    [bchBtn addTarget:self action:@selector(bchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //eth
    UIButton *ethBtn =[UIButton new];
    self.ethBtn = ethBtn;
    ethBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    ethBtn.frame =CGRectMake(CGRectGetMaxX(bchBtn.frame)+7, 5, 30, 10);
    [self addSubview:ethBtn];
    ethBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    [ethBtn setTitle:@"eth" forState:UIControlStateNormal];
    [ethBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ethBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    ethBtn.selected =NO;
    [ethBtn addTarget:self action:@selector(ethClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)btcClick:(UIButton*)btn{
    if (btn.selected) {
        return;
    }
    else{
        btn.selected = YES;
        _bchBtn.selected = NO;
        _ethBtn.selected = NO;
        
        NSMutableDictionary *dict =[NSMutableDictionary dictionary];
        dict[@"selectType"] = @"btc";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"indexTypeViewTypeSelect" object:dict];
        
    }
}
-(void)bchClick:(UIButton*)btn{
    if (btn.selected) {
        return;
    }
    else{
        btn.selected = YES;
        _btcBtn.selected = NO;
        _ethBtn.selected = NO;
        
        NSMutableDictionary *dict =[NSMutableDictionary dictionary];
        dict[@"selectType"] = @"bch";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"indexTypeViewTypeSelect" object:dict];
        
    }
}
-(void)ethClick:(UIButton*)btn{
    if (btn.selected) {
        return;
    }
    else{
        btn.selected = YES;
        _btcBtn.selected = NO;
        _bchBtn.selected = NO;
        
        NSMutableDictionary *dict =[NSMutableDictionary dictionary];
        dict[@"selectType"] = @"eth";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"indexTypeViewTypeSelect" object:dict];
        
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
