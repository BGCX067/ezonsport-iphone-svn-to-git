//
//  SexController.m
//  EzonSportIphone
//
//  Created by apple on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SexController.h"
#import "BirthdayController.h"
@interface SexController ()

@end

@implementation SexController
@synthesize sex;
@synthesize myPickerView;
@synthesize sexDefault;
@synthesize finishedNumber;
@synthesize myPickerData;
//@synthesize myPickerData_2;
@synthesize myPickerData_3;
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
    //self.height.inputView =  ;
    self.finishedNumber.maximumValue = 100;
    self.finishedNumber.minimumValue = 0;
    self.finishedNumber.value = 40;
    self.finishedNumber.enabled = NO;
    
    sexDefault = @"男";

    
    //初始化数据
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for(int i = 120;i<250 ;i++){
        [array addObject:[[NSString alloc] initWithFormat:@"%d",i]];
    }
//    NSArray *array2 = [[NSArray alloc] initWithObjects:@".1",@".2",@".3",@".4",@".5",@".6",@".7",@".8",@".9", nil];
    NSArray *array3 = [[NSArray alloc] initWithObjects:@"cm", nil];
    self.myPickerData = array;
    //self.myPickerData_2 = array2;
    self.myPickerData_3 = array3;
}

- (void)viewDidUnload
{
    [self setSex:nil];
    [self setFinishedNumber:nil];
    [self setMyPickerView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)nextButton:(id)sender {
    BirthdayController *sc = [[BirthdayController alloc]init];
    //获取身高计上的数据
    NSInteger row = [myPickerView selectedRowInComponent:0]; 
    //NSInteger row_2 = [myPickerView selectedRowInComponent:1];
    //NSInteger row_3 = [myPickerView selectedRowInComponent:1];
    NSString *selected = [myPickerData objectAtIndex:row];
    //NSString *selected_2 = [myPickerData_2 objectAtIndex:row_2];
    //NSString *selected_3 = [myPickerData_3 objectAtIndex:row_3];
    
//    [[NSUserDefaults standardUserDefaults] setValue:[selected stringByAppendingFormat:selected_2 ] forKey:@"heightOfUser"];
    [[NSUserDefaults standardUserDefaults] setValue:selected forKey:@"heightOfUser"];
    [[NSUserDefaults standardUserDefaults] setValue:sexDefault forKey:@"sexOfUser"];
    [self.navigationController pushViewController:sc animated:YES];

}

- (IBAction)sexSelected:(id)sender {
    NSInteger number = [sex selectedSegmentIndex];
    switch (number) {
        case 0:
            break;
        case 1:
            sexDefault = @"女";
            break;
        default:
            break;
    }
}


#pragma mark - 
#pragma mark Picker Data Source Methods 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView { 
    return 2; 
} 

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{ 
    if(component == 0){
        return [myPickerData count];
    }else if(component == 1){
        return [myPickerData_3 count];
    }
    //return [myPickerData_3 count];
} 

#pragma mark Picker Delegate Methods 
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row             forComponent:(NSInteger)component { 
    if(component == 0){
        return [myPickerData objectAtIndex:row]; 
    }else if(component == 1){
        return [myPickerData_3 objectAtIndex:row];
    }
    //return [myPickerData_3 objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    if(component == 0){
        label.text = [myPickerData objectAtIndex:row];
    }else if(component == 1) {
        label.text = [myPickerData_3 objectAtIndex:row];
    }
    
    label.font =[UIFont boldSystemFontOfSize:24];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
@end
