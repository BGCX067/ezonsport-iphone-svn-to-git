//
//  HelpController.h
//  EzonSportIphone
//
//  Created by apple on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpController : UIViewController <UIScrollViewDelegate>
{
    BOOL pageControlUsed;
}

@property (strong, nonatomic) NSArray *contentList;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

@end
