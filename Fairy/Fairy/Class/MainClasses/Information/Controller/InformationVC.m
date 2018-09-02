//
//  InformationVC.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "InformationVC.h"
#import "InformationSubVC.h"

@interface InformationVC ()

@property (nonatomic,strong) NSMutableArray *flagArray;
@property (nonatomic, strong) NSMutableArray *titleItemLengths;

@end

@implementation InformationVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressColor =[UIColor whiteColor];
    self.progressHeight = 2;
    self.titleItemLengths =[NSMutableArray array];
    for (NSInteger i =0; i<self.flagArray.count; i++) {
        CGSize size = [self methodForitleItemLengths:self.flagArray[i] ];
        NSNumber *width = [NSNumber numberWithFloat:size.width];
        [self.titleItemLengths addObject:width];
    }
    self.progressViewWidths = self.titleItemLengths;
    self.itemsWidths = self.titleItemLengths;
    self.itemMargin = 30;
    self.progressViewBottomSpace=3;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.titleSizeNormal = 15;
    self.titleSizeSelected = 15;
    self.titleColorNormal = [UIColor colorWithHex:@"#1161a0"];
    self.titleColorSelected = [UIColor whiteColor];
    self.menuView.scrollView.backgroundColor =[UIColor grayColor];
    [self reloadData];
    
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
 
    UIView *statusView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LL_StatusBarHeight)];
    statusView.backgroundColor =[UIColor colorWithHex:@"#1296db"];
    [self.view addSubview:statusView];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Datasource & Delegate
#pragma mark 返回子页面的个数
-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.flagArray.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    InformationSubVC *vc = [[InformationSubVC alloc]init];
    vc.headType = self.flagArray[index];
    return vc;
}
#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.flagArray[index];
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    menuView.backgroundColor = [UIColor colorWithHex:@"#1296db"];
    return  CGRectMake(0, LL_StatusBarHeight, SCREEN_WIDTH, 44);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return  CGRectMake(0, LL_StatusBarAndNavigationBarHeight, SCREEN_WIDTH, CGRectGetHeight(self.view.frame)- LL_StatusBarAndNavigationBarHeight );
}

- (NSMutableArray *)flagArray
{
    if (_flagArray == nil) {
        _flagArray = [NSMutableArray arrayWithObjects:@"中文",@"英文", nil];
    }
    return _flagArray;
}
-(CGSize)methodForitleItemLengths:(NSString*)titleStr{
    CGSize titleSize = [titleStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return titleSize;
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
