//
//  NavView.m
//  Fairy
//
//  Created by  on 2018/7/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "NavView.h"
@interface NavView ()<UITextFieldDelegate>

@end

@implementation NavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithHex:@"#1296db"];
        
        
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(11, LL_StatusBarHeight+10, 11, 20)];
        [backBtn setImage:[UIImage imageNamed:@"navBack"] forState:UIControlStateNormal];
        [self addSubview:backBtn];
 
        
        //
        UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-12-30, LL_StatusBarHeight+6, 30, 28)];
        [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:searchBtn];
        
        
        
        UIView *searchBackView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backBtn.frame)+15, LL_StatusBarHeight+6, SCREEN_WIDTH-22-15-30-12*2, 28)];
        searchBackView.backgroundColor =[UIColor whiteColor];
        searchBackView.layer.cornerRadius = 3;
        searchBackView.layer.masksToBounds = YES;
        [self addSubview:searchBackView];

        
        
        UIImageView *searchLogo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 6, 15, 15)];
        [searchBackView addSubview:searchLogo];
        searchLogo.image =[UIImage imageNamed:@"searchLogo"];
        
        UITextField *contentTF =[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchLogo.frame)+5, 0, 250, searchBackView.frame.size.height)];
        contentTF.placeholder = @"搜索币种...";
        contentTF.textColor = [UIColor grayColor];
        contentTF.font = AdaptedFontSize(26);
        //"通过KVC修改占位文字的颜色"
        [contentTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        //光标颜色
        contentTF.tintColor = [UIColor blackColor];
        contentTF.delegate = self;
        [searchBackView addSubview:contentTF];
        [searchBackView bringSubviewToFront:contentTF];
        
    }
    return self;
}

#pragma mark UITextFiledDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
}



/*
 - (instancetype)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 
 UIImageView *backIM =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
 [self addSubview:backIM];
 backIM.image =[UIImage imageNamed:@"navBackIM"];
 
 
 UIImageView *searchBackIM = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-265)/2, LL_StatusBarHeight+7, 265, 30)];
 [self addSubview:searchBackIM];
 searchBackIM.userInteractionEnabled = YES;
 searchBackIM.image =[UIImage imageNamed:@"searchBackIM"];
 
 
 UIImageView *searchLogo = [[UIImageView alloc]initWithFrame:CGRectMake(40, (searchBackIM.frame.size.height-14)/2, 14, 14)];
 [searchBackIM addSubview:searchLogo];
 searchLogo.image =[UIImage imageNamed:@"searchLogo"];
 
 UITextField *contentTF =[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchLogo.frame)+20, 0, 160, searchBackIM.frame.size.height)];
 contentTF.placeholder = @"搜索 平台/币种/资讯";
 contentTF.textColor = [UIColor colorWithHex:@"#d4f6fb"];
 contentTF.font = AdaptedFontSize(26);
 //"通过KVC修改占位文字的颜色"
 [contentTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
 //光标颜色
 contentTF.tintColor = [UIColor whiteColor];
 contentTF.delegate = self;
 [searchBackIM addSubview:contentTF];
 [searchBackIM bringSubviewToFront:contentTF];
 
 }
 return self;
 }
 
 */





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
