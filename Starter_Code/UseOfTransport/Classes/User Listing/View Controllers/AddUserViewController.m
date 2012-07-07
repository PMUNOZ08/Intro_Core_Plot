//
//  AddUserViewController.m
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "AddUserViewController.h"
#import "AddUserView.h"
#import "User.h"
#import "KindTransport.h"

@interface AddUserViewController ()
@property (nonatomic, strong) NSArray *daysArray;
@property (nonatomic, strong) NSArray *transportsArray;
@property (nonatomic) PickerState pickerState;

@property (nonatomic, strong) UINavigationItem *navItem;

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIActionSheet *actionSheet;

- (void)dismissPickerView:(id)sender;
- (void)addUser:(id)sender;

@end

@implementation AddUserViewController

@synthesize managedObjectContext;
@synthesize daysArray;
@synthesize transportsArray;
@synthesize pickerState;

@synthesize delegate;

@synthesize navItem;

@synthesize picker;
@synthesize actionSheet;

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) 
    {
        self.managedObjectContext = context;
        self.title = @"Add A User";
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[AddUserView alloc] initWithFrame:self.view.frame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.title];
    [navigationItem setHidesBackButton:YES];
    [self setNavItem:navigationItem];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone 
                                                                    target:self 
                                                                    action:@selector(addUser:)] autorelease] animated:NO];
    [navItem setTitle:self.title];
    
    UIActionSheet *_actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [_actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent]; 
    [self setActionSheet:_actionSheet];
    
    UIPickerView *_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.delegate = self;
    [self setPicker:_pickerView];
    
    [actionSheet addSubview:picker];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    closeButton.momentary = YES; 
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissPickerView:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [closeButton release];
    
    [_pickerView release];
    [_actionSheet release];
    
    AddUserView *addUserView = (AddUserView *)self.view;
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"transportID" ascending:YES];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KindTransport" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sorter]];
    self.transportsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.daysArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
    
    [[addUserView nameTextField] setDelegate:self];
    [[addUserView transportTextField] setDelegate:self];
    [[addUserView dayOfWeekTextField] setDelegate:self];
    
    navigationBar.barStyle = UIBarStyleBlack;
    
    [navigationItem release];
    [fetchRequest release];
    [sorter release];
}

#pragma mark - UIPickerDelegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    
    if (pickerState == PickerStateTransports) 
    {
        KindTransport *transport = [transportsArray objectAtIndex:row];
        title = [NSString stringWithFormat:@"%@ - %d", transport.transportName, [transport.transportID intValue]];        
    }
    else if (pickerState == PickerStateDays)
    {
        title = [daysArray objectAtIndex:row];        
    }
    
    return title;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerState == PickerStateTransports) 
    {
        return [transportsArray count];
    }
    else if (pickerState == PickerStateDays)
    {
        return [daysArray count];
    }
    
    return 0;
}

#pragma mark - UITextFieldDelgate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1) 
    {
        return YES;

    }
    else 
    {
        if (textField.tag == 2) 
        {
            pickerState = PickerStateTransports;
        }
        else if (textField.tag == 3)
        {
            pickerState = PickerStateDays;            
        }
        
        [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
        
        [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
        
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:0 animated:NO];
        
        return NO;
    }
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
         
#pragma mark - Private Methods
- (void)dismissPickerView:(id)sender
{
    AddUserView *addUserView = (AddUserView *)self.view;
    
    int selectedRow = [picker selectedRowInComponent:0];
    
    if (pickerState == PickerStateTransports) 
    {
        KindTransport *transport = [transportsArray objectAtIndex:selectedRow];
        
        [addUserView.transportTextField setText:[NSString stringWithFormat:@"%d", [[transport transportID] intValue]]];
    }
    else if (pickerState == PickerStateDays)
    {
        [addUserView.dayOfWeekTextField setText:[daysArray objectAtIndex:selectedRow]];      
    }
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)addUser:(id)sender
{
    AddUserView *addUserView = (AddUserView *)self.view;
    NSError *error;
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"userID" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sorter, nil];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    [sorter release];
    
    User *userToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
    [userToAdd setUserID:[NSString stringWithFormat:@"u%d", [fetchedObjects count]]];
    [userToAdd setUserName:addUserView.nameTextField.text];
    [userToAdd setDayOfWeek:[NSNumber numberWithInt:[addUserView.dayOfWeekTextField.text intValue]]];
    [userToAdd setTransportID:[NSNumber numberWithInt:[addUserView.transportTextField.text intValue]]];
    
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [delegate modalViewControllerShouldClose];
}

- (void)dealloc
{
    [daysArray release];
    [transportsArray release];
    [managedObjectContext release];
    [navItem release];
    
    [super dealloc];
}

@end
