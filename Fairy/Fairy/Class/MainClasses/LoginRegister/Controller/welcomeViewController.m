//
//  welcomeViewController.m
//
//
//  Created by  on 17/10/10.
//  Copyright © 2017年 itcase. All rights reserved.
//

#import "welcomeViewController.h"
#import "MainTabBarController.h"


@interface welcomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation welcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize= CGSizeMake(UIScreenW*2, UIScreenH);
    scrollView.delegate =self;
    
    
    for (NSInteger i=0; i<2; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*UIScreenW, 0, UIScreenW, UIScreenH)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"introductoryPage%ld",i+1]];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];

        
        if (i==1) {
    
            UIButton *goHomeBtn =[[UIButton alloc]initWithFrame:CGRectMake( (UIScreenW-200)/2, UIScreenH-50-50-LL_TabbarSafeBottomMargin, 200, 50)];
            goHomeBtn.backgroundColor =[UIColor colorWithHex:@"#a77ceb"];
            [goHomeBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            goHomeBtn.titleLabel.font =[UIFont systemFontOfSize:15];
            [goHomeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [goHomeBtn addTarget:self action:@selector(goHomeClick) forControlEvents:UIControlEventTouchUpInside];
            goHomeBtn.layer.cornerRadius =5;
            goHomeBtn.layer.masksToBounds =YES;
            [imageView addSubview:goHomeBtn];
            
        }
        
        
    }
    
    scrollView.pagingEnabled = YES;
    scrollView.bounces =NO;
    scrollView.showsVerticalScrollIndicator =NO;
    scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView =scrollView;
    [self.view addSubview:scrollView];
    
    
    
    UIPageControl *pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, UIScreenH-30-LL_TabbarSafeBottomMargin, UIScreenW, 20)];
    pageControl.backgroundColor=[UIColor clearColor];
    pageControl.numberOfPages = 2;
    pageControl.currentPage =0;
    pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    pageControl.pageIndicatorTintColor =[UIColor whiteColor];
    pageControl.userInteractionEnabled =NO;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];

    
    // Do any additional setup after loading the view.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x /UIScreenW + 0.5;
}

-(void)goHomeClick{
    MainTabBarController *globalNav = [[MainTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = globalNav;
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
