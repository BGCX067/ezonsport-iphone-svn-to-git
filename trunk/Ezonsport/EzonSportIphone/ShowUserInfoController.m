//
//  InformationController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define PersonImg 0
#define PersonalInformation 1
#define PersonalGoal 2

#import "ShowUserInfoController.h"
#import "InformationTableCell.h"
#import "UserImgCellController.h"

@interface ShowUserInfoController ()

@end

@implementation ShowUserInfoController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化服务
    systemManageService=[SystemManageService instance];  
    showUserInfoViewModel=[[ShowUserInfoViewModel alloc] init];
    showUserInfoViewModel.userInfoArray=[self updateView];
    
//    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
//                                                        style:UIBarButtonItemStylePlain
//                                                        target:self
//                                                        action:@selector(editAction)];
//    
//    self.navigationItem.rightBarButtonItem = editBtn;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

//编辑个人信息
//-(void)editAction
//{
//    UserInfoViewController *userInfoViewController=[[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil];
//    [self.navigationController pushViewController:userInfoViewController animated:NO];
//}

-(NSArray *)updateView
{
    //获取用户信息(此处的用户名是全局变量，即当用户登陆后，保存用户的信息)
    showUserInfoViewModel.user=[systemManageService queryUserByUserName:[[SystemManageService getCurrentUser] valueForKey:@"userName"]];
    
    //用户图像
    //NSString *userImagePath=[dbUser valueForKey:@"image"];
    //UIImage *userImg=[UIImage imageWithContentsOfFile:userImagePath];
    //id image=[_userImage initWithImage:userImg];
    
    //昵称
    NSString *nickName=[showUserInfoViewModel.user valueForKey:@"nickName"];
    //性别
    NSString *sex = [showUserInfoViewModel.user valueForKey:@"gender"];
    //身高
    NSString *height= [[NSString alloc] initWithFormat:@"%@",[showUserInfoViewModel.user valueForKey:@"height"]];
    //体重
    NSString *weight = [[NSString alloc] initWithFormat:@"%@",[showUserInfoViewModel.user valueForKey:@"weight"]];
    //出生日期
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *birthDate = [dateFormatter stringFromDate:[showUserInfoViewModel.user valueForKey:@"birthDate"]];
    
    //运动目标
    NSString *goal = [NSString stringWithFormat:@"%d",[systemManageService getCurrentGoalStep]];
    return [NSArray arrayWithObjects:nickName,sex,height,weight,birthDate,goal, nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    showUserInfoViewModel.userInfoArray=[self updateView];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



//table view  数据显示
#pragma mark - 
#pragma mark Table View Data Source Methods 
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    switch (section) {
        case PersonImg:
            return 1;
        case PersonalInformation:
            return 4;
            break;
        case PersonalGoal:
            return 1;
        default:
            return 0;
            break;
    }
}

//新建某一行并返回。。222
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    //section 1
    static NSString *InformationTableCellIdentifier = @"InformationTableCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"InformationTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:InformationTableCellIdentifier];
        nibsRegistered = YES;
    }
    InformationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationTableCellIdentifier];
    
    //section 2
    static NSString *UserImgCellControllerIdentifier = @"UserImgCellControllerIdentifier";
    
    static BOOL nibsRegistered2 = NO;
    if (!nibsRegistered2) {
        UINib *nib = [UINib nibWithNibName:@"UserImgCellController" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:UserImgCellControllerIdentifier];
        nibsRegistered2 = YES;
    }
    UserImgCellController *imgCell = [tableView dequeueReusableCellWithIdentifier:UserImgCellControllerIdentifier];
    
    NSUInteger group = [indexPath section];//组号
    NSUInteger row = [indexPath row];//每组的行号
    switch (group) {
        case 0:
            if (row==0) {
                //昵称
                imgCell.nickNameLabel.text=[showUserInfoViewModel.userInfoArray objectAtIndex:row];
                
                //响应ImageView的点击事件（手势）
                userImgView=(UIImageView *)[[imgCell contentView] viewWithTag:1]; 
                userImgView.userInteractionEnabled=YES;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage)];
                [userImgView addGestureRecognizer:singleTap];
            }
            //imgCell
            return  imgCell;
            break;
        case 1:
        {
            if(row == 0){
                cell.titleLabel.text =@"性别：";
            }else if (row == 1) {
                cell.titleLabel.text =@"身高(CM)：";
            }else if (row == 2) {
                cell.titleLabel.text =@"体重(KG)：";
            }else if (row == 3) {
                cell.titleLabel.text =@"生日：";
            }
            row=row+1;
            cell.contentLabel.text = [showUserInfoViewModel.userInfoArray objectAtIndex:row];
        }
            break;
        case 2:
            if(row == 0){
                cell.titleLabel.text =@"目标步数(每天)：";
            }
            row = row + 5;
            cell.contentLabel.text = [showUserInfoViewModel.userInfoArray objectAtIndex:row];
            break;
        default:
            break;
    }
        return cell;
}

//处理ImageView点击事件
-(void)onClickImage
{
    
    //选择相机 或 相册
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"插入图片" message:@"\n" delegate:self cancelButtonTitle:@"相 机 拍 摄" otherButtonTitles:@"手 机 相 册",nil];
//    UIButton *photoButton = [[UIButton alloc] initWithFrame:CGRectMake(8.0, 40.0, 250.0, 30.0)];
//    UIButton *cameraButton= [[UIButton alloc] initWithFrame:CGRectMake(8.0, 45.0, 250.0, 100.0)];
//    
//    //UIImage *photoImage=[UIImage imageNamed:@"photo.png"];
//    //UIImage *cameraImage=[UIImage imageNamed:@"camera.png"];
//    [photoButton setTitle:@"photo" forState:UIControlStateNormal];
//    [cameraButton setTitle:@"camera" forState:UIControlStateNormal];
//    [photoButton setBackgroundColor:[UIColor grayColor]];
//    //[cameraButton setBackgroundColor:[UIColor grayColor]];
//    //[photoButton setBackgroundImage:photoImage forState:UIControlStateNormal];
//    //[cameraButton setBackgroundImage:cameraImage forState:UIControlStateNormal];
//    
//    [alert addSubview:photoButton];
//    [alert addSubview:cameraButton];
    [alert show];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
    if (buttonIndex == 0) {
        //如果没有相机拍摄功能，则选择图片库
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
               
    }else if (buttonIndex == 1) {
        picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentModalViewController:picker animated:YES];

}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissModalViewControllerAnimated:YES];
    userImgView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissModalViewControllerAnimated:YES];
    
}




#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger group = [indexPath section];
    if(group == 0)
    {
        return 80;
    }
    return 38.0;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

// Section Titles
//每个section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
//            case PersonImg:
//            return @"用户名";
            break;
        case PersonalInformation:
            return @"基本信息";
            break;
        case PersonalGoal:
            return  @"锻炼目标";
            break;
        default:
            return nil;
            break;
    }
    return @"用户基本信息";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 18.0;
}

//回退导航栏
//-(void)selectLeftAction:(id)sender  
//{  
//    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你选择了回退" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];  
//    [alter show];  
//} 
@end
