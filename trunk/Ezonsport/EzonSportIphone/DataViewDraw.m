//
//  DataViewDraw.m
//  EzonSportIphone
//
//  Created by apple on 12-7-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataViewDraw.h"
//定义坐标轴的y常量
#define CODBASE 310
//定义高度放大比例
#define HIGHTSCALE 1.5
#define ZEROHIGHT 100
@implementation DataViewDraw
@synthesize date1;
@synthesize date2;
@synthesize date3;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //NSLog(@"drawRect");
    //画坐标线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGFloat components[] = {0.0,0.0,1.0,0.5};
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, 0, CODBASE);
    CGContextAddLineToPoint(context, 320, CODBASE);
    CGContextStrokePath(context);
    
    //画日期文字
    [date1 drawAtPoint:CGPointMake(220, CODBASE) withFont:[UIFont systemFontOfSize:16]]; 
    [date2 drawAtPoint:CGPointMake(120, CODBASE) withFont:[UIFont systemFontOfSize:16]]; 
    [date3 drawAtPoint:CGPointMake(20, CODBASE) withFont:[UIFont systemFontOfSize:16]]; 
    
    //画柱状箭头，从右往左画,使用每天的目标完成比例作为高度
    int percent1 = (int) ((float) step1 / goal1 * 100);
    int percent2 = (int) ((float) step2 / goal2 * 100);
    int percent3 = (int) ((float) step3 / goal3 * 100);
    //rowHighPercent1为柱图1高度，如果超过100,以100计
    int rowHighPercent1;
    if (percent1 >= 100)
        rowHighPercent1 = 100;
    else
        rowHighPercent1 = percent1;
    //rowHighPercent2为柱图2高度，如果超过100,以100计
    int rowHighPercent2;
    if (percent2 >= 100)
        rowHighPercent2 = 100;
    else
        rowHighPercent2 = percent2;
    //rowHighPercent3为柱图3高度，如果超过100,以100计
    int rowHighPercent3;
    if (percent3 >= 100)
        rowHighPercent3 = 100;
    else
        rowHighPercent3 = percent3;

    CGContextMoveToPoint(context, 220, CODBASE);
    CGContextAddLineToPoint(context, 300, CODBASE);
    CGContextAddLineToPoint(context, 300, CODBASE-(ZEROHIGHT+(float)rowHighPercent1*HIGHTSCALE));
    CGContextAddLineToPoint(context, 260, CODBASE-(ZEROHIGHT+(float)rowHighPercent1*HIGHTSCALE)-40);
    CGContextAddLineToPoint(context, 220, CODBASE-(ZEROHIGHT+(float)rowHighPercent1*HIGHTSCALE));
    CGContextAddLineToPoint(context, 220, CODBASE);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    CGContextMoveToPoint(context, 120, CODBASE);
    CGContextAddLineToPoint(context, 200, CODBASE);
    CGContextAddLineToPoint(context, 200, CODBASE-(ZEROHIGHT+(float)rowHighPercent2*HIGHTSCALE));
    CGContextAddLineToPoint(context, 160, CODBASE-(ZEROHIGHT+(float)rowHighPercent2*HIGHTSCALE)-40);
    CGContextAddLineToPoint(context, 120, CODBASE-(ZEROHIGHT+(float)rowHighPercent2*HIGHTSCALE));
    CGContextAddLineToPoint(context, 120, CODBASE);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    CGContextMoveToPoint(context, 20, CODBASE);
    CGContextAddLineToPoint(context, 100, CODBASE);
    CGContextAddLineToPoint(context, 100, CODBASE-(ZEROHIGHT+(float)rowHighPercent3*HIGHTSCALE));
    CGContextAddLineToPoint(context, 60, CODBASE-(ZEROHIGHT+(float)rowHighPercent3*HIGHTSCALE)-40);
    CGContextAddLineToPoint(context, 20, CODBASE-(ZEROHIGHT+(float)rowHighPercent3*HIGHTSCALE));
    CGContextAddLineToPoint(context, 20, CODBASE);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    //绘制每天的计步数据文字,从右往左
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSelectFont(context, "Helvetica", 24, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    NSString *step1String = [NSString stringWithFormat:@"%d",step1];
    CGContextShowTextAtPoint(context, 230, CODBASE-20, [step1String cStringUsingEncoding:[NSString defaultCStringEncoding]], [step1String length]);
    
    NSString *step2String = [NSString stringWithFormat:@"%d",step2];
    CGContextShowTextAtPoint(context, 130, CODBASE-20, [step2String cStringUsingEncoding:[NSString defaultCStringEncoding]], [step2String length]);
    NSString *step3String = [NSString stringWithFormat:@"%d",step3];
    CGContextShowTextAtPoint(context, 30, CODBASE-20, [step3String cStringUsingEncoding:[NSString defaultCStringEncoding]], [step3String length]);
    
    //绘制完成百分比文字
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSelectFont(context, "Helvetica", 32, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    NSString *goal1String = [NSString stringWithFormat:@"%d", percent1];
    CGContextShowTextAtPoint(context, 230, CODBASE-(ZEROHIGHT+(float)rowHighPercent1*HIGHTSCALE-30), [goal1String cStringUsingEncoding:[NSString defaultCStringEncoding]], [goal1String length]);
    
    NSString *goal2String = [NSString stringWithFormat:@"%d", percent2];
    CGContextShowTextAtPoint(context, 130, CODBASE-(ZEROHIGHT+(float)rowHighPercent2*HIGHTSCALE-30), [goal2String cStringUsingEncoding:[NSString defaultCStringEncoding]], [goal2String length]);
    
    NSString *goal3String = [NSString stringWithFormat:@"%d", percent3];
    CGContextShowTextAtPoint(context, 30, CODBASE-(ZEROHIGHT+(float)rowHighPercent3*HIGHTSCALE-30), [goal3String cStringUsingEncoding:[NSString defaultCStringEncoding]], [goal3String length]);
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSelectFont(context, "Helvetica", 20, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
    NSString *percentSymbol = [NSString stringWithString:@"%"];
    CGContextShowTextAtPoint(context, 280, CODBASE-(ZEROHIGHT+(float)rowHighPercent1*HIGHTSCALE-20), [percentSymbol cStringUsingEncoding:[NSString defaultCStringEncoding]], [percentSymbol length]);
    CGContextShowTextAtPoint(context, 180, CODBASE-(ZEROHIGHT+(float)rowHighPercent2*HIGHTSCALE-20), [percentSymbol cStringUsingEncoding:[NSString defaultCStringEncoding]], [percentSymbol length]);
    CGContextShowTextAtPoint(context, 80, CODBASE-(ZEROHIGHT+(float)rowHighPercent3*HIGHTSCALE-20), [percentSymbol cStringUsingEncoding:[NSString defaultCStringEncoding]], [percentSymbol length]);
    
    
    //Release
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);

}
//判断屏幕触摸点是否落在相应柱状内
-(NSInteger)checkPointPosIndex:(CGPoint) location{
    int percent1 = (int) ((float) step1 / goal1 * 100);
    int percent2 = (int) ((float) step2 / goal2 * 100);
    int percent3 = (int) ((float) step3 / goal3 * 100);
    //rowHighPercent1为柱图1高度，如果超过100,以100计
    int rowHighPercent1;
    if (percent1 >= 100)
        rowHighPercent1 = 100;
    else
        rowHighPercent1 = percent1;
    //rowHighPercent2为柱图2高度，如果超过100,以100计
    int rowHighPercent2;
    if (percent2 >= 100)
        rowHighPercent2 = 100;
    else
        rowHighPercent2 = percent2;
    //rowHighPercent3为柱图3高度，如果超过100,以100计
    int rowHighPercent3;
    if (percent3 >= 100)
        rowHighPercent3 = 100;
    else
        rowHighPercent3 = percent3;
    
    NSInteger index=0;
    CGRect rect1 = CGRectMake(220, CODBASE-(ZEROHIGHT+(float)rowHighPercent1*HIGHTSCALE), 80, ZEROHIGHT+(float)rowHighPercent1*HIGHTSCALE);
    if(CGRectContainsPoint(rect1, location))
        index = 1;
    CGRect rect2 = CGRectMake(120, CODBASE-(ZEROHIGHT+(float)rowHighPercent2*HIGHTSCALE), 80, ZEROHIGHT+(float)rowHighPercent2*HIGHTSCALE);
    if(CGRectContainsPoint(rect2, location))
        index = 2;
    CGRect rect3 = CGRectMake(20, CODBASE-(ZEROHIGHT+(float)rowHighPercent3*HIGHTSCALE), 80, ZEROHIGHT+(float)rowHighPercent3*HIGHTSCALE);
    if(CGRectContainsPoint(rect3, location))
        index = 3;
    return index;
}


-(void)setStep1:(NSInteger)value{
    step1 = value;
}
-(NSInteger)getStep1{
    return step1;
}
-(void)setStep2:(NSInteger)value{
    step2 = value;
}
-(NSInteger)getStep2{
    return step2;
}
-(void)setStep3:(NSInteger)value{
    step3 = value;
}
-(NSInteger)getStep3{
    return step3;
}
-(void)setGoal1:(NSInteger) value{
    goal1 = value;
}
-(NSInteger)getGoal1{
    return goal1;
}
-(void)setGoal2:(NSInteger) value{
    goal2 = value;
}
-(NSInteger)getGoal2{
    return goal2;
}
-(void)setGoal3:(NSInteger) value{
    goal3 = value;
}
-(NSInteger)getGoal3{
    return goal3;
}




@end
