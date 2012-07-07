//
//  AddUserView.h
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUserView : UIView

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *transportLabel;
@property (nonatomic, strong) UILabel *dayOfWeekLabel;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *transportTextField;
@property (nonatomic, strong) UITextField *dayOfWeekTextField;

@end
