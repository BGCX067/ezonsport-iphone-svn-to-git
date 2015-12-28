//
//  OperatorLoginPlist.h
//  EzonSportIphone
//
//  Created by tong chen on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperatorLoginPlist : NSObject
+(NSDictionary *)readPlist;
+(void)writePlist:(NSString *)userName with:(NSString *)password;
@end
