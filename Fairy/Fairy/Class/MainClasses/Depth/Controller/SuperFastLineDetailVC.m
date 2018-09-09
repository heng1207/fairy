//
//  SuperFastLineDetailVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "SuperFastLineDetailVC.h"
#import "SuperFastTopCell.h"
#import "SuperFastBottomCell.h"
#import "XHSegmentControl.h"
#import "PriceAnalyzeView.h"
#import "WSLPictureBrowseView.h"

@interface SuperFastLineDetailVC ()<UITableViewDataSource,UITableViewDelegate,XHSegmentControlDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary *Topdic;
@property (nonatomic,strong)NSMutableArray *Array;
@property (nonatomic,strong)NSMutableArray *ViewArray;
@property (nonatomic,strong)NSArray*typeDataArr;
@property (nonatomic,strong)NSMutableDictionary *Bottomdic;
@property (nonatomic,copy)NSString *imageUrl;

@property (nonatomic,strong)XHSegmentControl *segmentCV;

@end

@implementation SuperFastLineDetailVC



- (XHSegmentControl *)segmentCV
{
    if (!_segmentCV)
    {
        
        _segmentCV = [[XHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
//        _segmentControl.selectIndex = 0;
        _segmentCV.delegate = self;
        _segmentCV.segmentType = XHSegmentTypeFit;


    }
    return _segmentCV;
}
-(NSArray*)typeDataArr{
    if (!_typeDataArr) {
        _typeDataArr = @[
                         @{@"type":@"googlevscoin",@"content":@"google关注度的增长与币价格的对比"},
                         @{@"type":@"orilvscoin",@"content":@"原油与币价格变化的百分比之间的关系"},
                         @{@"type":@"redditvscoin",@"content":@"reddit关注度与币价格之间的关系"},
                         @{@"type":@"exchangeratevscoin",@"content":@"汇率与币价格之间的关系"},
                         ];
    }
    return _typeDataArr;
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
            
//            [self.tableView reloadData];
        }else{
//            [self showHint:responseObject[@"message"]];
        }
        
    } failure:^(NSError *error) {
        [self showHint:@"网络不好"];
    }];
    
    //getHistory 7天  14天   28天数据
    
    NSString *str1 = [NSString stringWithFormat:@"%@?token=%@",getHistory,dict[@"token"]];
  
//    NSDictionary *dic1 = @{@"day":@"7",
//                           @"currencyid":@"2170"
//                           };
//    NSDictionary *dic2 = @{@"day":@"14",
//                           @"currencyid":@"2170"
//                           };
//    NSDictionary *dic3 = @{@"day":@"28",
//                           @"currencyid":@"2170"
//                           };
    NSDictionary *dic1 = @{@"day":@"7",
                           @"currencyid":self.currencyid
                           };
    NSDictionary *dic2 = @{@"day":@"14",
                           @"currencyid":self.currencyid
                           };
    NSDictionary *dic3 = @{@"day":@"28",
                           @"currencyid":self.currencyid
                           };
    [NetworkManage Get:str1 andParams:dic1 success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"] integerValue ]==200) {
            
            [self.Array addObject:responseObject[@"data"]];
            [NetworkManage Get:str1 andParams:dic2 success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                
                if ([responseObject[@"code"] integerValue ]==200) {
                    
                    [self.Array addObject:responseObject[@"data"]];
                    [NetworkManage Get:str1 andParams:dic3 success:^(id responseObject) {
                        NSLog(@"%@",responseObject);
                        
                        if ([responseObject[@"code"] integerValue ]==200) {
                            
                            [self.Array addObject:responseObject[@"data"]];
                            [self.tableView reloadData];
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
        }else{
            [self showHint:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self showHint:@"网络不好"];
    }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 58+64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SuperFastTopCell class] forCellReuseIdentifier:@"SuperFastTopCell"];
        [_tableView registerClass:[SuperFastBottomCell class] forCellReuseIdentifier:@"SuperFastBottomCell"];
    }
    return _tableView;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self GetDataView];
    [self.view addSubview:self.tableView];


}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view removeAllSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
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


-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
   
       return 2;

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
         return 1;
    }else{
         return 2;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
        if (indexPath.section == 0) {
            return kScreenValue(246);
        }
        else{
            if (indexPath.row == 0) {
               return kScreenValue(44);
            }else{
                 return kScreenValue(212);
            }
        }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        if (indexPath.section == 0) {
            SuperFastTopCell *TopCell = [tableView dequeueReusableCellWithIdentifier:@"SuperFastTopCell"];

            double number = [_Topdic[@"price"] doubleValue];
            NSString *string = [NSString stringWithFormat:@"%.2f",number];
            TopCell.NowPrice.text =[NSString stringWithFormat:@"当前价%@ USD",string] ;
//            TopCell.NowHelp.text = [NSString stringWithFormat:@"跌破%@ USD可考虑卖出",string];
            
 
            NSString *string1 = [NSString stringWithFormat:@"%@",_Topdic[@"pct_change"]];
            
            NSArray *array = [string1 componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
            NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
            
            NSString *priceStr = [NSString stringWithFormat:@"预测未来涨幅为%@%%",[array firstObject]];
            
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
            NSDictionary *dicTime = [NSDictionary dictionary];
            if (self.Array.count==3) {
                dicTime = self.Array[0];
                TopCell .shouyi1.text = dicTime[@"pctChange"];
                TopCell .jizhun1.text = dicTime[@"increase"];
                dicTime = self.Array[1];
                TopCell .shouyi2.text = dicTime[@"pctChange"];
                TopCell .jizhun2.text = dicTime[@"increase"];
                dicTime = self.Array[2];
                TopCell .shouyi3.text = dicTime[@"pctChange"];
                TopCell .jizhun3.text = dicTime[@"increase"];
            }
            TopCell.selectionStyle = UITableViewCellSelectionStyleNone;

            return TopCell;
        }
        else{
            SuperFastBottomCell *BottomCell = [tableView dequeueReusableCellWithIdentifier:@"SuperFastBottomCell"];
            if (indexPath.row == 0) {
                 [BottomCell.contentView addSubview:_segmentCV];
                NSArray *artit =@[@"google关注度的增长与币价格的对比",@"原油与币价格变化的百分比之间的关系",@"reddit关注度与币价格之间的关系",@"汇率与币价格之间的关系"];
                _segmentCV.titles = artit;
                [self.segmentCV load];
            }else{
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openImage:)];
                [BottomCell.describeIM addGestureRecognizer:tap];
                
                [BottomCell ValueForDic:_Bottomdic];
            }
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

- (void)xhSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation{

    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"coin"] = @"btc";
    dict[@"type"] = self.typeDataArr[index][@"type"];
    [NetworkManage Get:PriceAnalyze andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
            [dic setObject:self.typeDataArr[index][@"content"] forKey:@"des"];
            _Bottomdic = dic;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
