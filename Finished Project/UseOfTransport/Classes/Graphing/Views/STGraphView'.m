//
//  STGraphView'.m
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 17/06/12.
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "STGraphView'.h"

@implementation STGraphView

@synthesize chartHostingView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self setChartHostingView:[[[CPTGraphHostingView alloc] initWithFrame:CGRectZero] autorelease]];
        [chartHostingView setBackgroundColor:[UIColor purpleColor]];
        
        [self addSubview:chartHostingView];
        
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
    
    float chartHeight = self.frame.size.height;
    float chartWidth = self.frame.size.width;    
    
    [[self chartHostingView] setFrame:CGRectMake(0, 0, chartWidth, chartHeight)];
    [[self chartHostingView] setCenter:[self center]];
}

- (void)dealloc{
    
    [chartHostingView release];
    [super dealloc];
}

@end
