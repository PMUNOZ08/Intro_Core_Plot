//
//  AddKindOfTransportViewController.h
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddKindOfTransportViewControllerDelegate
@required
- (void)modalViewControllerShouldClose;

@end

@interface AddKindOfTransportViewController : UIViewController <UITextFieldDelegate>

- (id)initWithContext:(NSManagedObjectContext *)context;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, assign) id<AddKindOfTransportViewControllerDelegate> delegate;

@end
