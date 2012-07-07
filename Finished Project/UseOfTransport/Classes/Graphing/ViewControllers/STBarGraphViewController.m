//
//  STBarGraphViewController.m
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 17/06/12.
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "STBarGraphViewController.h"
#import "STGraphView'.h"

@interface STBarGraphViewController ()

@property (nonatomic, retain) STBarTransportDataSource *barGraphDataSource;

@end


@implementation STBarGraphViewController

@synthesize delegate;
@synthesize managedObjectContext;
@synthesize graph;
@synthesize barGraphDataSource;

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
    [self setBarGraphDataSource:[[[STBarTransportDataSource alloc] initWithManagedObjectContext:[self managedObjectContext]] autorelease]];
    
    CPTTheme *defaultTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    
    [self setGraph:(CPTGraph *)[defaultTheme newGraph]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    STGraphView *graphView = (STGraphView *)[self view];
    [[self graph] setDelegate:self];
    
    [[graphView chartHostingView] setHostedGraph:[self graph]];
    
    CPTBarPlot *subjectBarPlot = [[CPTBarPlot alloc] initWithFrame:[graph bounds]];
    [subjectBarPlot setIdentifier:@"UssTransportDayly"];
    [subjectBarPlot setDelegate:self];
    [subjectBarPlot setDataSource:[self barGraphDataSource]];  
    
    [[self graph] addPlot:subjectBarPlot];
    
    CPTXYPlotSpace *userPlotSpace = (CPTXYPlotSpace *)[graph defaultPlotSpace]; 
      [userPlotSpace setXRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt([[self barGraphDataSource] getTotalTransports] + 1)]]; 
    [userPlotSpace setYRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt([[self barGraphDataSource] getMaxUsers] + 1)]];
    

    [[graph plotAreaFrame] setPaddingLeft:40.0f];
    [[graph plotAreaFrame] setPaddingTop:10.0f];
    [[graph plotAreaFrame] setPaddingBottom:120.0f];
    [[graph plotAreaFrame] setPaddingRight:0.0f];
    [[graph plotAreaFrame] setBorderLineStyle:nil];
    
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:12.0f];
    [textStyle setColor:[CPTColor colorWithCGColor:[[UIColor grayColor] CGColor]]];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)[graph axisSet];
    
    CPTXYAxis *xAxis = [axisSet xAxis];
    [xAxis setMajorIntervalLength:CPTDecimalFromInt(1)];
    [xAxis setMinorTickLineStyle:nil];
    [xAxis setLabelingPolicy:CPTAxisLabelingPolicyNone];
    [xAxis setLabelTextStyle:textStyle];
    [xAxis setLabelRotation:M_PI/4];
    
    NSArray *transportsArray = [[self barGraphDataSource] getTransportTitlesAsArray];
    
    [xAxis setAxisLabels:[NSSet setWithArray:transportsArray]];


    
    CPTXYAxis *yAxis = [axisSet yAxis];
    [yAxis setMajorIntervalLength:CPTDecimalFromInt(1)];
    [yAxis setMinorTickLineStyle:nil];
    [yAxis setLabelingPolicy:CPTAxisLabelingPolicyFixedInterval];
    
    UINavigationItem *navigationItem = [[[UINavigationItem alloc] initWithTitle:self.title] autorelease];
    [navigationItem setHidesBackButton:YES];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Hecho" style:UIBarButtonItemStyleDone target:[self delegate] action:@selector(doneButtonWasTapped:)] autorelease] animated:NO];

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
    [managedObjectContext release];
    [graph release];
    [barGraphDataSource release];
    
    [super dealloc];
}

@end
