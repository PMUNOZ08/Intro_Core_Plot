//
//  UserListView.m
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "UserListView.h"

@implementation UserListView

@synthesize userListTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUserListTableView:[[[UITableView alloc] initWithFrame:CGRectZero] autorelease]];
        
        [self addSubview:userListTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [[self userListTableView] setFrame:CGRectMake(0.0, 
                                                     0.0, 
                                                     self.frame.size.width, 
                                                     self.frame.size.height)];
    
}

- (void)dealloc
{
    [userListTableView release];
    [super dealloc];
}

@end
