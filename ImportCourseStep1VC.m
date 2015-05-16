//
//  ImportCourseStep1VC.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ImportCourseStep1VC.h"
#import "ImportCourseStep2VC.h"

@interface ImportCourseStep1VC (){
    NSDictionary *majors;
    
    NSArray *college;
    
    NSArray *grade;
    
    NSString *selectedCollege;
    
    NSString *selectedMajor;
    
    NSString *selectedGrade;
    
    NSDictionary *endYearDic;
    NSArray *startYearArray;
    NSArray *semesterArray;
    
    NSString *selectedStartYear;
    
    NSString *selectedEndYear;
    
    NSString *selectedSemester;
}

@end

@implementation ImportCourseStep1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stuPwd.delegate = self;
    
    self.stuNo.delegate = self;
    
    _schoolYear.delegate = self;
    
    self.title = @"导入课程第一步";
    
    self.bl = [[ImportCourseBL alloc]init];
    self.bl.delegate = self;
    
    self.manager = [[ObjectFileManager alloc] init];
    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
    
    [self initDataForPickerView];
    
    _stuClassNoPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    UIButton *stuClassNoButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 50, 30)];
    [stuClassNoButton setTitle:@"确定" forState:UIControlStateNormal];
    [stuClassNoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [stuClassNoButton addTarget:self action:@selector(selectStuClassNo) forControlEvents:UIControlEventTouchUpInside];
    UIView *stuClassNoPickView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height-300)];
    [stuClassNoPickView addSubview:_stuClassNoPickerView];
    [stuClassNoPickView addSubview:stuClassNoButton];
    _stuClassNoPickerView.delegate = self;
    _stuClassNoPickerView.dataSource = self;
    _stuClassNo.inputView = stuClassNoPickView;
    
    
    _schoolYearPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    UIButton *schoolYearButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 50, 30)];
    [schoolYearButton setTitle:@"确定" forState:UIControlStateNormal];
    [schoolYearButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [schoolYearButton addTarget:self action:@selector(selectSchoolYear) forControlEvents:UIControlEventTouchUpInside];
    UIView *schoolYearPickView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height-300)];
    [schoolYearPickView addSubview:_schoolYearPickerView];
    [schoolYearPickView addSubview:schoolYearButton];
    _schoolYearPickerView.delegate = self;
    _schoolYearPickerView.dataSource = self;
    _schoolYear.inputView = schoolYearPickView;
}

#pragma mark--选择按钮
-(void)selectStuClassNo{
    NSString *classNo = [NSString stringWithFormat:@"%@%@%@班",selectedCollege,selectedGrade,selectedMajor];
    _stuClassNo.text = classNo;
    _stuClassNoStr = [NSString stringWithFormat:@"%@%@",selectedGrade,selectedMajor];
    _stuClassNoStr = [_stuClassNoStr substringFromIndex:2];
    
    [_stuClassNo resignFirstResponder];
    NSLog(@"_stuClassNoStr = %@",_stuClassNoStr);
}

-(void)selectSchoolYear{
    NSString *schoolYear = [NSString stringWithFormat:@"%@--%@学年第%@学期",selectedStartYear,selectedEndYear,selectedSemester];
    _startSchoolYear = selectedStartYear;
    _endSchoolYear = selectedEndYear;
    _semester = selectedSemester;
    
    [_schoolYear resignFirstResponder];
    NSLog(@"%@--%@学年第%@学期",_startSchoolYear,_endSchoolYear,_semester);
    _schoolYear.text = schoolYear;
}

#pragma mark --初始化数据
-(void) initDataForPickerView{
    college = [NSArray arrayWithObjects:@"计算机科学与技术学院",@"电子信息与工程学院",@"能源与机械工程学院",@"环境与化学工程学院",@"电气工程学院",@"自动化工程学院",@"经济与管理学院",@"数理学院",@"外国语学院",@"国际交流学院",nil];
    
    majors = [[NSDictionary alloc] initWithObjectsAndKeys:
              [NSArray arrayWithObjects:@"051",@"052",@"053",@"054",@"221",@"222",@"251",@"252",nil], [college objectAtIndex:0],
              
              [NSArray arrayWithObjects:@"071",@"072",@"111",@"112",@"141",@"142",@"261",@"262",nil],[college objectAtIndex:1],
              
              [NSArray arrayWithObjects:@"011",@"012",@"171",@"172",nil],[college objectAtIndex:2],
              
              [NSArray arrayWithObjects:@"041",@"042",@"091",@"092",@"101",@"241",nil],[college objectAtIndex:3],
              
              [NSArray arrayWithObjects:@"191",@"192",nil],[college objectAtIndex:4],
              
              [NSArray arrayWithObjects:@"032",@"033",@"034",@"151",@"152",@"153",@"154",nil],[college objectAtIndex:5],
              
              [NSArray arrayWithObjects:@"061",@"062",@"131",@"132",nil],[college objectAtIndex:6],
              nil];
    
    grade = [NSArray arrayWithObjects:@"2011",@"2012",@"2013",@"2014", nil];
    
    selectedCollege = @"计算机科学与技术学院";
    
    selectedMajor = @"051";
    
    selectedGrade = @"2011";
    
    
    startYearArray = [[NSArray alloc] initWithObjects:@"2011",@"2012",@"2013",@"2014", nil];
    endYearDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                  [NSArray arrayWithObject:@"2012"],[startYearArray objectAtIndex:0],
                  [NSArray arrayWithObject:@"2013"],[startYearArray objectAtIndex:1],
                  [NSArray arrayWithObject:@"2014"],[startYearArray objectAtIndex:2],
                  [NSArray arrayWithObject:@"2015"],[startYearArray objectAtIndex:3]
                  ,nil];
    semesterArray = [NSArray arrayWithObjects:@"一",@"二", nil];
    
    selectedStartYear = @"2011";
    selectedEndYear = @"2012";
    selectedSemester = @"一";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma 继续按钮
- (IBAction)nextStep:(id)sender {
    
    if ([self validateText]) {
        [self keyboardHide];
        
        UserInfoModel *user = [self.manager getUserInfo];
        
        [self.bl beginStep1RequestWithStuNo:_stuNo.text andStuPwd:_stuPwd.text andClassNo:_stuClassNoStr andStartYear:_startSchoolYear andEndYear:_endSchoolYear andSemester:_semester andStuName:_stuNameField.text andUserId:user.userId];
        
        NSLog(@"下一步");
    }
}

-(BOOL) validateText{
    NSString *stuNo = self.stuNo.text;
    NSString *stuPwd = self.stuPwd.text;
    NSString *stuName = _stuNameField.text;
    NSString *stuClassNo = _stuClassNo.text;
    NSString *stuSchoolYear = _schoolYear.text;
    
    if (stuNo.length == 0) {
        [KVNProgress showErrorWithStatus:@"学号不能为空"];
        
        return NO;
    }
    
    if (stuPwd.length == 0  ) {
        [KVNProgress showErrorWithStatus:@"密码不能为空"];
        
        return NO;
    }
    
    if (stuName.length == 0) {
        [KVNProgress showErrorWithStatus:@"姓名只会用作签到，请放心填入"];
        
        return NO;
    }
    
    if (stuClassNo.length == 0  ) {
        [KVNProgress showErrorWithStatus:@"请选择专业班级"];
        
        return NO;
    }
    
    if (stuSchoolYear.length == 0) {
        [KVNProgress showErrorWithStatus:@"请选择学年"];
        
        return NO;
    }
    
    return YES;
}

#pragma mark -- UIPickerView要求实现的方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView == _stuClassNoPickerView) {
        return 3;//本选择器包含3列，学院，专业，年级
    }
    else{
        return 3;
    }
   
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (pickerView == _stuClassNoPickerView) {
        if (component == 0) {//返回每一列所包含的元素个数
            
            return grade.count;
            
        }else if(component == 1){
            
            return college.count;
            
        }else{
            
            return [[majors objectForKey:selectedCollege] count];
            
        }
    }
    else{
        if (component == 0) {//返回每一列所包含的元素个数
            
            return startYearArray.count;
            
        }else if(component == 1){
            
            return [[endYearDic objectForKey:selectedStartYear] count];
            
        }else{
            
            return semesterArray.count;
            
        }
    }

    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{          //返回指定列和指定行的数据
    
    if (pickerView == _stuClassNoPickerView) {
        if (component == 0) {
            
            return [grade objectAtIndex:row];
            
        }
        
        if (component == 1) {
            
            return [college objectAtIndex:row];
            
        }
        
        return [[majors objectForKey:selectedCollege] objectAtIndex:row];
    }
    else{
        
        if (component == 0) {//返回每一列所包含的元素个数
            
            return [startYearArray objectAtIndex:row];
            
        }else if(component == 1){
            
            return [[endYearDic objectForKey:selectedStartYear] objectAtIndex:row];
            
        }else{
            
            return [semesterArray objectAtIndex:row];
            
        }

    }
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{//当滚轮被滚动时触发该事件
    
    if (pickerView == _stuClassNoPickerView) {
        if (component == 0) {
            
            selectedGrade = [grade objectAtIndex:row];
            
        }
        
        if (component == 1) {
            
            selectedCollege = [college objectAtIndex:row];
            selectedMajor = [[majors objectForKey:selectedCollege] objectAtIndex:0];
            [_stuClassNoPickerView reloadComponent:2];
            
        }
        if (component == 2) {
            
            selectedMajor = [[majors objectForKey:selectedCollege] objectAtIndex:row];
            
        }
        
        NSLog(@"%@%@%@班",selectedCollege,selectedGrade,selectedMajor);
    }
    else{
        if (component == 0) {//返回每一列所包含的元素个数
            selectedStartYear = [startYearArray objectAtIndex:row];
            selectedEndYear = [[endYearDic objectForKey:selectedStartYear] objectAtIndex:0];
            [_schoolYearPickerView reloadComponent:1];
        }else if(component == 1){
            selectedEndYear = [[endYearDic objectForKey:selectedStartYear] objectAtIndex:row];
      
        }else{
            
            selectedSemester = [semesterArray objectAtIndex:row];
            
        }
        
        NSLog(@"%@--%@学年第%@学期",selectedStartYear,selectedEndYear,selectedSemester);
    }
}



#pragma 以下方法为importCourseDelegate中要求实现的方法
-(void)step1RequestBegin{
    NSLog(@"doing nothing");
}

-(void)step1RequestFailedWithMsg:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}

-(void)step1RequestSuccessWithPicData:(PictureModel *)pic{

    ImportCourseStep2VC *importCourseStep2VC = [[ImportCourseStep2VC alloc] initWithNibName:@"ImportCourseStep2VC" bundle:nil picData:pic];

    [self.navigationController.view addSubview:importCourseStep2VC.view] ;
    [self.navigationController addChildViewController:importCourseStep2VC] ;
}

-(void)step1RequestSuccessWithMsg:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}



#pragma 键盘隐藏
//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.stuNo resignFirstResponder];
    [self.stuPwd resignFirstResponder];
    [self.stuClassNo resignFirstResponder];
    [_stuNameField resignFirstResponder];
    [_schoolYear resignFirstResponder];
}

-(void)keyboardHide{
    [self.stuNo resignFirstResponder];
    [self.stuPwd resignFirstResponder];
    [self.stuClassNo resignFirstResponder];
    [_stuNameField resignFirstResponder];
    [_schoolYear resignFirstResponder];
}

//当点击键盘上的“return”按钮时触发
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//放弃第一响应者身份
    return YES;
}
@end
