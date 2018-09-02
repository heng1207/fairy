//
//  ReceiveCoinVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/29.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "ReceiveCoinVC.h"

@interface ReceiveCoinVC ()<UITextFieldDelegate>
//naviview
@property (nonatomic, strong) UIView *naviView;
//phonetf


@end

@implementation ReceiveCoinVC
-(NSMutableDictionary *)data{
    if (!_data) {
        _data = [NSMutableDictionary dictionary];
    }
    return _data;
}
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
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
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
    backIM.image =[UIImage imageNamed:@"person_background"];
    [self.view addSubview:backIM];
    
    [backIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.top).offset(0);
        make.left.mas_equalTo(self.view.top).offset(0);
        make.right.mas_equalTo(self.view.top).offset(0);
        make.height.mas_equalTo(kScreenValue(183));
        
    }];
    
    UIView *backView = [[UILabel alloc] initWithFrame:CGRectMake(15, kScreenValue(132), kScreenWidth-30, kScreenWidth-30)];
    backView.userInteractionEnabled = YES;
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
  
    
    
//    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth/2) -35, backView.mj_y-35, 70, 70)];;
//    userIcon.layer.masksToBounds = YES;
//    userIcon.layer.cornerRadius = 35;
//    userIcon.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:userIcon];
  
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [[NSString stringWithFormat:@"%@",self.data[@"currencyTokenAddress"]] dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    UIImageView *codeView = [[UIImageView alloc] init];
    codeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];//重绘二维码,使其显示清晰

    codeView.backgroundColor = [UIColor blackColor];
    [backView addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(kScreenValue((kScreenWidth - 30)*2/5));
        make.left.equalTo(self.view.mas_left).offset((kScreenValue((kScreenWidth - 30)/3)));
        make.right.equalTo(self.view.mas_right).offset(-(kScreenValue((kScreenWidth - 30)/3)));
        make.height.mas_equalTo(kScreenValue((kScreenWidth - 30)/3));
        make.width.mas_equalTo(kScreenValue((kScreenWidth - 30)/3));
        
    }];
    
    UILabel *Address =[[UILabel alloc]init];
    Address.text = [NSString stringWithFormat:@"%@",self.data[@"currencyTokenAddress"]];
    Address.textColor=[UIColor blackColor];
    Address.textAlignment = NSTextAlignmentCenter;
    Address.font = [UIFont systemFontOfSize:14];
    [backView addSubview:Address];
    [Address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.mas_top).offset(- 40);
        make.right.equalTo(backView.mas_right).offset(kScreenValue(-15));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(15));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"复制收款地址" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(copyAddress:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).offset(- 25);
        make.right.equalTo(backView.mas_right).offset(kScreenValue(-15));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(15));
        make.height.mas_equalTo(kScreenValue(25));
    }];
    
    
}
-(void) copyAddress:(UIButton *)sender{
    [self showHint:@"已复制"];

    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string=self.data[@"currencyTokenAddress"];
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
