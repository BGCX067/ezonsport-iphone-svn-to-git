//
//  DataDetailPlotDraw.m
//  EzonSportIphone
//
//  Created by apple on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataDetailPlotDraw.h"
#import "CorePlot-CocoaTouch.h"

@implementation DataDetailPlotDraw
@synthesize stepDataArray;
@synthesize benginTime;
@synthesize endTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    stepDataArray = [[NSMutableArray alloc]init ];
    for(int i=0; i<50; i++){
        [stepDataArray addObject:[NSNumber numberWithInt:rand()%2000]];
    }
    CGRect frame = CGRectMake(0, 0, 480, 250);
    //图形要放在一个CPTGraphHostingView中，其继承自UIView
    CPTGraphHostingView *hostView = [[CPTGraphHostingView alloc]initWithFrame:frame];
    //CPTGraphHostingView 添加到自己的View中
    [self addSubview:hostView];
    hostView.backgroundColor = [UIColor colorWithRed:0.5 green:0.2 blue:1 alpha:0.8];
    //在CPTXYGraph中画图
    CPTXYGraph *graph = [[CPTXYGraph alloc]initWithFrame:hostView.frame];
    hostView.hostedGraph = graph;
    
    //设置graph绘制区域与外边框的间隔值，注意设置恰当，否则绘图的一些信息无法显示(如坐标轴信息，x,y轴标题等)
    graph.plotAreaFrame.paddingTop	  = 15.0;
	graph.plotAreaFrame.paddingRight  = 10.0;
	graph.plotAreaFrame.paddingBottom = 20.0;
	graph.plotAreaFrame.paddingLeft	  = 50.0;
    
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
    xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat([stepDataArray count]-1)];
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
#pragma mark -
#pragma mark Plot Data Source Methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return [stepDataArray count];
}
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index{
    if (fieldEnum == CPTScatterPlotFieldY) {
        return [stepDataArray objectAtIndex:index];
    }else {
        return [NSNumber numberWithInt:index];
    }
    //return [NSNumber numberWithInt:1];
}
-(void)setMaxStep:(NSInteger)value{
    maxStep = value;
}
-(NSInteger)getMaxStep{
    return maxStep;
}


@end
