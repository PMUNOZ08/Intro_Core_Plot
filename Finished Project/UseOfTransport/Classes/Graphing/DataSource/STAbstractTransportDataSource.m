//
//  STAbstractSubjectDataSource.m
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 19/06/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STAbstractTransportDataSource.h"

@implementation STAbstractTransportDataSource

@synthesize managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
    self = [super init];
    if (self)
    {
        [self setManagedObjectContext:aManagedObjectContext];
    }
    
    return self;
}

#pragma mark - CPTBarPlotDataSource Methods

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self getTotalTransports];
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    int x = index + 1;
    int y = 0;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"transportID == %d", index];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    y = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    [fetchRequest release];
    
    switch (fieldEnum)
    {
        case CPTScatterPlotFieldX:
            return [NSNumber numberWithInt:x];
            break;
        case CPTScatterPlotFieldY:
            return [NSNumber numberWithInt:y];
            break;
            
        default:
            break;
    }
    
    return nil;
}


#pragma mark - Private Methods

- (float)getTotalTransports
{
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KindTransport" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    return [managedObjectContext countForFetchRequest:fetchRequest error:&error];
}

- (float)getMaxUsers
{
    float maxEnrolled = 0;
    
    NSError *error = nil;
    
    for (int i = 0; i < [self getTotalTransports]; i++)
    {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"transportID == %d", i];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:predicate];
        
        float subjectMax = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
        NSLog(@"users for Transport %d is %f", i, subjectMax);
        [fetchRequest release];
        
        if (subjectMax > maxEnrolled)
        {
            maxEnrolled = subjectMax;
        }
    }
    
    return maxEnrolled;
}

- (NSArray *)getTransportTitlesAsArray
{
    NSError *error = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"transportID" ascending:YES];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KindTransport" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [request setResultType:NSDictionaryResultType];
    [request setReturnsDistinctResults:NO];
    [request setPropertiesToFetch :[NSArray arrayWithObject:@"transportName"]];
    
    NSArray *titleStrings = [managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *labelArray = [NSMutableArray array];
    
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    [textStyle setFontSize:10];
    
    for (int i = 0; i < [titleStrings count]; i++)
    {
        NSDictionary *dict = [titleStrings objectAtIndex:i];
        
        CPTAxisLabel *axisLabel = [[CPTAxisLabel alloc] initWithText:[dict objectForKey:@"transportName"] textStyle:textStyle];
        [axisLabel setTickLocation:CPTDecimalFromInt(i + 1)];
        [axisLabel setRotation:M_PI/4];
        [axisLabel setOffset:0.1];
        [labelArray addObject:axisLabel];
        [axisLabel release];
    }
    
    return [NSArray arrayWithArray:labelArray];
}




@end
