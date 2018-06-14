//
//  PriceDetailedSubVC.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDetailedSubVC.h"

@interface PriceDetailedSubVC ()

@end

@implementation PriceDetailedSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self creatTextView];

    // Do any additional setup after loading the view.
}

-(void)creatTextView{
    UILabel *textLab =[UILabel new];
    textLab.text = @"打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！";
    [self.view addSubview:textLab];
    textLab.numberOfLines = 0 ;
    textLab.textColor =[UIColor blackColor];
    textLab.font = AdaptedFontSize(32);
    CGSize  titleSize = [textLab.text  boundingRectWithSize: CGSizeMake(UIScreenW - 24, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin  attributes: @{NSFontAttributeName: AdaptedFontSize(32)} context: nil].size;
    textLab.frame = CGRectMake(12, 20, titleSize.width, titleSize.height);
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
