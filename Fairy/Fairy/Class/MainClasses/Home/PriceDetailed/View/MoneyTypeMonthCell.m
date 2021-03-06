//
//  MoneyTypeMonthCell.m
//  Fairy
//
//  Created by 张恒 on 2018/9/1.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "MoneyTypeMonthCell.h"

@interface MoneyTypeMonthCell ()

@property(nonatomic,strong)UIButton *RMBbtn;
@property(nonatomic,strong)UIButton *USAbtn;

@property(nonatomic,strong)UIButton *marchBtn;
@property(nonatomic,strong)UIButton *juneBtn;
@property(nonatomic,strong)UIButton *yearBtn;

@end


@implementation MoneyTypeMonthCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 17)];
    self.titleLab = titleLab;
    titleLab.textAlignment = NSTextAlignmentCenter;
//    titleLab.text =@"某某某折线图";
    titleLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titleLab];
    
    
    
    UIView *priceView=[[UIView alloc]initWithFrame:CGRectMake(20, 40, 60, 22)];
    priceView.layer.cornerRadius = 11;
    priceView.layer.masksToBounds = YES;
    priceView.layer.borderColor = [UIColor grayColor].CGColor;
    priceView.layer.borderWidth =1;
    [self.contentView addSubview:priceView];
    
    UIButton *RMBbtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    self.RMBbtn = RMBbtn;
    [priceView addSubview:RMBbtn];
    [RMBbtn setImage:[UIImage imageNamed:@"icon_switch_money_￥"] forState:UIControlStateNormal];
    [RMBbtn setImage:[UIImage imageNamed:@"icon_switch_money_￥_select"] forState:UIControlStateSelected];
    RMBbtn.selected = NO;
    [RMBbtn addTarget:self action:@selector(rmbBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *USAbtn =[[UIButton alloc]initWithFrame:CGRectMake(30, 0, 30, 22)];
    self.USAbtn = USAbtn;
    [priceView addSubview:USAbtn];
    [USAbtn setImage:[UIImage imageNamed:@"icon_switch_money_$"] forState:UIControlStateNormal];
    [USAbtn setImage:[UIImage imageNamed:@"icon_switch_money_$_select"] forState:UIControlStateSelected];
    USAbtn.selected = YES;
    [USAbtn addTarget:self action:@selector(usaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    ///时间///
    UIView *timeView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-120, 40, 120, 22)];
    timeView.layer.cornerRadius = 11;
    timeView.layer.masksToBounds = YES;
    timeView.layer.borderColor = [UIColor grayColor].CGColor;
    timeView.layer.borderWidth =1;
    [self.contentView addSubview:timeView];
    
    
    UIButton *marchBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 22)];
    self.marchBtn = marchBtn;
    [timeView addSubview:marchBtn];
    [marchBtn setImage:[UIImage imageNamed:@"icon_switch_time_march"] forState:UIControlStateNormal];
    [marchBtn setImage:[UIImage imageNamed:@"icon_switch_time_march_select"] forState:UIControlStateSelected];
    marchBtn.selected = YES;
    [marchBtn addTarget:self action:@selector(marchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *juneBtn =[[UIButton alloc]initWithFrame:CGRectMake(40, 0, 40, 22)];
    self.juneBtn = juneBtn;
    [timeView addSubview:juneBtn];
    [juneBtn setImage:[UIImage imageNamed:@"icon_switch_time_june"] forState:UIControlStateNormal];
    [juneBtn setImage:[UIImage imageNamed:@"icon_switch_time_june_select"] forState:UIControlStateSelected];
    juneBtn.selected = NO;
    [juneBtn addTarget:self action:@selector(juneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *yearBtn =[[UIButton alloc]initWithFrame:CGRectMake(80, 0, 40, 22)];
    self.yearBtn = yearBtn;
    [timeView addSubview:yearBtn];
    [yearBtn setImage:[UIImage imageNamed:@"icon_switch_time_year"] forState:UIControlStateNormal];
    [yearBtn setImage:[UIImage imageNamed:@"icon_switch_time_year_select"] forState:UIControlStateSelected];
    yearBtn.selected = NO;
    [yearBtn addTarget:self action:@selector(yearBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}



-(void)rmbBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.USAbtn.selected = NO;
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"moneyType"] = @"1";
    if (self.marchBtn.selected) {
        dict[@"month"] = @"3";
    }
    else if (self.juneBtn.selected){
        dict[@"month"] = @"6";
    }
    else{
        dict[@"month"] = @"12";
    }
    dict[@"tag"] = [NSString stringWithFormat:@"%ld",(long)self.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SegmentViewMoneyTypeAndMonthSelect" object:dict];
    
    NSString *month;
    if (self.marchBtn.selected) {
        month = @"3";
    }
    else if (self.juneBtn.selected){
        month  = @"6";
    }
    else{
        month  = @"12";
    }
    if (_delegate && [_delegate respondsToSelector:@selector(cellMoneyTypeMonthSelectMoneyType:Month:Cell:)]) {
        [_delegate cellMoneyTypeMonthSelectMoneyType:@"1" Month:month Cell:self];
    }
}
-(void)usaBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.RMBbtn.selected = NO;
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"moneyType"] = @"2";
    if (self.marchBtn.selected) {
        dict[@"month"] = @"3";
    }
    else if (self.juneBtn.selected){
        dict[@"month"] = @"6";
    }
    else{
        dict[@"month"] = @"12";
    }
    dict[@"tag"] = [NSString stringWithFormat:@"%ld",(long)self.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SegmentViewMoneyTypeAndMonthSelect" object:dict];
    
    
    NSString *month;
    if (self.marchBtn.selected) {
        month = @"3";
    }
    else if (self.juneBtn.selected){
        month  = @"6";
    }
    else{
        month  = @"12";
    }
    if (_delegate && [_delegate respondsToSelector:@selector(cellMoneyTypeMonthSelectMoneyType:Month:Cell:)]) {
        [_delegate cellMoneyTypeMonthSelectMoneyType:@"2" Month:month Cell:self];
    }
    
}

-(void)marchBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.juneBtn.selected = NO;
    self.yearBtn.selected = NO;
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"month"] = @"3";
    if (self.RMBbtn.selected) {
        dict[@"moneyType"] = @"1";
    }
    else{
        dict[@"moneyType"] = @"2";
    }
    dict[@"tag"] = [NSString stringWithFormat:@"%ld",(long)self.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SegmentViewMoneyTypeAndMonthSelect" object:dict];
    
    NSString *moneyType;
    if (self.RMBbtn.selected) {
        moneyType = @"1";
    }
    else{
        moneyType  = @"2";
    }
    if (_delegate && [_delegate respondsToSelector:@selector(cellMoneyTypeMonthSelectMoneyType:Month:Cell:)]) {
        [_delegate cellMoneyTypeMonthSelectMoneyType:moneyType Month:@"3" Cell:self];
    }
}

-(void)juneBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.marchBtn.selected = NO;
    self.yearBtn.selected = NO;
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"month"] = @"6";
    if (self.RMBbtn.selected) {
        dict[@"moneyType"] = @"1";
    }
    else{
        dict[@"moneyType"] = @"2";
    }
    dict[@"tag"] = [NSString stringWithFormat:@"%ld",(long)self.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SegmentViewMoneyTypeAndMonthSelect" object:dict];
    
    
    NSString *moneyType;
    if (self.RMBbtn.selected) {
        moneyType = @"1";
    }
    else{
        moneyType  = @"2";
    }
    if (_delegate && [_delegate respondsToSelector:@selector(cellMoneyTypeMonthSelectMoneyType:Month:Cell:)]) {
        [_delegate cellMoneyTypeMonthSelectMoneyType:moneyType Month:@"6" Cell:self];
    }
}

-(void)yearBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.marchBtn.selected = NO;
    self.juneBtn.selected = NO;
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"month"] = @"12";
    if (self.RMBbtn.selected) {
        dict[@"moneyType"] = @"1";
    }
    else{
        dict[@"moneyType"] = @"2";
    }
    dict[@"tag"] = [NSString stringWithFormat:@"%ld",(long)self.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SegmentViewMoneyTypeAndMonthSelect" object:dict];
    
    
    NSString *moneyType;
    if (self.RMBbtn.selected) {
        moneyType = @"1";
    }
    else{
        moneyType  = @"2";
    }
    if (_delegate && [_delegate respondsToSelector:@selector(cellMoneyTypeMonthSelectMoneyType:Month:Cell:)]) {
        [_delegate cellMoneyTypeMonthSelectMoneyType:moneyType Month:@"12" Cell:self];
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
