//
//  TransportTableView.m
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "TransportListView.h"

@implementation TransportListView

@synthesize transportTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setTransportTableView:[[[UITableView alloc] initWithFrame:CGRectZero] autorelease]];
        
        [self addSubview:transportTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [[self transportTableView] setFrame:CGRectMake(0.0, 
                                                 0.0, 
                                                 self.frame.size.width, 
                                                 self.frame.size.height)];
    
}

- (void)dealloc
{
    [transportTableView release];
    [super dealloc];
}

@end
