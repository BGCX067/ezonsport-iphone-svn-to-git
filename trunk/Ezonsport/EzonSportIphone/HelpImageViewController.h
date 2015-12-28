//
//  HelpImageViewController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpImageViewController : UIViewController
- (id)initWithPageNumber:(int)page;
@property (strong, nonatomic) IBOutlet UIImageView *helpImage;

@end
