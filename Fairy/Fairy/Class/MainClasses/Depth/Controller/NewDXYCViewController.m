

//
//  NewDXYCViewController.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/7.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "NewDXYCViewController.h"
#import "XHSegmentControl.h"
#import "SuperDetailTopCell.h"
#import "SuperFastBottomCell.h"
#import "PhoneZhuCeModel.h"
#import "WSLPictureBrowseView.h"
@interface NewDXYCViewController()<XHSegmentControlDelegate,UITableViewDelegate,UITableViewDataSource,XHTSegmentControlDelegate>
@property (nonatomic,strong)XHSegmentControl *segmentCV;
@property (nonatomic,strong)XHSegmentControl *segmentCVT;

@property (nonatomic,strong)NSMutableArray *arrayName;
@property (nonatomic,strong)NSMutableArray *arrayID;

@property (nonatomic,strong)UITableView *TopTableView;
@property (nonatomic,strong)UITableView *BottomTableView;


@property (nonatomic,strong)NSMutableDictionary *dicData;
@property (nonatomic,strong)UIView *MessageView;

@property (nonatomic,strong)NSMutableDictionary *Topdic;
@property (nonatomic,strong)NSMutableArray *Array;
@property (nonatomic,strong)NSMutableArray *ViewArray;
@property (nonatomic,strong)NSArray*typeDataArr;
@property (nonatomic,strong)NSMutableDictionary *Bottomdic;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *currencyid;

@end

@implementation NewDXYCViewController


-(void)GetData{
    [NetworkManage Get:@"http://47.254.69.147:8080/interface/depth_coins/list_data" andParams:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"]integerValue ] ==200) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                [self.arrayName addObject:[NSString stringWithFormat:@"%@",dic[@"currencyShortEnName"]]];
                [self.arrayID addObject:[NSString stringWithFormat:@"%@",dic[@"digitalCurrencyID"]]];
            }
            _segmentCV = [[XHSegmentControl alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+58, [UIScreen mainScreen].bounds.size.width, 44)];
            //            NSArray *artit =@[@"google关注度的增长与币价格的对比",@"原油与币价格变化的百分比之间的关系",@"reddit关注度与币价格之间的关系",@"汇率与币价格之间的关系"];
            _segmentCV.titles = self.arrayName;
            _segmentCV.delegate = self;
            _segmentCV.segmentType = XHSegmentTypeFit;
            _segmentCV.tag = 999;
            [_segmentCV load];
            [self.view addSubview:_segmentCV];
            
            //biao 1
            _TopTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+58+44, SCREEN_WIDTH, kScreenValue(243)) style:UITableViewStylePlain];
            _TopTableView.delegate = self;
            _TopTableView.dataSource = self;
            _TopTableView.scrollEnabled = NO;
            [_TopTableView registerClass:[SuperDetailTopCell class] forCellReuseIdentifier:@"SuperFastTopCell"];
            _TopTableView.tag = 1009;
            [self.view addSubview:_TopTableView];
            //tou 1
            _segmentCVT = [[XHSegmentControl alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+65+44+kScreenValue(246), [UIScreen mainScreen].bounds.size.width, 44)];
            _segmentCVT.segmentType = XHSegmentTypeFit;
            _segmentCVT.titles = @[@"google与币价",@"原油与币价",@"reddit与币价",@"汇率与币价"];
            _segmentCVT.tdelegate = self;
            _segmentCVT.tag = 9999;
            [_segmentCVT load];
            
            [self.view addSubview:_segmentCVT];
            
            _BottomTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+65+44+kScreenValue(246)+58, SCREEN_WIDTH, kScreenValue(212)) style:UITableViewStylePlain];
            _BottomTableView.delegate = self;
            _BottomTableView.dataSource = self;
            _BottomTableView.tag = 2009;
            [_BottomTableView registerClass:[SuperFastBottomCell class] forCellReuseIdentifier:@"SuperFastBottomCell"];
            
            [self.view addSubview:_BottomTableView];
            self.title = self.arrayName[0];
            self.currencyid = self.arrayID[0];
        }
        
    } failure:^(NSError *error) {
    }];
    
}
-(void)GetDataView{
    
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"token"]  = userModel.token;
    
    NSString *str = [NSString stringWithFormat:@"%@?token=%@",search_shortline,dict[@"token"]];
    NSDictionary *dic = @{@"coin":[self.title lowercaseString]};
    NSLog(@"参数%@",dic);
    
    [NetworkManage Get:str andParams:dic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"] integerValue ]==200) {
            
            _Topdic = responseObject[@"data"];
            [self.TopTableView reloadData];
        }else{
        }
        
    } failure:^(NSError *error) {
        [self showHint:@"网络不好"];
    }];
    
    //getHistory 7天  14天   28天数据
    
    NSString *str1 = [NSString stringWithFormat:@"%@?token=%@",getHistory,dict[@"token"]];
    
    //        NSDictionary *dic1 = @{@"day":@"7",
    //                               @"currencyid":@"2170"
    //                               };
    //        NSDictionary *dic2 = @{@"day":@"14",
    //                               @"currencyid":@"2170"
    //                               };
    //        NSDictionary *dic3 = @{@"day":@"28",
    //                               @"currencyid":@"2170"
    //                               };
    NSDictionary *dic1 = @{@"day":@"2",
                           @"currencyid":self.currencyid
                           };
    NSDictionary *dic2 = @{@"day":@"4",
                           @"currencyid":self.currencyid
                           };
    NSDictionary *dic3 = @{@"day":@"6",
                           @"currencyid":self.currencyid
                           };
    [NetworkManage Get:str1 andParams:dic1 success:^(id responseObject) {
        [self.Array removeAllObjects];
        
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"] integerValue ]==200) {
            
            [self.Array addObject:responseObject[@"data"]];
            [self.TopTableView reloadData];
            
            [NetworkManage Get:str1 andParams:dic2 success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                
                if ([responseObject[@"code"] integerValue ]==200) {
                    
                    [self.Array addObject:responseObject[@"data"]];
                    [NetworkManage Get:str1 andParams:dic3 success:^(id responseObject) {
                        NSLog(@"%@",responseObject);
                        
                        if ([responseObject[@"code"] integerValue ]==200) {
                            
                            [self.Array addObject:responseObject[@"data"]];
                            [self.TopTableView reloadData];
                        }
                        
                    } failure:^(NSError *error) {
                        NSLog(@"%@",error);
                        
                        [self showHint:@"网络不好"];
                        
                    }];
                    
                }else{
                    //            [self showHint:responseObject[@"message"]];
                }
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
                [self showHint:@"网络不好"];
                
            }];
        }else{
            //            [self showHint:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self showHint:@"网络不好"];
    }];
    
    NSMutableDictionary *dictt=[NSMutableDictionary dictionary];
    dict[@"coin"] = [self.title lowercaseString];
    dict[@"type"] = self.typeDataArr[0][@"type"];
    [NetworkManage Get:PriceAnalyze andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
            [dic setObject:self.typeDataArr[0][@"content"] forKey:@"des"];
            _Bottomdic = dic;
            [self.BottomTableView reloadData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:)name:@"openView" object:nil];
    self.view.tintColor =RGBA(153, 153, 153, 1);
    
    [self GetData];
    [self initNavtionBar];
    _MessageView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, [UIScreen mainScreen].bounds.size.width, 58)];
    _MessageView.backgroundColor =RGBA(239, 239, 244, 1);
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(26, 14, kScreenWidth-52, 35)];
    title.font = [UIFont systemFontOfSize:13];
    title.numberOfLines = 0;
    title.textColor = RGBA(153, 153, 153, 1);
    title.text = @"风险提示：短线预测仅供参考，不构成投资建议，市场有风险，需谨慎操作。";
    [_MessageView addSubview:title];
    [self.view addSubview:_MessageView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    ItemLab.text = @"短线预测";
    ItemLab.textAlignment = NSTextAlignmentCenter;
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
}

- (void)xhSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation{
    
    NSLog(@"上部分");
    _Topdic = [NSMutableDictionary new];
    [self.Array removeAllObjects];
    [self.ViewArray removeAllObjects];
    [self.TopTableView reloadData];
    [self.BottomTableView reloadData];
    
    self.title = self.arrayName[index];
    self.currencyid = self.arrayID[index];
    [self GetDataView];
    self.segmentCVT.selectIndex = 0;
    
}

- (void)XHTSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation{
    
    NSLog(@"XIA部分");
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"coin"] = [self.title lowercaseString];
    dict[@"type"] = self.typeDataArr[index][@"type"];
    [NetworkManage Get:PriceAnalyze andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
            [dic setObject:self.typeDataArr[index][@"content"] forKey:@"des"];
            _Bottomdic = dic;
            [self.BottomTableView reloadData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1009) {
        return 1;
    }else{
        return 1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1009) {
        return kScreenValue(246);
    }
    else
    {
        
        return kScreenValue(212);
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1009) {
        SuperDetailTopCell *TopCell = [tableView dequeueReusableCellWithIdentifier:@"SuperFastTopCell"];
        
        double number = [_Topdic[@"price"] doubleValue];
        NSString *string = [NSString stringWithFormat:@"%.2f",number];
        TopCell.NowPrice.text =[NSString stringWithFormat:@"当前价%@ USD",string] ;
        //            TopCell.NowHelp.text = [NSString stringWithFormat:@"跌破%@ USD可考虑卖出",string];
        
        
        NSString *string1 = [NSString stringWithFormat:@"%@",_Topdic[@"pct_change"]];
        
        NSArray *array = [string1 componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
        NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
        
        NSString *priceStr = [NSString stringWithFormat:@"未来一日内涨幅为%@%%",[array firstObject]];
        
        NSArray * numberArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"%"];
        
        NSMutableAttributedString * attributeString  = [[NSMutableAttributedString alloc]initWithString:priceStr];
        
        for (int i = 0; i < priceStr.length; i ++) {
            
            //每次只截取一个字符的范围
            
            NSString * str = [priceStr substringWithRange:NSMakeRange(i, 1)];
            
            //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
            
            if ([numberArr containsObject:str]) {
                
                [attributeString setAttributes:@{NSForegroundColorAttributeName:RGBA(247, 202, 53, 1),NSFontAttributeName:[UIFont systemFontOfSize:19]} range:NSMakeRange(i, 1)];
                
            }
            
            
            
        }
        
        //完成查找数字并显示
        
        TopCell.NowHelp.attributedText = attributeString;
        
        TopCell.UpdateTime.text = [NSString stringWithFormat:@"更新时间：%@",_Topdic[@"datetime"]];
        if (self.Array.count==3) {
            NSDictionary *dicTime = self.Array[0];
            if ([[NSString stringWithFormat:@"%@",dicTime[@"pctChange"]] containsString:@"-"]) {
                TopCell .shouyi1.textColor = [UIColor greenColor];
                
            }else{
                TopCell .shouyi1.textColor = [UIColor redColor];

            }
            if ([[NSString stringWithFormat:@"%@",dicTime[@"increase"]] containsString:@"-"]) {
                TopCell .jizhun1.textColor = [UIColor greenColor];
                
            }else{
                TopCell .jizhun1.textColor = [UIColor redColor];

            }
            TopCell .shouyi1.text = dicTime[@"pctChange"];
            TopCell .jizhun1.text = dicTime[@"increase"];
            NSDictionary *dicTime1 = self.Array[1];
            if ([[NSString stringWithFormat:@"%@",dicTime1[@"pctChange"]] containsString:@"-"]) {
                TopCell .shouyi2.textColor = [UIColor greenColor];
                
            }else{
                TopCell .shouyi2.textColor = [UIColor redColor];

            }
            if ([[NSString stringWithFormat:@"%@",dicTime1[@"increase"]] containsString:@"-"]) {
                TopCell .jizhun2.textColor = [UIColor greenColor];
                
            }else{
                TopCell .jizhun2.textColor = [UIColor redColor];

            }
            TopCell .shouyi2.text = dicTime1[@"pctChange"];
            TopCell .jizhun2.text = dicTime1[@"increase"];
            NSDictionary *dicTime2 = self.Array[2];
            if ([[NSString stringWithFormat:@"%@",dicTime2[@"pctChange"]] containsString:@"-"]) {
                TopCell .shouyi3.textColor = [UIColor greenColor];
                
            }else{
                TopCell .shouyi3.textColor = [UIColor redColor];

            }
            if ([[NSString stringWithFormat:@"%@",dicTime2[@"increase"]] containsString:@"-"]) {
                TopCell .jizhun3.textColor = [UIColor greenColor];
                
            }else{
                TopCell .jizhun3.textColor = [UIColor redColor];

            }
            TopCell .shouyi3.text = dicTime2[@"pctChange"];
            TopCell .jizhun3.text = dicTime2[@"increase"];
        }
        TopCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return TopCell;
    }
    else{
        SuperFastBottomCell *BottomCell = [tableView dequeueReusableCellWithIdentifier:@"SuperFastBottomCell"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openImage:)];
        
        [BottomCell ValueForDic:_Bottomdic];
        [BottomCell.describeIM addGestureRecognizer:tap];
        BottomCell.coinName = [self.title lowercaseString];
        BottomCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return BottomCell;
    }
    
    
}
-(void)openImage:(UITapGestureRecognizer *)sender{
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",SERVER,_Bottomdic[@"image"]];
    NSDictionary *dic =@{@"data":imageURL};
    NSNotification *notification =[NSNotification notificationWithName:@"openView" object:nil userInfo: dic];
    
    //通过通知中心发送通知
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}
- (void)tongzhi:(NSNotification *)text{
    
    NSLog(@"%@",text.userInfo[@"data"]);
    WSLPictureBrowseView * browseView = [[WSLPictureBrowseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    browseView.backgroundColor = [UIColor blackColor];
    //    browseView.urlArray = urlArray;
    browseView.viewController = self;
    NSMutableArray * pathArray  = [NSMutableArray array];
    [pathArray addObject:text.userInfo[@"data"]];
    browseView.pathArray = pathArray;
    [self.view addSubview:browseView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)TopTableView{
    if (!_TopTableView) {
        
        //        [_tableView registerClass:[SuperFastBottomCell class] forCellReuseIdentifier:@"SuperFastBottomCell"];
    }
    return _TopTableView;
}

-(UITableView *)BottomTableView{
    if (!_BottomTableView) {
        
    }
    return _BottomTableView;
}


-(NSMutableArray *)arrayName{
    if (!_arrayName) {
        _arrayName = [NSMutableArray array];
    }
    return _arrayName;
}
-(NSMutableArray *)arrayID{
    if (!_arrayID) {
        _arrayID = [NSMutableArray array];
    }
    return _arrayID;
}
-(NSMutableDictionary *)dicData{
    if (!_dicData) {
        _dicData = [NSMutableDictionary dictionary];
    }
    return _dicData;
}
-(NSMutableArray *)ViewArray{
    if (!_ViewArray) {
        _ViewArray = [NSMutableArray array];
    }
    return _ViewArray;
}
-(NSMutableArray *)Array{
    if (!_Array) {
        _Array = [NSMutableArray array];
    }
    return _Array;
}
-(NSMutableDictionary *)Topdic{
    if (!_Topdic) {
        _Topdic = [NSMutableDictionary dictionary];
    }
    return _Topdic;
}
-(NSMutableDictionary *)Bottomdic{
    if (!_Bottomdic) {
        _Bottomdic = [NSMutableDictionary dictionary];
    }
    return _Bottomdic;
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSArray*)typeDataArr{
    if (!_typeDataArr) {
        _typeDataArr = @[
                         @{@"type":@"googlevscoin",@"content":@"google关注度的增长与币价格的对比"},
                         @{@"type":@"oilvscoin",@"content":@"原油与币价格变化的百分比之间的关系"},
                         @{@"type":@"redditvscoin",@"content":@"reddit关注度与币价格之间的关系"},
                         @{@"type":@"exchangeratevscoin",@"content":@"汇率与币价格之间的关系"},
                         ];
    }
    return _typeDataArr;
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
