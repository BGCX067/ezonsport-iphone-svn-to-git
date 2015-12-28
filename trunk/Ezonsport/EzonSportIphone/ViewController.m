//
//  ViewController.m
//  EzonSportIphone
//
//  Created by tong chen on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)willUpdateView:(NSNotification *)viewModeChanged
{
    NSDictionary * model=[viewModeChanged userInfo];
    if(model!=nil)
    {
        ViewModel * changedModel=[model objectForKey:[viewModel ViewModelName]];
        
        [self updateView:changedModel];
    }
}


-(void)updateView:(ViewModel * )model
{
    NSLog(@"%@",model.description);
}

-(void)setViewModel:(ViewModel *)model{ 
    if (viewModel != model) {
        //[[NSNotificationCenter defaultCenter]removeObserver:self];
        
        //注册模型更新事件
        [[NSNotificationCenter defaultCenter]removeObserver:self name:registerEventName object:viewModel];
        
        viewModel=model;
        
        registerEventName= [[viewModel.ViewModelName stringByAppendingString:@"Changed"] copy];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(willUpdateView:) name:registerEventName object:viewModel ];
        [viewModel fireModelChanged];
        
        
        //注册错误显示的事件
        
        NSString * errorName=[viewModel.ViewModelName stringByAppendingFormat:@"Error"];
        registerEventName=[[viewModel.ViewModelName stringByAppendingString:@"ErrorHappened"] copy];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:errorName object:viewModel];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(willDisplayError:) name:registerEventName object:viewModel ];
        
        
    }
    
}
-(void)willDisplayError:(NSNotification *)errorNotification
{
    NSDictionary * errorDictionary=[errorNotification userInfo];
    
    if(errorDictionary!=nil)
    {
        NSString * errorName=[[viewModel ViewModelName] stringByAppendingFormat:@"Error"];
        NSError * error=[errorDictionary objectForKey:errorName];
        [self displayError:error];
    }
    
}
-(void)displayError:(NSError *)error{
    UIAlertView *alterView=[[UIAlertView alloc]initWithTitle:@"WrongMessage" message:@"Password is too long!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alterView show];
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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
