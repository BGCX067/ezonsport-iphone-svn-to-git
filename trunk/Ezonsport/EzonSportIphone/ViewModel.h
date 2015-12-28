//
//  ViewModel.h
//  EzonSportIphone
//
//  Created by tong chen on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject
{
    NSString* ViewModelName;
    NSString * registerEventName;
@private Boolean isNeededFireModelChanged;
    
}
//批更新模型开始
-(void)batchUpdateModelBegin;
//批更新模型结束
-(void)batchUpdateModelEnd;
//通知模型变化
-(void)fireModelChanged;
//通知错误发生
-(void)fireErrorHappened:(NSError *)error;
@property (strong ,nonatomic)NSString *ViewModelName;
@end
