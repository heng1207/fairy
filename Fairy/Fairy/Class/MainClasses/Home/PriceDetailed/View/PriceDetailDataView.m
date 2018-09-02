//
//  PriceDetailDataView.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/29.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDetailDataView.h"
#import "PriceDataTopCell.h"
#import "PriceDataMiddleCell.h"
#import "PriceDataBottomCell.h"
#import "PriceDataBottomListCell.h"
@interface PriceDetailDataView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *datePit;
@property (nonatomic,strong)NSMutableArray *dataList;

@end
@implementation PriceDetailDataView
-(NSMutableArray *)datePit{
    if(!_datePit){
        _datePit = [NSMutableArray array];
    }
    return _datePit;
    
}
-(NSMutableArray *)dataList{
    if(!_dataList){
        _dataList = [NSMutableArray array];
    }
    return _dataList;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        [self addSubview:self.tableView];
        [self GetPitData];
        [self GetListData];

    }
    return self;
}

-(void)GetPitData{
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"token"]  = userModel.token;
    
    NSString *str = [NSString stringWithFormat:@"%@?token=%@",SelectPie,dict[@"token"]];
    NSDictionary *dic = @{@"coin":[kUserDefaults objectForKey:KchoseCoin]};

    [NetworkManage Get:str andParams:dic success:^(id responseObject) {
        
        NSLog(@"pit:%@",responseObject);
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);

    }];
    
    
}
-(void)GetListData{
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"token"]  = userModel.token;
    NSString *str = [NSString stringWithFormat:@"%@?token=%@",SelectNowList,dict[@"token"]];
    NSDictionary *dic = @{@"coin":@"BTC"};
    

    [NetworkManage Get:str andParams:dic success:^(id responseObject) {
        
        NSLog(@"list :%@",responseObject);
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);

    }];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 1;
    }else{
        return 50;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kScreenValue(125);
    }else if (indexPath.section == 1)
    {
        return kScreenValue(165);
    }else{
        if (indexPath.section == 2 && indexPath.row == 0) {
            return kScreenValue(40);
        }else{
            return kScreenValue(24);
            
        }
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PriceDataTopCell * TopCell = [tableView dequeueReusableCellWithIdentifier:@"PriceDataTopCell"];
    PriceDataMiddleCell * MiddleCell = [tableView dequeueReusableCellWithIdentifier:@"PriceDataMiddleCell"];
    PriceDataBottomCell * BottomCell = [tableView dequeueReusableCellWithIdentifier:@"PriceDataBottomCell"];
    
    PriceDataBottomListCell * BottomListCell = [tableView dequeueReusableCellWithIdentifier:@"PriceDataBottomListCell"];
    
    TopCell.selectionStyle = UITableViewCellSelectionStyleNone;
    MiddleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    BottomCell.selectionStyle = UITableViewCellSelectionStyleNone;
    BottomListCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section == 0) {
        return TopCell;
    }else if (indexPath.section == 1)
    {
        return MiddleCell;
    }else{
        if (indexPath.section == 2 && indexPath.row == 0) {
            return BottomCell;
        }else{
            BottomListCell.one.text = @"排行";
            BottomListCell.two.text = @"交易所";
            BottomListCell.three.text = @"交易对";
            BottomListCell.four.text = @"成交量";
            BottomListCell.five.text = @"占比";
            return BottomListCell;
        }
        
        
    }
    
}





-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[PriceDataTopCell class] forCellReuseIdentifier:@"PriceDataTopCell"];
        [_tableView registerClass:[PriceDataMiddleCell class] forCellReuseIdentifier:@"PriceDataMiddleCell"];
        [_tableView registerClass:[PriceDataBottomCell class] forCellReuseIdentifier:@"PriceDataBottomCell"];
        [_tableView registerClass:[PriceDataBottomListCell class] forCellReuseIdentifier:@"PriceDataBottomListCell"];
        
    }
    return _tableView;
}

@end
