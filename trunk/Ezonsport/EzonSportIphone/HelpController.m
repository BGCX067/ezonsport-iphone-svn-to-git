//
//  HelpController.m
//  EzonSportIphone
//
//  Created by apple on 12-7-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelpController.h"
#import "HelpImageViewController.h"

static NSUInteger kNumberOfPages = 3;
static NSString *ImageKey = @"imageKey";

@interface HelpController ()

@end

@implementation HelpController
@synthesize scrollView;
@synthesize pageControl;
@synthesize contentList;
@synthesize viewControllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"HelpImages"  ofType:@"plist" inDirectory:@"Supporting Files"];
//        self.contentList = [NSArray arrayWithContentsOfFile:path];
//        
//        NSLog(@"NSBundle path:%@",path);
//        NSLog(@"ContentList's Length: %d", [contentList count])
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"HelpImages"  ofType:@"plist" ];
//    //self.contentList = [NSArray arrayWithContentsOfFile:path];
//    self.contentList = [[NSArray alloc]initWithContentsOfFile:path];
//            
//    NSLog(@"NSBundle path:%@",path);
//    NSLog(@"ContentList's Length: %d", [contentList count]);
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"HelpImages" withExtension:@"plist"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    //NSArray *keys = [dictionary allKeys];
    //NSArray *sorted = [keys sortedArrayUsingSelector:@selector(compare:)];
    self.contentList = [dictionary objectForKey:@"Images"];
    NSLog(@"ContentList's Length: %d", [contentList count]);

    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];

}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)loadScrollViewWithPage:(int)page{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    
    // replace the placeholder if necessary
    HelpImageViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[HelpImageViewController alloc] initWithPageNumber:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
        
//        NSDictionary *numberItem = [self.contentList objectAtIndex:page];
//        controller.helpImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
        NSString *imageItem = [self.contentList objectAtIndex:page];
        controller.helpImage.image = [UIImage imageNamed:imageItem];
        
    }

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

@end
