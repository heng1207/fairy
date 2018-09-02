//
//  DetailContentVC.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/15.
//  Copyright © 2018年 . All rights reserved.
//

#import "DetailContentVC.h"
#import "TLTextView.h"


@interface DetailContentVC ()
@property(nonatomic,strong)TLTextView *textContentView;
@end

@implementation DetailContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#e8f0f3"];
    [self initNavtionBar];
    
    
    TLTextView *textContentView = [[TLTextView alloc]init];
    self.textContentView = textContentView;
    textContentView.placeholderText =@" 请输入昵称";
    textContentView.textColor=[UIColor colorWithHex:@"#333333"];
    textContentView.font = [UIFont systemFontOfSize:AdaptedWidth(28)];
    [self.view addSubview:textContentView];
    textContentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeight(120));

    
    // Do any additional setup after loading the view.
}

-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"昵称";
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
        UIButton *finish = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
        [finish setTitle:@"完成" forState:UIControlStateNormal];
        finish.titleLabel.font = [UIFont systemFontOfSize:16];
        [finish addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchDown];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:finish];
    
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)finishClick{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    dict[@"consumerID"] = userModel.consumerID;
    dict[@"nickname"] = self.textContentView.text;
    NSString *path =[NSString stringWithFormat:@"%@?token=%@",consumerUpdate,userModel.token];
    [NetworkManage Post:path andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            NSLog(@"%@",obj[@"data"]);

        }
    } failure:^(NSError *error) {
        NSLog(@"网络有问题");
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
