//
//  IndexTypeCell.m
//  Fairy
//
//  Created by 张恒 on 2018/9/1.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "IndexTypeCell.h"

@interface IndexTypeCell ()

@property(nonatomic,strong)UIButton *btcBtn;
@property(nonatomic,strong)UIButton *bchBtn;
@property(nonatomic,strong)UIButton *ethBtn;

@end

@implementation IndexTypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubView];
        
    }
    return self;
}

-(void)creatSubView{
    
    
    
    //bch
    UIView *bchView=[[UIView alloc]init];
    bchView.backgroundColor =[UIColor greenColor];
    [self.contentView addSubview:bchView];
    bchView.frame = CGRectMake(15, 15, 10, 4);
    
    UIButton *bchBtn =[UIButton new];
    self.bchBtn = bchBtn;
    bchBtn.frame =CGRectMake(CGRectGetMaxX(bchView.frame)+3, bchView.centerY-7.5, 25, 15);
    [self.contentView addSubview:bchBtn];
    bchBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    bchBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [bchBtn setTitle:@"BCH" forState:UIControlStateNormal];
    [bchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bchBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    bchBtn.selected =YES;
    [bchBtn addTarget:self action:@selector(bchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    //btc
    UIView *btcView=[[UIView alloc]init];
    btcView.backgroundColor =[UIColor blueColor];
    [self.contentView addSubview:btcView];
    btcView.frame = CGRectMake(CGRectGetMaxX(bchBtn.frame)+10, 15, 10, 4);
    
    UIButton *btcBtn =[UIButton new];
    self.btcBtn = btcBtn;
    btcBtn.frame =CGRectMake(CGRectGetMaxX(btcView.frame)+3, btcView.centerY-7.5, 25, 15);
    [self.contentView addSubview:btcBtn];
    btcBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    btcBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [btcBtn setTitle:@"BTC" forState:UIControlStateNormal];
    [btcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btcBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btcBtn.selected =NO;
    [btcBtn addTarget:self action:@selector(btcClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //eth
    UIView *ethView=[[UIView alloc]init];
    ethView.backgroundColor =[UIColor redColor];
    [self.contentView addSubview:ethView];
    ethView.frame = CGRectMake(CGRectGetMaxX(btcBtn.frame)+10, 15, 10, 4);
    
    UIButton *ethBtn =[UIButton new];
    self.ethBtn = ethBtn;
    ethBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    ethBtn.frame =CGRectMake(CGRectGetMaxX(ethView.frame)+3, ethView.centerY-7.5, 25, 15);
    [self.contentView addSubview:ethBtn];
    ethBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
    [ethBtn setTitle:@"ETH" forState:UIControlStateNormal];
    [ethBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ethBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    ethBtn.selected =NO;
    [ethBtn addTarget:self action:@selector(ethClick:) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
    
    

    
//    //eth
//    UIButton *ethBtn =[UIButton new];
//    self.ethBtn = ethBtn;
//    ethBtn.titleLabel.font = [UIFont systemFontOfSize:10];
//    ethBtn.frame =CGRectMake(SCREEN_WIDTH-15-25, 10, 25, 15);
//    [self.contentView addSubview:ethBtn];
//    ethBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
//    [ethBtn setTitle:@"ETH" forState:UIControlStateNormal];
//    [ethBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [ethBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//    ethBtn.selected =NO;
//    [ethBtn addTarget:self action:@selector(ethClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIView *ethView=[[UIView alloc]init];
//    ethView.backgroundColor =[UIColor redColor];
//    [self.contentView addSubview:ethView];
//    ethView.frame = CGRectMake(CGRectGetMinX(ethBtn.frame)-3-10, ethBtn.centerY-2, 10, 4);
//
//
//
//
//    //btc
//    UIButton *btcBtn =[UIButton new];
//    self.btcBtn = btcBtn;
//    btcBtn.frame =CGRectMake(CGRectGetMinX(ethView.frame)-10-25, 10, 25, 15);
//    [self.contentView addSubview:btcBtn];
//    btcBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
//    btcBtn.titleLabel.font = [UIFont systemFontOfSize:10];
//    [btcBtn setTitle:@"BTC" forState:UIControlStateNormal];
//    [btcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btcBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    btcBtn.selected =NO;
//    [btcBtn addTarget:self action:@selector(btcClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIView *btcView=[[UIView alloc]init];
//    btcView.backgroundColor =[UIColor blueColor];
//    [self.contentView addSubview:btcView];
//    btcView.frame = CGRectMake(CGRectGetMinX(btcBtn.frame)-3-10, btcBtn.centerY-2, 10, 4);
//
//
//
//    //bch
//    UIButton *bchBtn =[UIButton new];
//    self.bchBtn = bchBtn;
//    bchBtn.frame =CGRectMake(CGRectGetMinX(btcView.frame)-10-25, 10, 25, 15);
//    [self.contentView addSubview:bchBtn];
//    bchBtn.backgroundColor =  [UIColor colorWithHex:@"#e6e6e7"];
//    bchBtn.titleLabel.font = [UIFont systemFontOfSize:10];
//    [bchBtn setTitle:@"BCH" forState:UIControlStateNormal];
//    [bchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [bchBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
//    bchBtn.selected =YES;
//    [bchBtn addTarget:self action:@selector(bchClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIView *bchView=[[UIView alloc]init];
//    bchView.backgroundColor =[UIColor greenColor];
//    [self.contentView addSubview:bchView];
//    bchView.frame = CGRectMake(CGRectGetMinX(bchBtn.frame)-3-10, bchBtn.centerY-2, 10, 4);
    
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
        dict[@"selectType"] = @"BTC";
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
        dict[@"selectType"] = @"BCH";
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
        dict[@"selectType"] = @"ETH";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"indexTypeViewTypeSelect" object:dict];
        
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
