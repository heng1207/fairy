//
//  MyWalletDetailListVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/5.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "MyWalletDetailListVC.h"
#import "WalletListVC.h"
#import "WallentListGetList.h"
@interface MyWalletDetailListVC ()

@end

@implementation MyWalletDetailListVC
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavtionBar];
    self.view.backgroundColor = RGBA(232,239, 245, 1);
    WalletListVC *vc1 = [[WalletListVC alloc]init];
    WallentListGetList *vc2 = [[WallentListGetList alloc]init];
    vc1.title = @"提币";
    vc2.title = @"充币";
    vc1.titleCoin = self.title;
    vc2.titleCoin = self.title;
    self.viewControllers = @[vc1,vc2];    // Do any additional setup after loading the view.
}
-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = [NSString stringWithFormat:@"明细-%@",self.title];
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
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
