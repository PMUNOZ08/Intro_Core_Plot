//
//  AddKindOfTransportViewController.m
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "AddKindOfTransportViewController.h"
#import "AddKindOfTransportView.h"
#import "KindTransport.h"

@interface AddKindOfTransportViewController ()
@property (nonatomic, strong) UINavigationItem *navItem;

- (void)addKindOfTransport:(id)sender;

@end

@implementation AddKindOfTransportViewController

@synthesize navItem;
@synthesize managedObjectContext;
@synthesize delegate;

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) 
    {
        self.managedObjectContext = context;
        self.title = @"Add A Kind of Trnasport";
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[[AddKindOfTransportView alloc] initWithFrame:self.view.frame] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AddKindOfTransportView *addTransportView = (AddKindOfTransportView *)self.view;    
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.title];
    [navigationItem setHidesBackButton:YES];
    [self setNavItem:navigationItem];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone 
                                                                    target:self 
                                                                    action:@selector(addKindOfTransport:)] autorelease] animated:NO];
    [navItem setTitle:self.title];
    
    [[addTransportView nameTextField] setDelegate:self];
    navigationBar.barStyle = UIBarStyleBlack;
    
    [navigationItem release];
}

- (void)addKindOfTransport:(id)sender
{
    AddKindOfTransportView *addTransportView = (AddKindOfTransportView *)self.view;
    NSError *error;
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"transportID" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sorter, nil];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KindTransport"
                                              inManagedObjectContext:managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    [sorter release];
    
    KindTransport *transportToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"KindTransport" inManagedObjectContext:managedObjectContext];
    [transportToAdd setTransportID:[NSNumber numberWithInt:[fetchedObjects count]]];
    [transportToAdd setTransportName:addTransportView.nameTextField.text];
    
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [delegate modalViewControllerShouldClose];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)dealloc
{
    [managedObjectContext release];
    [navItem release];
    
    [super dealloc];
}

@end
