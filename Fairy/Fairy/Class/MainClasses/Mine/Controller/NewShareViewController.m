

//
//  NewShareViewController.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/4.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "NewShareViewController.h"
#import "FL_Button.h"

@interface NewShareViewController ()
//naviview
@property (nonatomic, strong) UIView *naviView;
@end

@implementation NewShareViewController


- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor grayColor];
    [self initNavtionBar];
    [self createCodeLoginView];
    self.view.backgroundColor = RGBA(232,239, 245, 1);
    
    // Do any additional setup after loading the view.
}
//导航栏透明
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = [NSString stringWithFormat:@"提币-%@",self.title];
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"loginBack"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    

    
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - pravite method
- (void)createCodeLoginView
{
    UIImageView *backIM =[UIImageView new];
    backIM.userInteractionEnabled = YES;
    backIM.image =[UIImage imageNamed:@"组1"];
    [self.view addSubview:backIM];
    
    [backIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.top).offset(0);
        make.left.mas_equalTo(self.view.left).offset(0);
        make.right.mas_equalTo(self.view.right).offset(0);
        make.bottom.mas_equalTo(self.view.bottom).offset(0);
        
    }];
    
    
    UIImageView *LogonIM =[UIImageView new];
    LogonIM.userInteractionEnabled = YES;
    LogonIM.image =[UIImage imageNamed:@"图层4"];
    [backIM addSubview:LogonIM];
    
    [LogonIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backIM.top).offset(kScreenValue(100));
        make.left.mas_equalTo(backIM.left).offset( kScreenValue(50) );
        make.right.mas_equalTo(backIM.right).offset( kScreenValue(-50) );

        make.height.mas_equalTo(kScreenWidth - kScreenValue(100));

    }];
    
    //图中设置
    UILabel *myNum = [[UILabel alloc]init];
    myNum.font = [UIFont systemFontOfSize:kScreenValue(14)];
    myNum.text = @"您的邀请码";
    myNum.textColor = RGBA(76, 193, 252, 1);

    myNum.textAlignment = NSTextAlignmentCenter;
    [LogonIM addSubview:myNum];
    [myNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LogonIM.mas_top).offset(kScreenValue(20));
        make.right.equalTo(LogonIM.mas_right).offset(kScreenValue(-15));
        make.left.equalTo(LogonIM.mas_left).offset(kScreenValue(15));
        make.height.mas_equalTo(kScreenValue(25));
    }];
    UILabel *myNumDet = [[UILabel alloc]init];
    myNumDet.font = [UIFont systemFontOfSize:kScreenValue(50)];
    myNumDet.text = [NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:KmyCode]];
    myNumDet.textAlignment = NSTextAlignmentCenter;
    [LogonIM addSubview:myNumDet];
    myNumDet.textColor = RGBA(41, 175, 247, 1);
    [myNumDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNum.mas_bottom).offset(kScreenValue(10));
        make.right.equalTo(LogonIM.mas_right).offset(kScreenValue(-15));
        make.left.equalTo(LogonIM.mas_left).offset(kScreenValue(15));
        make.height.mas_equalTo(kScreenValue(60));
    }];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"复制" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(copyAddress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor: [UIColor orangeColor]  forState:UIControlStateNormal];
    btn.titleLabel.layer.masksToBounds = YES;
    btn.titleLabel.layer.cornerRadius = 5;
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [LogonIM addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myNumDet.mas_bottom).offset(kScreenValue(20));
        make.left.equalTo(backIM.mas_left).offset((kScreenWidth/2 ) - 25);
        make.width.mas_equalTo(kScreenValue(50));
        make.height.mas_equalTo(kScreenValue(25));
    }];

    
    
    //二维码
    
  

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [[NSString stringWithFormat:@"asdasdasdasd"] dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];

    UIImageView *codeView = [[UIImageView alloc] init];
    codeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];//重绘二维码,使其显示清晰

    codeView.backgroundColor = [UIColor blackColor];
    [backIM addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LogonIM.mas_bottom).offset(kScreenValue(30));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(69));
        make.height.mas_equalTo(kScreenValue(96));
        make.width.mas_equalTo(kScreenValue(96));

    }];
    
    CGFloat w_ios = [CommonTool getWidthWithContent:@"iOS" height:kScreenValue(20) font:kScreenValue(18)];
    
    FL_Button *iOSBtn = [[FL_Button alloc]initWithAlignmentStatus:FLAimageLeftAndTitleRight];
    iOSBtn.titleLabel.font = [UIFont systemFontOfSize:kScreenValue(13)];
    [iOSBtn setImage:[UIImage imageNamed:@"ETH"] forState:UIControlStateNormal];
    [iOSBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [iOSBtn setTitle:@"iOS" forState:UIControlStateNormal];
    iOSBtn .titleLabel.textAlignment = NSTextAlignmentCenter;
    [backIM addSubview:iOSBtn];
    
    [iOSBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.mas_bottom).offset(kScreenValue(30));
        make.centerX .equalTo(codeView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(kScreenValue(20));
    }];
    
    
    
    
    
    
    CIFilter *filter1 = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter1 setDefaults];
    NSData *data1 = [[NSString stringWithFormat:@"asdasdasdasd"] dataUsingEncoding:NSUTF8StringEncoding];
    [filter1 setValue:data1 forKey:@"inputMessage"];
    CIImage *outputImage1 = [filter1 outputImage];
    
    UIImageView *codeView1 = [[UIImageView alloc] init];
    codeView1.image = [self createNonInterpolatedUIImageFormCIImage:outputImage1 withSize:200];//重绘二维码,使其显示清晰
    
    codeView1.backgroundColor = [UIColor blackColor];
    [backIM addSubview:codeView1];
    [codeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LogonIM.mas_bottom).offset(kScreenValue(30));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-69));
        make.height.mas_equalTo(kScreenValue(96));
        make.width.mas_equalTo(kScreenValue(96));
        
    }];

    CGFloat w_Android = [CommonTool getWidthWithContent:@"Android" height:kScreenValue(20) font:kScreenValue(18)];

    FL_Button *AndroidBtn = [[FL_Button alloc]initWithAlignmentStatus:FLAimageLeftAndTitleRight];
    AndroidBtn.titleLabel.font = [UIFont systemFontOfSize:kScreenValue(13)];
    [AndroidBtn setImage:[UIImage imageNamed:@"ETH"] forState:UIControlStateNormal];
    [AndroidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AndroidBtn setTitle:@"Android" forState:UIControlStateNormal];;
    [backIM addSubview:AndroidBtn];
    AndroidBtn .titleLabel.textAlignment = NSTextAlignmentCenter;

    [AndroidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.mas_bottom).offset(kScreenValue(30));
        make.centerX .equalTo(codeView1);
        make.width.mas_equalTo(w_Android);
        make.height.mas_equalTo(kScreenValue(20));

    }];
    
    
    
}
-(void) copyAddress:(UIButton *)sender{
    [self showHint:@"已复制"];
    
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string=[NSString stringWithFormat:@"%@",[kUserDefaults objectForKey:KmyCode]];
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
