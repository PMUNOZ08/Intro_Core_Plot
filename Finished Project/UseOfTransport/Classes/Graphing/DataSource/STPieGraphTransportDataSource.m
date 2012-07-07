//
//  STPieGraphTransportDataSource.m
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 19/06/12.
//  Copyright (c) 2012  All rights reserved.
//

#import "STPieGraphTransportDataSource.h"


@implementation STPieGraphTransportDataSource 



#pragma mark - CPTPieChartDataSource
-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index
{
    NSError *error = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KindTransport" inManagedObjectContext:[self managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"transportID == %d", index];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    [request setPredicate:predicate];
    [request setReturnsDistinctResults:NO];
    [request setPropertiesToFetch:[NSArray arrayWithObject:@"transportName"]];
    
    NSArray *titleStrings = [[self managedObjectContext] executeFetchRequest:request error:&error];
    
    NSDictionary *fetchedSubject = [titleStrings objectAtIndex:0];
    
    return [fetchedSubject objectForKey:@"transportName"];
}

@end
