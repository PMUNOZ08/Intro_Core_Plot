//
//  STLineGraphViewController.m
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 17/06/12.
//  Copyright (c) 201  All rights reserved.
//

#import "STLineGraphViewController.h"
#import "STLineGraphView.h"

@interface STLineGraphViewController ()

@end

@implementation STLineGraphViewController

@synthesize graph;
@synthesize delegate;
@synthesize managedObjectContext;


- (void)loadView
{
    [super loadView];
    [self setTitle:@"Uso de transporte"];
    [self setView:[[[STLineGraphView alloc] initWithFrame:self.view.frame] autorelease]];
    
    CPTTheme *defaultTheme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [self setGraph:(CPTGraph *)[defaultTheme newGraph]];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    STLineGraphView *graphView = (STLineGraphView *)[self view];
    [[self graph] setDelegate:self];
    
    [[graphView chartHostingView] setHostedGraph:[self graph]];
    
    CPTScatterPlot *transportScatterPlot = [[CPTScatterPlot alloc] initWithFrame:[graph bounds]];
    [transportScatterPlot setIdentifier:@"userTravel"];
    [transportScatterPlot setDelegate:self];
    [transportScatterPlot setDataSource:self];
    
    CPTScatterPlot *metroScatterPlot = [[CPTScatterPlot alloc] initWithFrame:[graph bounds]];
    [metroScatterPlot setIdentifier:@"useOfMetro"];
    [metroScatterPlot setDelegate:self];
    [metroScatterPlot setDataSource:self];
    
    [[self graph] addPlot:transportScatterPlot];
    [[self graph] addPlot:metroScatterPlot];
    
    
    CPTXYPlotSpace *userPlotSpace = (CPTXYPlotSpace *)[graph defaultPlotSpace];
    [userPlotSpace setXRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(7)]];
    [userPlotSpace setYRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(10)]];
    
    
    [[graph plotAreaFrame] setPaddingLeft:20.0f];
    [[graph plotAreaFrame] setPaddingTop:10.0f];
    [[graph plotAreaFrame] setPaddingBottom:20.0f];
    [[graph plotAreaFrame] setPaddingRight:10.0f];
    [[graph plotAreaFrame] setBorderLineStyle:nil];
    
    NSNumberFormatter *axisFormatter = [[NSNumberFormatter alloc] init];
    [axisFormatter setMinimumIntegerDigits:1];
    [axisFormatter setMaximumFractionDigits:0];
    
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:12.0f];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)[graph axisSet];
    
    CPTXYAxis *xAxis = [axisSet xAxis];
    [xAxis setMajorIntervalLength:CPTDecimalFromInt(1)];
    [xAxis setMinorTickLineStyle:nil];
    [xAxis setLabelingPolicy:CPTAxisLabelingPolicyFixedInterval];
    [xAxis setLabelTextStyle:textStyle];
    [xAxis setLabelFormatter:axisFormatter];
    
    CPTXYAxis *yAxis = [axisSet yAxis];
    [yAxis setMajorIntervalLength:CPTDecimalFromInt(1)];
    [yAxis setMinorTickLineStyle:nil];
    [yAxis setLabelingPolicy:CPTAxisLabelingPolicyFixedInterval];
    [yAxis setLabelTextStyle:textStyle];
    [yAxis setLabelFormatter:axisFormatter];
    
    CPTMutableLineStyle *mainPlotLineStyle = [[transportScatterPlot dataLineStyle] mutableCopy];
    [mainPlotLineStyle setLineWidth:2.0f];
    [mainPlotLineStyle setLineColor:[CPTColor colorWithCGColor:[[UIColor blueColor] CGColor]]];
    
    [transportScatterPlot setDataLineStyle:mainPlotLineStyle];
    
    [mainPlotLineStyle setLineColor:[CPTColor greenColor]];
    [metroScatterPlot setDataLineStyle:mainPlotLineStyle];

    
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    [axisLineStyle setLineWidth:1];
    [axisLineStyle setLineColor:[CPTColor colorWithCGColor:[[UIColor grayColor] CGColor]]];
    
    [xAxis setAxisLineStyle:axisLineStyle];
    [xAxis setMajorTickLineStyle:axisLineStyle];
    [yAxis setAxisLineStyle:axisLineStyle];
    [yAxis setMajorTickLineStyle:axisLineStyle];
    
    
    CPTColor *areaColor = [CPTColor blueColor];
    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
    [areaGradient setAngle:-90.0f];
    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
    [transportScatterPlot setAreaFill:areaGradientFill];
    [transportScatterPlot setAreaBaseValue:CPTDecimalFromInt(0)];
    
    areaColor = [CPTColor greenColor];
    areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
    [areaGradient setAngle:-90.0f];
    areaGradientFill = [CPTFill fillWithGradient:areaGradient];
    [metroScatterPlot setAreaFill:areaGradientFill];
    [metroScatterPlot setAreaBaseValue:CPTDecimalFromInt(0)];
    
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.title];
    [navigationItem setHidesBackButton:YES];
    
    UINavigationBar *navigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)] autorelease];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
    
    [navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:[self delegate]
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

#pragma mark - CPTScatterPlotDataSource Methods

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return 8;       
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSUInteger x = index;
    NSUInteger y = 0;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    
    
    NSPredicate *predicate = nil;
    
    if ([[plot identifier] isEqual:@"userTravel"])
    {
        predicate = [NSPredicate predicateWithFormat:@"dayOfWeek == %d", index];
    }
    else if ([[plot identifier] isEqual:@"useOfMetro"])
    {
        predicate = [NSPredicate predicateWithFormat:@"dayOfWeek == %d AND transportID == %d", index, 1];  // Coidgo del transporte Metro
    }
    
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    y = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    
    switch (fieldEnum)
    {
        case CPTScatterPlotFieldX:
            NSLog(@"x value for %d is %d", index, x);
            return [NSNumber numberWithInt:x];
            break;
        case CPTScatterPlotFieldY:
            NSLog(@"y value for %d is %d", index, y);
            return [NSNumber numberWithInt:y];
            break;
            
        default:
            break;
    }
    
    return nil;
}


- (CPTPlotSymbol *)symbolForScatterPlot:(CPTScatterPlot *)aPlot recordIndex:(NSUInteger)index
{
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    [plotSymbol setSize:CGSizeMake(10, 10)];
    
    if ([[aPlot identifier] isEqual:@"userTravel"])
    {
        [plotSymbol setFill:[CPTFill fillWithColor:[CPTColor blueColor]]];
    }
    else if ([[aPlot identifier] isEqual:@"useOfMetro"])
    {   [plotSymbol setFill:[CPTFill fillWithColor:[CPTColor greenColor]]];
    }
    
    [plotSymbol setLineStyle:nil];
    [aPlot setPlotSymbol:plotSymbol];
    
    return plotSymbol;
}


- (void)dealloc
{
    [graph release];
    [managedObjectContext release];
    
    [super dealloc];
}

@end
