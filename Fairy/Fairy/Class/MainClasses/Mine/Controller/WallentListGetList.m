
//
//  WallentListGetList.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/5.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "WallentListGetList.h"
#import "WallentListCell.h"
#import "WallentModel.h"
@interface WallentListGetList ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;

@end

@implementation WallentListGetList
-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor grayColor];
    [self GeiDataList];
    self.view.backgroundColor = RGBA(232,239, 245, 1);
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}

-(void)GeiDataList{
    
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"token"]  = userModel.token;
    
    NSString *str = [NSString stringWithFormat:@"%@?token=%@",GetRechargeHistory,dict[@"token"]];
    
    NSDictionary *dic = @{@"coinType":self.titleCoin};
    
    [NetworkManage Get:str andParams:dic success:^(id responseObject) {
        
        NSLog(@"$@",responseObject);
        if ([responseObject[@"code"] integerValue] == 200) {
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in responseObject[@"data"]) {
                WallentModel *model = [[WallentModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:model];
            }
            
            [self.myTableView reloadData];
        }else{
            [self showHint:responseObject[@"message"]];
            
        }
        
    } failure:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
    
}

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor =[UIColor colorWithHex:@"#e8f0f3"];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_myTableView registerClass:[WallentListCell class] forCellReuseIdentifier:@"WallentListCell"];
        
        
    }
    return _myTableView;
}


#pragma mark UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kScreenValue(163);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WallentListCell *SetCell = [tableView dequeueReusableCellWithIdentifier:@"WallentListCell" forIndexPath:indexPath];
    SetCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WallentModel *model = self.dataArray[indexPath.row];
    
    SetCell.title.text =model.tradeType;
    SetCell.state.text = model.tradeStatus;
    SetCell.money.text = @"金额";
    SetCell.time.text = [CommonTool YYMMDDtimeWithTimeIntervalString:model.tradeTime];
    SetCell.address.text = @"对方地址";
    SetCell.moneyCount.text = [NSString stringWithFormat:@"%@",model.tradeAmount];
    SetCell.addressDetail.text = model.fromAddress;
    
    
    
    return SetCell;
    
}



//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
