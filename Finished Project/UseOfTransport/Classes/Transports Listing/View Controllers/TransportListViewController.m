//
//  TransportListViewController.m
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "TransportListViewController.h"
#import "TransportListView.h"
#import "KindTransport.h"

@interface TransportListViewController ()
@property (nonatomic, strong) NSArray *transportArray;

- (void)addKindOfTransport:(id)sender;
@end

@implementation TransportListViewController

@synthesize managedObjectContext;
@synthesize transportArray;

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) 
    {
        self.managedObjectContext = context;
        self.title = @"Transports";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[[TransportListView alloc] initWithFrame:self.view.frame] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TransportListView *transportView = (TransportListView *)self.view;
    
    transportView.transportTableView.delegate = self;
    transportView.transportTableView.dataSource = self;
    [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                                target:self 
                                                                                                action:@selector(addKindOfTransport:)] autorelease] animated:NO];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KindTransport"
                                              inManagedObjectContext:context];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"transportID" ascending:YES];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sorter]];
    
    self.transportArray = [context executeFetchRequest:fetchRequest error:&error];
    
    TransportListView *transportView = (TransportListView *)self.view;
    [[transportView transportTableView] reloadData];
    [fetchRequest release];
    [sorter release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [transportArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    KindTransport *transport = [transportArray objectAtIndex:indexPath.row];
    [[cell textLabel] setText:transport.transportName];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", transport.transportID.intValue]];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - AddKindOfTransportViewController Delegate Methods
- (void)modalViewControllerShouldClose
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Private method
- (void)addKindOfTransport:(id)sender
{
    AddKindOfTransportViewController *addTransportVC = [[AddKindOfTransportViewController alloc] initWithContext:managedObjectContext];
    [addTransportVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [addTransportVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [addTransportVC setDelegate:self];
    
    [self presentModalViewController:addTransportVC animated:YES];
    
    [addTransportVC release];
}



- (void)dealloc
{
    [transportArray release];
    [managedObjectContext release];
    [super dealloc];
}

@end
