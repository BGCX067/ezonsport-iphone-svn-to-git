//
//  ViewController.h
//  EzonSportIphone
//
//  Created by tong chen on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModel.h"
@interface ViewController : UIViewController
{
    ViewModel *viewModel;
@private NSString * registerEventName;
}
//设置viewModel
-(void)setViewModel:(ViewModel *)model; 
//更新界面
-(void)updateView:(ViewModel * )model;
//显示错误信息
-(void)displayError:(NSError *)error;

@end

@interface ViewController(private)

//更新界面的回调函数 
-(void)willUpdateView:(NSNotification *)viewModeChanged;
//错误信息的回调函数
-(void)willDisplayError:(NSNotification *)errorNotification;

@end