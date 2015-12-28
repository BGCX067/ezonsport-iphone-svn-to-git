//
//  BirthdayController.m
//  EzonSportIphone
//
//  Created by apple on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BirthdayController.h"
#import "WeightController.h"
@interface BirthdayController ()

@end

@implementation BirthdayController
@synthesize selectedBirthday;
@synthesize finishNumber;


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
    // Do any additional setup after loading the view from its nib.
    
    self.finishNumber.maximumValue = 100;
    self.finishNumber.minimumValue = 0;
    self.finishNumber.value = 80;
    self.finishNumber.enabled = NO;
    
    NSDate *now = [NSDate date];
    [selectedBirthday setDate:now animated:NO];
}

- (void)viewDidUnload
{
    [self setFinishNumber:nil];
    [self setSelectedBirthday:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)nextButton:(id)sender {
    
    WeightController *wc = [[WeightController alloc]init];
    [self.navigationController pushViewController:wc animated:YES];
    
    NSDate *selected = [selectedBirthday date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    [[NSUserDefaults standardUserDefaults] setValue:destDateString forKey:@"birthdayOfUser"];
}
@end
