//
//  WarnCenterVC.m
//  Fairy
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "WarnCenterVC.h"
#import "MessageCell.h"


@interface WarnCenterVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation WarnCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor grayColor];
    [self initNavtionBar];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}

-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"预警中心";
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section==0 ) {
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"ExitCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExitCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor =[UIColor whiteColor];
            
            UILabel  *lable = [[UILabel alloc]init];
            lable.text = @"红涨绿跌";
            lable.backgroundColor = [UIColor whiteColor];
            lable.font = [UIFont systemFontOfSize:20];
            lable.textColor = [UIColor blackColor];
            lable.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(8);
                make.width.mas_equalTo(120);
                make.height.mas_equalTo(22);
                make.centerY.mas_equalTo(cell.contentView);
            }];
            
            //开关
            UIButton* nightModelBtn =[UIButton new];
            [cell.contentView addSubview:nightModelBtn];
            nightModelBtn.selected = NO;
            [nightModelBtn setImage:[UIImage imageNamed:@"nightMode_close"] forState:UIControlStateNormal];
            [nightModelBtn setImage:[UIImage imageNamed:@"nightMode_open"] forState:UIControlStateSelected];
            [nightModelBtn addTarget:self action:@selector(nightModeClick:) forControlEvents:UIControlEventTouchUpInside];
            [nightModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(24);
                make.centerY.mas_equalTo(cell.contentView);
            }];
            
            
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
            [cell.contentView addSubview:lineView];
            lineView.frame =CGRectMake(0, CGRectGetMaxY(cell.contentView.frame), UIScreenW, AdaptedHeight(1));
            
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else {
        MessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
        if (indexPath.row == 2)
        {
            cell.lineView.hidden = YES;
        }else
        {
            cell.lineView.hidden = NO;
        }
        
        
        if (indexPath.section==0) {
            if (indexPath.row ==1)
            {
                cell.TitleLab.text = @"剧烈波动预警";
                cell.DetailsLab.text = @"开";
                cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            }
            else if (indexPath.row == 2)
            {
                cell.TitleLab.text = @"预警模式";
                cell.DetailsLab.text = @"铃声+震动";
                cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            }
        }
        
        else{
            if (indexPath.row ==0)
            {
                cell.TitleLab.text = @"未触发预警";
                cell.DetailsLab.text = @"0条";
                cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            }
            else if (indexPath.row == 1)
            {
                cell.TitleLab.text = @"历史预警";
                cell.DetailsLab.text = @"0条";
                cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            }
            else if (indexPath.row == 2)
            {
                cell.TitleLab.text = @"剧烈波动预警记录";
                cell.DetailsLab.text = @"";
                cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            }
            
        }
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 10)];
    view.backgroundColor =[UIColor grayColor];
    return view;
}

-(void)nightModeClick:(UIButton*)btn{
    btn.selected = !btn.selected;
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
