//
//  STLineGraphViewController.h
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 17/06/12.
//  Copyright (c) 201  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@protocol STLineGraphViewControllerDelegate
@required
- (void)doneButtonWasTapped:(id)sender;

@end

@interface STLineGraphViewController : UIViewController <CPTScatterPlotDataSource, CPTScatterPlotDelegate>

@property (nonatomic, strong) CPTGraph *graph;
@property (nonatomic, assign) id<STLineGraphViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
