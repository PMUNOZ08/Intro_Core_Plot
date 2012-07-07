//
//  STBarTransportDataSource.m
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 19/06/12.
//  Copyright (c) 2012 Aron's IT Consultancy. All rights reserved.
//

#import "STBarTransportDataSource.h"

@implementation STBarTransportDataSource




-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    CPTColor *areaColor = nil;
    
    switch (index)
    {
        case 0:
            areaColor = [CPTColor redColor];
            break;
            
        case 1:
            areaColor = [CPTColor blueColor];
            break;
            
        case 2:
            areaColor = [CPTColor orangeColor];
            break;
            
        case 3:
            areaColor = [CPTColor greenColor];
            break;
            
        default:
            areaColor = [CPTColor purpleColor];
            break;
    }
    
    CPTFill *barFill = [CPTFill fillWithColor:areaColor];
    
    return barFill;
}

@end
