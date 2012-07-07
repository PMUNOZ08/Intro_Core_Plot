//
//  STLineGraphView.m
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 17/06/12.
//  Copyright (c) 201  All rights reserved.
//

#import "STLineGraphView.h"



@implementation STLineGraphView

@synthesize chartHostingView = _chartHostingView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setChartHostingView:[[[CPTGraphHostingView alloc] initWithFrame:CGRectZero] autorelease]];
        [self addSubview:_chartHostingView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float chartHeight = self.frame.size.height - 40;
    float chartWidth = self.frame.size.width;    
    
    [[self chartHostingView] setFrame:CGRectMake(0, 0, chartWidth, chartHeight)];
    [[self chartHostingView] setCenter:[self center]];
}

@end
