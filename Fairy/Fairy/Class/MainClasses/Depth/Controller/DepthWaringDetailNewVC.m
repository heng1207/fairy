//
//  DepthWaringDetailNewVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/3.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "DepthWaringDetailNewVC.h"
#import "WaringCell.h"
#import "WaringTopCell.h"
#import "XuXianView.h"
#import "InformationDetailsVC.h"
@interface DepthWaringDetailNewVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSoucre;


@end

@implementation DepthWaringDetailNewVC


-(NSMutableArray *)dataSoucre{
    if (!_dataSoucre) {
        _dataSoucre = [NSMutableArray array];
    }
    return _dataSoucre;
}
-(void)GetDataView{
    //google检索
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"token"]  = userModel.token;
    NSString *str =  [NSString stringWithFormat:@"%@?token=%@",newsGetWarnin,dict[@"token"]];

    [NetworkManage Get:str andParams:nil success:^(id responseObject) {
        
        NSLog(@"xinwen %@",responseObject);
        
        if ([responseObject[@"code"] integerValue] == 200) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                [self.dataSoucre addObject:dic];
            }
            [self.tableView reloadData];
        }else{
            [self showHint:responseObject[@"message"]];
            
        }
        
    } failure:^(NSError *error) {
        [self showHint:@"网络有错误"];
    }];
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 58+64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[WaringCell class] forCellReuseIdentifier:@"WaringCell"];
        [_tableView registerClass:[WaringTopCell class] forCellReuseIdentifier:@"WaringTopCell"];
        
        
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetDataView];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1+self.dataSoucre.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return kScreenValue(45);
    }
    else{
        CGFloat h;
        NSDictionary *dic = self.dataSoucre[indexPath.row -1];
            h = [CommonTool getHeightWithContent:[NSString stringWithFormat:@"%@",dic[@"message"]] width:kScreenWidth - kScreenValue(40) font:kScreenValue(14)]+30;
            return kScreenValue(20)+h;
      
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        WaringTopCell *TopCell = [tableView dequeueReusableCellWithIdentifier:@"WaringTopCell"];
        [TopCell.contentView addSubview:TopCell.time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        NSDate *datenow = [NSDate date];
        //----------将nsdate按formatter格式转成nsstring
        NSString *currentTimeString = [formatter stringFromDate:datenow];
        NSString *week = [CommonTool weekdayStringFromDate:datenow];
        
        NSLog(@"currentTimeString =  %@",currentTimeString);
        TopCell.time.text = [NSString stringWithFormat:@"%@ %@",week,currentTimeString ];
        
        [TopCell.contentView addSubview:TopCell.time];
        TopCell.contentView.backgroundColor = RGBA(232, 239, 245, 1);
        [TopCell.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(TopCell.contentView.mas_top).offset(kScreenValue(15));
            make.left.equalTo(TopCell.contentView.mas_left).offset(kScreenValue(10));
            make.width.mas_equalTo(kScreenWidth-40);
            make.height.mas_equalTo(kScreenValue(11));
        }];
        TopCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return TopCell;
    }
    else{
        WaringCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"WaringCell"];
        
        NSDictionary *dic = self.dataSoucre[indexPath.row -1];
        NSMutableArray *mmarray = [NSMutableArray array];
        if ((indexPath.row)%2== 1) {
            mmarray = dic[@"max"];

        }else{
            mmarray = dic[@"mix"];
        }
        NSDictionary *dicc = [mmarray firstObject];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *timeDate = [formatter1 dateFromString:dicc[@"publishTime"]];
        NSInteger timeInterval = [[NSNumber numberWithDouble:[timeDate timeIntervalSince1970]] integerValue];
        
//        // 毫秒值转化为秒
//        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
//        NSString* dateString = [formatter stringFromDate:timeDate];
        Cell.time.text = [CommonTool HHmmtimeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",timeInterval*1000]];
        Cell.title.text = dic[@"key"];
        
        CGFloat h = [CommonTool getHeightWithContent:[NSString stringWithFormat:@"%@",dic[@"message"]] width:kScreenWidth - kScreenValue(40) font:kScreenValue(14)];
        
        Cell.connect.text = [NSString stringWithFormat:@"%@",dic[@"message"]];
        [Cell.contentView addSubview:Cell.time];
        [Cell.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Cell.contentView.mas_top).offset(kScreenValue(15));
            make.left.equalTo(Cell.contentView.mas_left).offset(kScreenValue(10));
            make.width.mas_equalTo(kScreenValue(40));
            make.height.mas_equalTo(kScreenValue(11));
            
        }];
        
        [Cell.contentView addSubview:Cell.title];
        [Cell.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Cell.time);
            make.left.equalTo(Cell.time.mas_right).offset(kScreenValue(9));
            make.width.mas_equalTo(kScreenValue(100));
            make.height.mas_equalTo(kScreenValue(11));
            
        }];
        
            [Cell.contentView addSubview:Cell.connect];
            [Cell.connect mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(Cell.title.mas_bottom).offset(kScreenValue(9));
                make.left.equalTo(Cell.title);
                make.width.mas_equalTo(kScreenWidth - kScreenValue(60));
                make.height.mas_equalTo(h);
                
            }];
        
        

        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        XuXianView *lineView = [[XuXianView alloc] init];
        lineView.backgroundColor = RGBA(59, 165, 221, 1);
        [Cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Cell.time.mas_bottom).offset(kScreenValue(15));
            make.left.equalTo(Cell.contentView.mas_left).offset(kScreenValue(27));
            make.bottom.equalTo(Cell.contentView.mas_bottom).offset(kScreenValue(-15));
            
            make.width.mas_equalTo(kScreenValue(1));
        }];
        
        return Cell;
    }
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataSoucre[indexPath.row -1];
    NSMutableArray *mmarray = [NSMutableArray array];
    if ((indexPath.row )%2== 1) {
        mmarray = dic[@"max"];
    }else{
        mmarray = dic[@"mix"];
    }
    NSDictionary *dicc = [mmarray firstObject];
    
    InformationDetailsVC *vc =[InformationDetailsVC new];
    vc.url = dicc[@"url"];
    vc.hidesBottomBarWhenPushed = YES;
    [[Tool getCurrentVC].navigationController pushViewController:vc animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
