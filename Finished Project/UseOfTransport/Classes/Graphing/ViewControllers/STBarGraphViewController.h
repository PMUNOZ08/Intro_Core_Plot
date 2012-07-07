//
//  STBarGraphViewController.h
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 17/06/12.
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "STBarTransportDataSource.h"



@protocol STBarGraphViewControllerDelegate
@required
- (void)doneButtonWasTapped:(id)sender;

@end

@interface STBarGraphViewController : UIViewController <CPTBarPlotDelegate>


@property (nonatomic, strong) CPTGraph *graph;
@property (nonatomic, assign) id<STBarGraphViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;



@end
