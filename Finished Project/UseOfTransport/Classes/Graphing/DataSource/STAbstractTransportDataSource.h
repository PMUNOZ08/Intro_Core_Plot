//
//  STAbstractSubjectDataSource.h
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 19/06/12.
//  Copyright (c) 2012 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"

@interface STAbstractTransportDataSource : NSObject <CPTPlotDataSource>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (float)getTotalTransports;
- (float)getMaxUsers;
- (NSArray *)getTransportTitlesAsArray;

@end

