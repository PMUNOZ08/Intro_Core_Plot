//
//  User.h
//  UseOfTransport
//
//  Created by PEDRO MUÑOZ CABRERA on 26/05/12.
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * dayOfWeek;
@property (nonatomic, retain) NSNumber * transportID;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * userName;

@end
