//
//  UserListViewController.h
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddUserViewController.h"
#import "STLineGraphViewController.h"
#import "STBarGraphViewController.h"
#import "STPieGraphViewController.h"



@interface UserListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddUserViewControllerDelegate,  UIActionSheetDelegate, STLineGraphViewControllerDelegate, STBarGraphViewControllerDelegate, STPieGraphViewControllerDelegate>

- (id)initWithContext:(NSManagedObjectContext *)context;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;



@end
