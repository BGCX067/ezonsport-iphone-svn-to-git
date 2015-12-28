//
//  SportDataViewModel.h
//  EzonSportIphone
//
//  Created by apple on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SportDataViewModel : NSObject

@property (nonatomic,retain) NSMutableArray *sportDataArray;//可变数组，存放运动数据
@property int location;//记录当前数组位置

@end
