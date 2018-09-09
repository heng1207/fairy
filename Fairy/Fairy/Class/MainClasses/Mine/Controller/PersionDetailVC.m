//
//  PersionDetailVC.m
//  Fairy
//
//  Created by  on 2018/6/12.
//  Copyright © 2018年 . All rights reserved.
//

#import "PersionDetailVC.h"
#import "MessageCell.h"
#import "PhotoSetCell.h"
#import "DetailContentVC.h"


@interface PersionDetailVC ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@property(nonatomic,strong)UIImageView *photoIM;

@end

@implementation PersionDetailVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}
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
        _myTableView.backgroundColor =[UIColor colorWithHex:@"#e8f0f3"];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 3;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0&&indexPath.row==0) {
        return 76;
    }
    else if (indexPath.section==1&&indexPath.row==2){
        return 60;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.section==0&&indexPath.row ==0 ) {
        PhotoSetCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"PhotoSetCell" forIndexPath:indexPath];
        cell.photoIM.layer.cornerRadius =  cell.photoIM.width/2;
        cell.photoIM.layer.masksToBounds =YES;
        self.photoIM= cell.photoIM;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section==1&&indexPath.row==2){
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.section==1&&indexPath.row==3){
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"ExitCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExitCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor =[UIColor clearColor];
            
            UILabel  *lable = [[UILabel alloc]init];
            lable.text = @"退出登录";
            lable.backgroundColor = [UIColor redColor];
            lable.font = AdaptedFontSize(32);
            lable.textColor = [UIColor whiteColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.layer.cornerRadius = 5;
            lable.layer.masksToBounds = YES;
            [cell addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(cell.contentView.mas_left).with.offset(AdaptedWidth(30));
                make.right.mas_equalTo(cell.contentView.mas_right).with.offset(-AdaptedWidth(30));
            }];
            
        }
        return cell;
    }
    else {
        MessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ( (indexPath.section==0&&indexPath.row ==2) || (indexPath.section==1&&indexPath.row ==1) )
        {
            cell.lineView.hidden = YES;
        }else
        {
            cell.lineView.hidden = NO;
        }
        
        
        if (indexPath.section==0&&indexPath.row ==1)
        {
            cell.TitleLab.text = @"ID";
//            cell.DetailsLab.text = @"273970";
            cell.DetailsLab.text = [NSString stringWithFormat:@"%@",self.userInfoDic[@"fairycoinID"]];
            cell.JianTouIM.hidden = YES;
        }
        else if (indexPath.section==0&&indexPath.row == 2)
        {
            cell.TitleLab.text = @"昵称";
//            cell.DetailsLab.text = @"未设置";
            if ([Tool isBlankString:self.userInfoDic[@"nickname"]]) {
                cell.DetailsLab.text = @"未设置";
            }
            else{
                cell.DetailsLab.text = self.userInfoDic[@"nickname"];
            }
            cell.JianTouIM.hidden = NO;
        }
        else if (indexPath.section==1&&indexPath.row == 0)
        {
            cell.TitleLab.text = @"邮箱地址";
            if ([Tool isBlankString:self.userInfoDic[@"email"]]) {
                cell.DetailsLab.text = @"未设置";
            }
            else{
                cell.DetailsLab.text = self.userInfoDic[@"email"];
            }
            cell.JianTouIM.hidden = NO;
        }
        else if (indexPath.section==1&&indexPath.row == 1)
        {
            cell.TitleLab.text = @"手机号码";
            if ([Tool isBlankString:self.userInfoDic[@"phoneNumber"]]) {
                cell.DetailsLab.text = @"未设置";
            }
            else{
                cell.DetailsLab.text = self.userInfoDic[@"phoneNumber"];
            }
            
            cell.JianTouIM.hidden = NO;
        }
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0&&indexPath.row==0) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"从手机相册选择",@"拍照", nil];
        [alert show];
        
    }
    else if (indexPath.section==0&&indexPath.row==2){
        DetailContentVC *vc =[DetailContentVC new];
        vc.typeStr = @"nickname";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.section==1&&indexPath.row==0){
        DetailContentVC *vc =[DetailContentVC new];
        vc.typeStr = @"email";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.section==1&&indexPath.row==1){
        DetailContentVC *vc =[DetailContentVC new];
        vc.typeStr = @"phoneNumber";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.section==1&&indexPath.row==3){//退出登录
        [self userLogout];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 10)];
    view.backgroundColor =[UIColor colorWithHex:@"#e9edf8"];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 0;
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if(buttonIndex ==1){
        [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else if(buttonIndex ==2){
        [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
    }
}

/**
 *  拍照和相册按钮点击的公共方法
 */
- (void)openImagePickerController :(UIImagePickerControllerSourceType )type
{
    if (![UIImagePickerController isSourceTypeAvailable:type])
        return;
    
    // 创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    // 设置图片选择器的类型
    imagePicker.sourceType = type;
    // 设置图片选择器的代理
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    // modal一个图片选择器
    [self presentViewController:imagePicker animated:YES completion:^{
        [UIApplication sharedApplication].statusBarStyle = 0;
    }];
    
}


#pragma mark - UIImagePickerControllerDelegate的方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 选择照片之后dismiss图片控制器
    [picker dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].statusBarStyle = 1;
    }];
    
    // 获取选中的image图片
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    [self uploadPhotoIM:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].statusBarStyle = 1;
    }];
}

-(void)uploadPhotoIM:(UIImage*)image{
    
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"consumerID"]  = userModel.consumerID;

    NSMutableArray *photoArr=[NSMutableArray array];
    [photoArr addObject:image];

    [NetworkManage Post:uploadPhoto andParams:dict andPhotoArr:photoArr success:^(id responseObject) {
        NSMutableDictionary *dic = (NSMutableDictionary*)responseObject;
        if ([dic[@"code"] integerValue] ==200 ) {
            [self.photoIM sd_setImageWithURL:[NSURL URLWithString:dic[@"data"][@"headerPic"]] placeholderImage:[UIImage imageNamed:@"personal_img"]];
        }else {
            [self showHint:dic[@"message"]];
        }

    } failure:^(NSError *error) {
        [self showHint:@"网络有问题"];
    }];
    
}

-(void)userLogout{
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"token"]  = userModel.token;
    [NetworkManage Get:logOut andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            
            //退出成功
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"未登录" forKey:@"loginStatus"];
            
            
            [defaults synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [self showHint:obj[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
        [self showHint:@"网络有问题"];
    }];
    
}

-(void)requestData{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    dict[@"consumerID"] = userModel.consumerID;
    
    NSString *path =[NSString stringWithFormat:@"%@?token=%@",consumerView,userModel.token];
    
    [NetworkManage Get:path andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            NSLog(@"%@",obj[@"data"]);
        
            self.userInfoDic = obj[@"data"];
            [self.myTableView reloadData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"网络有问题");
    }];
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
