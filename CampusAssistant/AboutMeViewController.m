//
//  AboutMeViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "AboutMeViewController.h"
#import "ImageConfig.h"
#import "ViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController


-(instancetype)init{
    self = [super init];
    if (self) {
       
    }
    
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我";
    
    self.manager = [[ObjectFileManager alloc] init];
    [self initArray];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kFind_background_image] ]];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}



-(void)initArray{
    self.imageArray = [[NSArray alloc] initWithObjects:kAboutme_nickname_icon,kAboutme_term_icon,kAboutme_max_count_icon,kAboutme_now_week_icon,kAboutme_logout_icon, nil];
    
    NSString *nickname = [NSString stringWithFormat:@"%@",[_manager getNickname]];
    
    
    Semester *semester = [_manager getSemesterInfo];
    NSString *termStart = semester.startSchoolYear;
    NSString *termEnd = semester.endSchoolYear;
    NSString *semesterStr =semester.semesterStr;
    
    NSString *term = [NSString stringWithFormat:@"%@-%@学年 第%@学期",termStart==nil?@"2014":termStart,termEnd==nil?@"2015":termEnd,semesterStr==nil?@"1":semesterStr];
    NSString *maxCount = [NSString stringWithFormat:@"%@",semester.maxCount==nil?@"8":semester.maxCount];
    NSString *nowWeek = [NSString stringWithFormat:@"第%@周",semester.nowWeek==nil?@"1":semester.nowWeek];
    NSString *logout = @"";
    
    
    self.detailArray = [[NSArray alloc] initWithObjects:nickname,term,maxCount,nowWeek,logout, nil];
    
    self.titleArray = [[NSArray alloc] initWithObjects:@"我的账号",@"当前学期",@"每日最大节数",@"当期周数",@"切换账号", nil];
}




#pragma mark - uitableview方法
//返回tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imageArray.count;
}
//返回cell实例
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"settingCell";
    
    NSInteger row = [indexPath row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (row == 3 || row == 4) {
        [cell setUserInteractionEnabled:YES];
    }else{
        [cell setUserInteractionEnabled:NO];
    }
    
    
    cell.textLabel.text = [self.titleArray objectAtIndex:row];
    
//    [cell.textLabel setFont:[UIFont fontWithName: size:(CGFloat)]];
    cell.detailTextLabel.text = [self.detailArray objectAtIndex:row];
    [cell.detailTextLabel setAdjustsFontSizeToFitWidth:YES];
    cell.imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:row]];
    
    return cell;

}

//设置行点击响应函数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    if (row == 3) {
        NSLog(@"跳转到设置当前周数界面");
        
        _setNowWeelVC = [[SetNowWeekViewController alloc] initWithNibName:@"SetNowWeekViewController" bundle:nil];
        
        _setNowWeelVC.delegate = self;
        
        [self.navigationController pushViewController:_setNowWeelVC animated:YES];
        
//        [self initPickerView];
    }
    
    if (row == 4) {
        NSLog(@"清除登录数据，并跳转到登录界面");
        
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"确认" message:@"切换账号后所有数据都会清空，是否确认切换" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        alterView.delegate =self;
//        [alterView show];
        
        [_manager removeAllFile];
        
        //实例化导航控制器
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *loginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
       
    }
    
}

#pragma mark - uialterviewdelegate方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
//        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        return;
    }
    
    [_manager removeAllFile];
    
    //实例化导航控制器
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}


#pragma mark - setNowWeekDelegate要求实现的方法
-(void)setnowWeekCompile:(NSString *)nowWeek{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _detailArray.count; i++) {
        if (i == 3) {
            [tempArray addObject:nowWeek];
        }else{
            [tempArray addObject:[_detailArray objectAtIndex:i]];
        }
    }
    
    _detailArray = tempArray;
    
    [_tableView reloadData];
    
     Semester *tempSemester = [_manager getSemesterInfo];
    tempSemester.nowWeek = nowWeek;
    
    [_manager setSemester:tempSemester];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
