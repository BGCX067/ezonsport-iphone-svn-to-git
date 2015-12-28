//
//  ViewModel.m
//  EzonSportIphone
//
//  Created by tong chen on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "ViewModel.h"

@implementation ViewModel
@synthesize ViewModelName;

-(id)init{
    if(self=[super init])
    {
        self.ViewModelName=[isa description];
        isNeededFireModelChanged=true;
    }
    return  self;
}


-(void)batchUpdateModelBegin{
    isNeededFireModelChanged=false;
}

-(void)batchUpdateModelEnd{
    isNeededFireModelChanged=true;
    [self fireModelChanged];
}


-(void)fireModelChanged{
    
    if (isNeededFireModelChanged) {
        
        registerEventName= self.ViewModelName;     
        registerEventName=[registerEventName stringByAppendingString:@"Changed"];
        
        NSDictionary * transferViewModel=[NSDictionary dictionaryWithObject:self forKey:self.ViewModelName];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:registerEventName object:self userInfo:transferViewModel];
        
    }
    
}

-(void)fireErrorHappened:(NSError *)error{
    registerEventName= self.ViewModelName;     
    registerEventName=[registerEventName stringByAppendingString:@"ErrorHappened"];
    
    
    NSString * errorName=[self.ViewModelName stringByAppendingFormat:@"Error"];
    
    NSDictionary * transferError=[NSDictionary dictionaryWithObject:error forKey:errorName];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:registerEventName object:self userInfo:transferError];
    
}
@end


