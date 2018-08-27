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

    
    //eth
    UIButton *ethBtn =[UIButton new];
    self.ethBtn = ethBtn;
    ethBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    ethBtn.frame =CGRectMake(SCREEN_WIDTH-15-25, 10, 25, 15);
    [self addSubview:ethBtn];
    ethBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    [ethBtn setTitle:@"ETH" forState:UIControlStateNormal];
    [ethBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ethBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    ethBtn.selected =NO;
    [ethBtn addTarget:self action:@selector(ethClick:) forControlEvents:UIControlEventTouchUpInside];

    UIView *ethView=[[UIView alloc]init];
    ethView.backgroundColor =[UIColor redColor];
    [self addSubview:ethView];
    ethView.frame = CGRectMake(CGRectGetMinX(ethBtn.frame)-3-10, ethBtn.centerY-2, 10, 4);

    
    
    
    //btc
    UIButton *btcBtn =[UIButton new];
    self.btcBtn = btcBtn;
    btcBtn.frame =CGRectMake(CGRectGetMinX(ethView.frame)-10-25, 10, 25, 15);
    [self addSubview:btcBtn];
    btcBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    btcBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [btcBtn setTitle:@"BTC" forState:UIControlStateNormal];
    [btcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btcBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btcBtn.selected =NO;
    [btcBtn addTarget:self action:@selector(btcClick:) forControlEvents:UIControlEventTouchUpInside];

    UIView *btcView=[[UIView alloc]init];
    btcView.backgroundColor =[UIColor blueColor];
    [self addSubview:btcView];
    btcView.frame = CGRectMake(CGRectGetMinX(btcBtn.frame)-3-10, btcBtn.centerY-2, 10, 4);



    //bch
    UIButton *bchBtn =[UIButton new];
    self.bchBtn = bchBtn;
    bchBtn.frame =CGRectMake(CGRectGetMinX(btcView.frame)-10-25, 10, 25, 15);
    [self addSubview:bchBtn];
    bchBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    bchBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [bchBtn setTitle:@"BCH" forState:UIControlStateNormal];
    [bchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bchBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    bchBtn.selected =NO;
    [bchBtn addTarget:self action:@selector(bchClick:) forControlEvents:UIControlEventTouchUpInside];

    UIView *bchView=[[UIView alloc]init];
    bchView.backgroundColor =[UIColor greenColor];
    [self addSubview:bchView];
    bchView.frame = CGRectMake(CGRectGetMinX(bchBtn.frame)-3-10, bchBtn.centerY-2, 10, 4);

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

-(void)setSelectType:(NSString *)selectType{
    _selectType = selectType;
    
    if ([selectType isEqualToString:@"btc"]) {
        self.btcBtn.selected = YES;
        self.bchBtn.selected = NO;
        self.ethBtn.selected = NO;
    }
    else if ([selectType isEqualToString:@"bch"]){
        self.bchBtn.selected = YES;
        self.btcBtn.selected = NO;
        self.ethBtn.selected = NO;
    }
    else{
        self.ethBtn.selected = YES;
        self.bchBtn.selected = NO;
        self.btcBtn.selected = NO;
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
