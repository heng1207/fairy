//
//  ShareVC.m
//  Fairy
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "ShareVC.h"
#import "shareBtn.h"

@interface ShareVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *photoArr;


@end

@implementation ShareVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.titleArr =@[@"微信",@"朋友圈",@"微博"];
    self.photoArr =@[@"WechatFriend",@"WechatCircle",@"WeiBo"];
    
    [self creatSubViews];
    // Do any additional setup after loading the view.
}

-(void)creatSubViews{
    

    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, UIScreenH-AdaptedHeight(190)- AdaptedHeight(88)-LL_TabbarSafeBottomMargin, UIScreenW, AdaptedHeight(190))];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    //左侧间隔
    CGFloat leftD = AdaptedWidth(84);
    //中间间隔X
    CGFloat zhongJianX = AdaptedWidth(50);
    //中间间隔Y
    CGFloat zhongJianY = AdaptedWidth(20);
    //按钮宽度
    CGFloat buttonW = (UIScreenW - leftD*2 - zhongJianX*2)/3.0;
    //按钮高度
    CGFloat buttonH = AdaptedHeight(150);
    
    
    for (NSInteger i =0; i<3; i++) {
        CGFloat x = leftD + zhongJianX*(i%3) + buttonW*(i%3);
        NSInteger row = i/3;
        CGFloat y = row*buttonH + row*zhongJianY + AdaptedHeight(20);
        
        shareBtn *button = [[shareBtn alloc]initWithFrame:CGRectMake(x, y, buttonW, buttonH)];
        button.tag = i;
        button.littleLabel.text = self.titleArr[i];
        button.photoIM.image = [UIImage imageNamed:self.photoArr[i]];
        [button addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button];
        
    }


    UIButton *cancleBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, UIScreenH - AdaptedHeight(88)-LL_TabbarSafeBottomMargin, UIScreenW, AdaptedHeight(88))];
    [self.view addSubview:cancleBtn];
    cancleBtn.backgroundColor =[UIColor whiteColor];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn borderForColor:[UIColor colorWithHex:@"#cccccc"] borderWidth:1 borderType:UIBorderSideTypeTop];
    
    
    UIImageView *backIM=[UIImageView new];
    [self.view addSubview:backIM];
    backIM.image =[UIImage imageNamed:@"share_background"];
    backIM.frame =CGRectMake(0, 0, UIScreenW, UIScreenH-AdaptedHeight(190)- AdaptedHeight(88)-LL_TabbarSafeBottomMargin);
    
}
-(void)cancleClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareClick:(UIButton*)btn{
    
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
