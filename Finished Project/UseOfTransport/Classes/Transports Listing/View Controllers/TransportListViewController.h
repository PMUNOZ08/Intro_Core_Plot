//
//  TransportListViewController.h
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddKindOfTransportViewController.h"

@interface TransportListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddKindOfTransportViewControllerDelegate>

- (id)initWithContext:(NSManagedObjectContext *)context;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
