//
//  GeneralVC.m
//  Fairy
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "GeneralVC.h"
#import "MessageCell.h"

@interface GeneralVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation GeneralVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor grayColor];
    [self initNavtionBar];
    [self.view addSubview:self.myTableView];
    
    // Do any additional setup after loading the view.
}
-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"通用设置";
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

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _myTableView.backgroundColor =[UIColor grayColor];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
        //        self.automaticallyAdjustsScrollViewInsets = NO;//解决tableview头部预留64像素的办法
    }
    return _myTableView;
}

#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return 1;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    if ( (indexPath.row == 0 && indexPath.section==0) || (indexPath.row == 0 && indexPath.section==2) )
    {
        cell.lineView.hidden = NO;
    }else
    {
        cell.lineView.hidden = YES;
    }
    
    
    if (indexPath.section==0) {
        if (indexPath.row ==0)
        {
            cell.TitleLab.text = @"通用";
            cell.DetailsLab.text = @"";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
        }
        else if (indexPath.row == 1)
        {
            cell.TitleLab.text = @"隐私";
            cell.DetailsLab.text = @"";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
        }
    }
    else if (indexPath.section==1){
        cell.TitleLab.text = @"清理缓存";
        cell.DetailsLab.text = @"234.34 MB";
        cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
    }
    else if (indexPath.section==2){
        if (indexPath.row ==0)
        {
            cell.TitleLab.text = @"关于我们";
            cell.DetailsLab.text = @"";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
        }
        else if (indexPath.row == 1)
        {
            cell.TitleLab.text = @"检查更新";
            cell.DetailsLab.text = @"";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
        }
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 10)];
    view.backgroundColor =[UIColor grayColor];
    return view;
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
