//
//  PersionDetailVC.m
//  Fairy
//
//  Created by 张恒 on 2018/6/12.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PersionDetailVC.h"
#import "MessageCell.h"
#import "PhotoSetCell.h"


@interface PersionDetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation PersionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    [self initNavtionBar];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}
-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"个人资料";
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
        [_myTableView registerNib:[UINib nibWithNibName:@"PhotoSetCell" bundle:nil] forCellReuseIdentifier:@"PhotoSetCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
        //        self.automaticallyAdjustsScrollViewInsets = NO;//解决tableview头部预留64像素的办法
    }
    return _myTableView;
}


#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 76;
    }
    else if (indexPath.row==6){
        return 100;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0 ) {
        PhotoSetCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"PhotoSetCell" forIndexPath:indexPath];
        cell.photoIM.layer.cornerRadius =  cell.photoIM.width/2;
        cell.photoIM.layer.masksToBounds =YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
        return cell;
    }
//    else if (indexPath.row==1){
//        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"IDcell"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"IDcell"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            UIView *lineView = [[UIView alloc] init];
//            lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
//            [cell.contentView addSubview:lineView];
//            lineView.frame =CGRectMake(0, CGRectGetMaxY(cell.contentView.frame), UIScreenW, AdaptedHeight(1));
//        }
//        cell.textLabel.text=@"FairyCoinID";
//        cell.detailTextLabel.text =@"273970";
//        return cell;
//    }
    else if (indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==4||indexPath.row==5){
        MessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
        if (indexPath.row == 5)
        {
            cell.lineView.hidden = YES;
        }else
        {
            cell.lineView.hidden = NO;
        }


        if (indexPath.row ==1)
        {
            cell.TitleLab.text = @"FairyCoinID";
            cell.DetailsLab.text = @"273970";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            cell.JianTouIM.hidden = YES;
        }
        else if (indexPath.row == 2)
        {
            cell.TitleLab.text = @"登陆账号";
            cell.DetailsLab.text = @"未设置";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            cell.JianTouIM.hidden = NO;
        }
        else if (indexPath.row == 3)
        {
            cell.TitleLab.text = @"昵称";
            cell.DetailsLab.text = @"ID123456";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            cell.JianTouIM.hidden = NO;
        }
        else if (indexPath.row == 4)
        {
            cell.TitleLab.text = @"个人简介";
            cell.DetailsLab.text = @"未设置";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            cell.JianTouIM.hidden = NO;
        }
        else if (indexPath.row == 5)
        {
            cell.TitleLab.text = @"手机号码";
            cell.DetailsLab.text = @"未设置";
            cell.DetailsLab.textColor =[UIColor colorWithHex:@"#cccccc"];
            cell.JianTouIM.hidden = NO;
        }
  
        return cell;
    }
    else if (indexPath.row==6){
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.row==7){
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"ExitCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExitCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor =[UIColor whiteColor];
            
            UILabel  *lable = [[UILabel alloc]init];
            lable.text = @"退出登录";
            lable.backgroundColor = [UIColor whiteColor];
            lable.font = AdaptedFontSize(32);
            lable.textColor = [UIColor redColor];
            lable.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(cell.contentView.mas_left).with.offset(AdaptedWidth(24));
                make.right.mas_equalTo(cell.contentView.mas_right).with.offset(-AdaptedWidth(24));
            }];
            
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    PersionDetailVC *vc =[PersionDetailVC new];
//    [self.navigationController pushViewController:vc animated:YES];
    
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
