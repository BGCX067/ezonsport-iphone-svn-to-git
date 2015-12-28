//
//  ExitAccountController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ExitAccountController.h"
#import "EzonAppDelegate.h"
@interface ExitAccountController ()

@end

@implementation ExitAccountController
@synthesize systemManageService=_systemManageService;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _systemManageService=[[SystemManageService alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancleCurrentAccount:(id)sender {
    [EzonAppDelegate showLoginView];
}
@end
