
//
//  SuperFastLineController.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "SuperFastLineController.h"
#import "SuperFastLineDetailVC.h"
#import "WSLPictureBrowseView.h"
@interface SuperFastLineController ()
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSMutableDictionary *dicData;
@property (nonatomic,strong)SuperFastLineDetailVC *vc;
@end

@implementation SuperFastLineController
-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(NSMutableDictionary *)dicData{
    if (!_dicData) {
        _dicData = [NSMutableDictionary dictionary];
    }
    return _dicData;
}
-(void)GetData{
    [NetworkManage Get:@"http://47.254.69.147:8080/interface/depth_coins/list_data" andParams:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"]integerValue ] ==200) {
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                self.vc = [[SuperFastLineDetailVC alloc] init];
                self.vc.title = dic[@"currencyShortEnName"];
                self.vc.currencyid = dic[@"digitalCurrencyID"];
                [self.array addObject:self.vc];
            }
            self.viewControllers = self.array;
        }
 
    } failure:^(NSError *error) {
//        [self showHint:@"网络有问题"];
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetData];
    [self initNavtionBar];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:)name:@"openView" object:nil];
  
}

-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    ItemLab.text = @"超短线助手";
    ItemLab.textAlignment = NSTextAlignmentCenter;
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
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


-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
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
