//
//  DataDetailController.m
//  EzonSportIphone
//
//  Created by apple on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataDetailController.h"
#import "CorePlot-CocoaTouch.h"

@interface DataDetailController ()

@end

@implementation DataDetailController
@synthesize caloriesLabel;
@synthesize stepsLabel;
@synthesize milesLabel;
@synthesize delegate;

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
    // Do any additional setup after loading the view from its nib.
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //[self drawPlotArea];
    

}

- (void)viewDidUnload
{
    [self setCaloriesLabel:nil];
    [self setStepsLabel:nil];
    [self setMilesLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)drawPlotArea{
    dataArray = [[NSMutableArray alloc]init ];
    for(int i=0; i<50; i++){
        [dataArray addObject:[NSNumber numberWithInt:rand()%2000]];
    }
    CGRect frame = CGRectMake(0, 0, 480, 250);
    //图形要放在一个CPTGraphHostingView中，其继承自UIView
    CPTGraphHostingView *hostView = [[CPTGraphHostingView alloc]initWithFrame:frame];
    //CPTGraphHostingView 添加到自己的View中
    [self.view addSubview:hostView];
    
    hostView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
    //在CPTXYGraph中画图
    CPTXYGraph *graph = [[CPTXYGraph alloc]initWithFrame:hostView.frame];
    hostView.hostedGraph = graph;
    
    //设置graph绘制区域与外边框的间隔值，注意设置恰当，否则绘图的一些信息无法显示(如坐标轴信息，x,y轴标题等)
    graph.plotAreaFrame.paddingTop	  = 15.0;
	graph.plotAreaFrame.paddingRight  = 10.0;
	graph.plotAreaFrame.paddingBottom = 20.0;
	graph.plotAreaFrame.paddingLeft	  = 35.0;
    
    //定义二维曲线
    CPTScatterPlot *scatterPlot = [[CPTScatterPlot alloc]initWithFrame:graph.bounds];
    [graph addPlot:scatterPlot];
    scatterPlot.dataSource = self;
    //添加x,y轴
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    
    //设置x坐标刻度显示的样式
    x.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    
    //x坐标轴标题和标题的偏移量
    //x.title = @"X Axis";
    //x.titleOffset = 30.0;
    //    
    CPTXYAxis *y = axisSet.yAxis;
    y.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    //    y.title = @"Y Axis";
    //    y.titleOffset = 30.0;
    
    //CPTMutableLineStyle用来设置绘制的线型
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
	symbolLineStyle.lineColor = [CPTColor blackColor];
    //CPTPlotSymbol设置绘图是数据值的显示方式(dash,ellipse,snow等等)
	CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	plotSymbol.fill		 = [CPTFill fillWithColor:[CPTColor lightGrayColor]];
	plotSymbol.lineStyle = symbolLineStyle;
	plotSymbol.size		 = CGSizeMake(5, 5);
	scatterPlot.plotSymbol	 = plotSymbol;
    
    //设置PlotSpace,xRange,yRange指定x,y轴的值显示
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    //    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat([dataArray count]-1)];
    //    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0) length:CPTDecimalFromFloat(20)];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    //plotRangeWithLocation有两个参数，第一个参数指定坐标起始刻度，第二个参数指定坐标长度
    xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat([dataArray count]-1)];
    yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(2000)];
    x.orthogonalCoordinateDecimal = xRange.location;
	y.orthogonalCoordinateDecimal = yRange.location;
    
    x.visibleRange = xRange;
    y.visibleRange = yRange;
    
    x.gridLinesRange = xRange;
    y.gridLinesRange = yRange;
    
    //  [xRange expandRangeByFactor:CPTDecimalFromDouble(1.05)];
    //	[yRange expandRangeByFactor:CPTDecimalFromDouble(1.05)];
    plotSpace.xRange = xRange;
    plotSpace.yRange = yRange;
}

- (IBAction)doneAction:(id)sender {
    if(self.delegate){
        [self.delegate dismissViewController:self];
    }
}
#pragma mark -
#pragma mark Plot Data Source Methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return [dataArray count];
}
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    if (fieldEnum == CPTScatterPlotFieldY) {
        return [dataArray objectAtIndex:index];
    }else {
        return [NSNumber numberWithInt:index];
    }
    //return [NSNumber numberWithInt:1];
}


@end
