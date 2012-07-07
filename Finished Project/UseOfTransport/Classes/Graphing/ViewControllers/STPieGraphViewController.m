//
//  STPieGraphViewController.m
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 19/06/12.
//  Copyright (c) 2012 All rights reserved.
//

#import "STPieGraphViewController.h"
#import "STGraphView'.h"
#import "STPieGraphTransportDataSource.h"

@interface STPieGraphViewController ()

@property (nonatomic, strong) STPieGraphTransportDataSource *pieChartDataSource;

@end

@implementation STPieGraphViewController

@synthesize managedObjectContext;
@synthesize delegate;
@synthesize graph;
@synthesize pieChartDataSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:@"Usuarios por tipo de transporte"];
    [self setView:[[[STGraphView alloc] initWithFrame:self.view.frame] autorelease]];
    
    [self setPieChartDataSource:[[[STPieGraphTransportDataSource alloc] initWithManagedObjectContext:[self managedObjectContext]] autorelease]];
    
    CPTTheme *defaultTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    [self setGraph:(CPTGraph *)[defaultTheme newGraph]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STGraphView *graphView = (STGraphView *)[self view];
    
    [[graphView chartHostingView] setHostedGraph:[self graph]];
    
    
    CPTPieChart *pieChart = [[CPTPieChart alloc] initWithFrame:[graph bounds]];
    [pieChart setPieRadius:100.00];
    [pieChart setIdentifier:@"Transport"];
    [pieChart setStartAngle:M_PI_4];
    [pieChart setSliceDirection:CPTPieDirectionCounterClockwise];
    [pieChart setDataSource:pieChartDataSource];
    [graph addPlot:pieChart];
    
    [graph setAxisSet:nil];
    [graph setBorderLineStyle:nil];
    
    CPTLegend *theLegend = [CPTLegend legendWithGraph:[self graph]];
    [theLegend setNumberOfColumns:2];
    [[self graph] setLegend:theLegend];
    [[self graph] setLegendAnchor:CPTRectAnchorBottom];
    [[self graph] setLegendDisplacement:CGPointMake(0.0, 60.0)];

    
    
    
    
    //Allow user to go back
    UINavigationItem *navigationItem = [[[UINavigationItem alloc] initWithTitle:self.title] autorelease];
    [navigationItem setHidesBackButton:YES];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Hecho"
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:[self delegate]
                                                                           action:@selector(doneButtonWasTapped:)] autorelease] animated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [pieChartDataSource release];
    [managedObjectContext release];
    [graph release];
    
    [super dealloc];
}

@end
