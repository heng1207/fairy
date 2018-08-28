//
//  PriceDataVc.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDataVc.h"
#import "PriceDataTopCell.h"
#import "PriceDataMiddleCell.h"
#import "PriceDataBottomCell.h"
#import "PriceDataBottomListCell.h"

@interface PriceDataVc ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation PriceDataVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
