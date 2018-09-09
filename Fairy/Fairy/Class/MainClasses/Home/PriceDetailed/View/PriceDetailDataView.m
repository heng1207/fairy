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
#import "DVFoodPieModel.h"
#import "DVPieChart.h"
#import "FL_Button.h"
@interface PriceDetailDataView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary *topDic;

@property (nonatomic,strong)NSMutableArray *datePit;
@property (nonatomic,strong)NSMutableArray *dataList;

@end
@implementation PriceDetailDataView
-(NSMutableDictionary *)topDic{
    if (!_topDic) {
        _topDic = [NSMutableDictionary dictionary];
    }
    return _topDic;
}
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
        [self GetTotleData];
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
        
        if ([responseObject[@"code"]integerValue] ==200) {
            NSArray *arr = responseObject[@"data"][@"coin"];
            
            for (NSDictionary *dic in arr) {
                
                if ([dic[@"transaction"] floatValue] >0.01) {
                    [self.datePit addObject:dic];

                }


            }
            [self.tableView reloadData];
            
        }else{
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);

    }];
    
    
}
-(void)GetTotleData{
    
    
    NSString *str = [NSString stringWithFormat:@"http://47.254.69.147:8080/interface/coinMarket/getCoinmarketData"];
    NSDictionary *dic = @{@"currencyShortName":[[kUserDefaults objectForKey:KchoseCoin] lowercaseString]};
    
    [NetworkManage Get:str andParams:dic success:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue]==200) {
            NSLog(@"%@",responseObject);
            NSArray *arr = responseObject[@"data"];
            _topDic = [arr firstObject];
             [self.tableView reloadData];
        }else{
            
        }
        
        
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    
}

-(void)GetListData{
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"token"]  = userModel.token;
    NSString *str = [NSString stringWithFormat:@"%@?token=%@",SelectNowList,dict[@"token"]];
    NSDictionary *dic = @{@"coin":[kUserDefaults objectForKey:KchoseCoin]};
    

    [NetworkManage Get:str andParams:dic success:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue]==200) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                
                [self.dataList addObject:dic];
                [self.tableView reloadData];
            }
        }else{
            
        }
        
        
        
        
        
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
        return self.dataList.count+2;
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

    
    if (indexPath.section == 0) {
        PriceDataTopCell * TopCell = [tableView dequeueReusableCellWithIdentifier:@"PriceDataTopCell"];

        TopCell.totleCount.text = [NSString stringWithFormat:@"%@",self.topDic[@"market"]];
        TopCell.dealCount.text =[NSString stringWithFormat:@"%@",self.topDic[@"trading_h_24"]];
        TopCell.supplyCount.text =[NSString stringWithFormat:@"%@",self.topDic[@"supply"]];
        TopCell.MixSupplyCount.text =[NSString stringWithFormat:@"%@",self.topDic[@"circulateNum"]];
        TopCell.selectionStyle = UITableViewCellSelectionStyleNone;

        return TopCell;
    }else if (indexPath.section == 1)
    {
        PriceDataMiddleCell * MiddleCell = [tableView dequeueReusableCellWithIdentifier:@"PriceDataMiddleCell"];

        UILabel *bule = [[UILabel alloc]init];
        bule.backgroundColor = [UIColor blueColor];
        [MiddleCell.contentView addSubview:bule];

        [bule mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(MiddleCell.contentView.mas_top).offset(14);
            make.left.equalTo(MiddleCell.contentView.mas_left).offset(kScreenValue(22));
            make.width.mas_equalTo(kScreenValue(5));
            make.height.mas_equalTo(kScreenValue(13));
        }];
        UILabel *tit = [[UILabel alloc]init];
        [MiddleCell.contentView addSubview:tit];

        tit.text = @"交易对比量(24H)";
        tit.font = [UIFont systemFontOfSize:kScreenValue(13)];
        [tit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(MiddleCell.contentView.mas_top).offset(14);
            make.left.equalTo(bule.mas_right).offset(kScreenValue(10));
            make.width.mas_equalTo(kScreenWidth/3);
            make.height.mas_equalTo(kScreenValue(13));
        }];

 

        DVPieChart *chart = [[DVPieChart alloc] init];
        
        [MiddleCell.contentView addSubview:chart];
        [chart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(MiddleCell.contentView.mas_top).offset(42);
            make.left.equalTo(MiddleCell.contentView.mas_left).offset(kScreenValue(22));
            make.width.mas_equalTo(kScreenWidth/2);
            make.height.mas_equalTo(kScreenValue(113));
        }];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in self.datePit) {
            DVFoodPieModel *model = [[DVFoodPieModel alloc]init];
            model.value = [dic[@"transaction_h_24"] floatValue];
            model.name = dic[@"pair"];
            model.rate = [dic[@"transaction"] floatValue];
            [arr addObject:model];

        }

        chart.dataArray = arr;
     
        [chart draw];
        MiddleCell.selectionStyle = UITableViewCellSelectionStyleNone;

        return MiddleCell;
    }else{
        PriceDataBottomCell * BottomCell = [tableView dequeueReusableCellWithIdentifier:@"PriceDataBottomCell"];

        if (indexPath.section == 2 && indexPath.row == 0) {
            UILabel *bule = [[UILabel alloc]init];
            bule.backgroundColor = [UIColor blueColor];
            [BottomCell.contentView addSubview:bule];
            
            [bule mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(BottomCell.contentView.mas_top).offset(14);
                make.left.equalTo(BottomCell.contentView.mas_left).offset(kScreenValue(22));
                make.width.mas_equalTo(kScreenValue(5));
                make.height.mas_equalTo(kScreenValue(13));
            }];
            UILabel *tit = [[UILabel alloc]init];
            [BottomCell.contentView addSubview:tit];
            
            tit.text = @"交易所占比例";
            tit.font = [UIFont systemFontOfSize:kScreenValue(13)];
            [tit mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(BottomCell.contentView.mas_top).offset(14);
                make.left.equalTo(bule.mas_right).offset(kScreenValue(10));
                make.width.mas_equalTo(kScreenWidth/3);
                make.height.mas_equalTo(kScreenValue(13));
            }];
          
            BottomCell.selectionStyle = UITableViewCellSelectionStyleNone;

            return BottomCell;
        }else{
            
            PriceDataBottomListCell * BottomListCell = [tableView dequeueReusableCellWithIdentifier:@"PriceDataBottomListCell"];
            
            BottomListCell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                BottomListCell.one.text = @"排行";
                BottomListCell.two.text = @"交易所";
                BottomListCell.three.text = @"交易对";
                BottomListCell.four.text = @"成交量";
                BottomListCell.five.text = @"占比";
            }else{
               NSDictionary *dic = self.dataList[indexPath.row - 2];
            BottomListCell.one.text =[NSString stringWithFormat:@"%ld",indexPath.row -2];
                BottomListCell.two.text = dic[@"platform"];
                BottomListCell.three.text = [NSString stringWithFormat:@"%@",dic[@"pair"]];
                BottomListCell.four.text = [NSString stringWithFormat:@"%@万",dic[@"transaction_h_24"]];
                BottomListCell.five.text = [NSString stringWithFormat:@"%@",dic[@"transaction"]];
                
            }
            
            return BottomListCell;
        }
        
        
    }
    
}





-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
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
