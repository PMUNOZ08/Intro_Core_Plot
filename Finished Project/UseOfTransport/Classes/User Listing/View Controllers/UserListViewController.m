//
//  UserListViewController.m
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "UserListViewController.h"
#import "UserListView.h"
#import "User.h"

@interface UserListViewController ()
@property (nonatomic, strong) NSArray *userArray;

- (void)addUser:(id)sender;
- (void)graphButtonWasSelected:(id)sender;

@end

@implementation UserListViewController

@synthesize managedObjectContext;
@synthesize userArray;

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) 
    {
        self.managedObjectContext = context;
        self.title = @"Users";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[[UserListView alloc] initWithFrame:self.view.frame] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UserListView *userView = (UserListView *)self.view;
    
    [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUser:)] autorelease] animated:NO];
    
    [[self navigationItem] setLeftBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Graphs" style:UIBarButtonItemStylePlain target:self action:@selector(graphButtonWasSelected:)] autorelease] animated:NO];
    
    userView.userListTableView.delegate = self;
    userView.userListTableView.dataSource = self;
    
    NSError *error;
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"userID" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sorter, nil];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    self.userArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [fetchRequest release];
    [sorter release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error;
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"userID" ascending:YES];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sorter]];
    
    self.userArray = [context executeFetchRequest:fetchRequest error:&error];
    
    UserListView *userView = (UserListView *)self.view;
    
    [[userView userListTableView] reloadData];
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
    return [userArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    User *user = [userArray objectAtIndex:indexPath.row];
    [[cell textLabel] setText:user.userName];
    [[cell detailTextLabel] setText:user.userID];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)doneButtonWasTapped:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - AddUserViewController Delegate Methods
- (void)modalViewControllerShouldClose
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Private Methods
- (void)addUser:(id)sender
{
    AddUserViewController *addUserVC = [[AddUserViewController alloc] initWithContext:managedObjectContext];
    [addUserVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [addUserVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [addUserVC setDelegate:self];
    
    [self presentModalViewController:addUserVC animated:YES];
    
    [addUserVC release];
}


- (void)graphButtonWasSelected:(id)sender
{
    UIActionSheet *graphSelectionActionSheet = [[[UIActionSheet alloc] initWithTitle:@"Escoge un gráfico" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Uso diario de transporte", @"Usuarios por tipo de trnasporte -Bar", @"Usuarios por tipo de trnasporte -Pie", nil] autorelease];
    
    [graphSelectionActionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - UIActionSheetDelegateM ethods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        STLineGraphViewController *graphVC = [[STLineGraphViewController alloc] init];
        [graphVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [graphVC setModalPresentationStyle:UIModalPresentationFullScreen];
        [graphVC setDelegate:self];
        [graphVC setManagedObjectContext:[self managedObjectContext]];
        
        [self presentModalViewController:graphVC animated:YES];
        
        
    }
    else if (buttonIndex == 1)
    {
        STBarGraphViewController *graphVC = [[STBarGraphViewController alloc] init];
        [graphVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [graphVC setModalPresentationStyle:UIModalPresentationFullScreen];
        [graphVC setDelegate:self];
        [graphVC setManagedObjectContext:[self managedObjectContext]];
        
        [self presentModalViewController:graphVC animated:YES];
        
    }
    else if (buttonIndex == 2)
    {
        STPieGraphViewController *graphVC = [[STPieGraphViewController alloc] init];
        [graphVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [graphVC setModalPresentationStyle:UIModalPresentationFullScreen];
        [graphVC setDelegate:self];
        [graphVC setManagedObjectContext:[self managedObjectContext]];
        
        [self presentModalViewController:graphVC animated:YES];
        
    }
}

- (void)dealloc
{
    [userArray release];
    [managedObjectContext release];
    [super dealloc];
}
@end
