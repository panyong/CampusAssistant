//
//  AboutMeViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "AboutMeViewController.h"
#import "ImageConfig.h"


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
    
    NSString *nickname = [_manager getNickname];
    
    
    Semester *semester = [_manager getSemesterInfo];
    NSString *termStart = semester.startSchoolYear;
    NSString *termEnd = semester.endSchoolYear;
    NSString *semesterStr =semester.semesterStr;
    
    NSString *term = [NSString stringWithFormat:@"%@-%@学年 第%@学期",termStart,termEnd,semesterStr];
    NSString *maxCount = semester.maxCount;
    NSString *nowWeek = semester.nowWeek;
    NSString *logout = @"切换账号";
    
    
    self.contentArray = [[NSArray alloc] initWithObjects:nickname,term,maxCount,nowWeek,logout, nil];
    
    
}




#pragma mark - uitableview方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"settingCell";
    
    NSInteger row = [indexPath row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.contentArray objectAtIndex:row];
    cell.imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:row]];
    
    return cell;

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
