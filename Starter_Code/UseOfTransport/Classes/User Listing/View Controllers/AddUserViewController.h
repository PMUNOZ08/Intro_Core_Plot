//
//  AddUserViewController.h
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PickerStateDays = 0,
    PickerStateTransports = 1
}PickerState;

@protocol AddUserViewControllerDelegate
@required
- (void)modalViewControllerShouldClose;

@end

@interface AddUserViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>

- (id)initWithContext:(NSManagedObjectContext *)context;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, assign) id<AddUserViewControllerDelegate> delegate;

@end
