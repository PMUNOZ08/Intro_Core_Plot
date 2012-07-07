//
//  AddUserView.m
//  UseOfTransport
//
//  Created by Pedro Munoz on 27/05/12..
//  Copyright (c) 2012  My Company name. All rights reserved.
//

#import "AddUserView.h"

@interface AddUserView()
- (UILabel *)getStyledLabel;
- (UITextField *)getStyledTextFieldWithTag:(int)tag;
@end

@implementation AddUserView

@synthesize nameLabel;
@synthesize transportLabel;
@synthesize dayOfWeekLabel;

@synthesize nameTextField;
@synthesize transportTextField;
@synthesize dayOfWeekTextField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
        
        [self setNameLabel:[self getStyledLabel]];
        [self setTransportLabel:[self getStyledLabel]];
        [self setDayOfWeekLabel:[self getStyledLabel]];
        
        [nameLabel setText:@"User Name:"];
        [transportLabel setText:@"Kind of transport:"];
        [dayOfWeekLabel setText:@"Day of week"];
        
        [self setNameTextField:[self getStyledTextFieldWithTag:1]];
        [self setTransportTextField:[self getStyledTextFieldWithTag:2]];
        [self setDayOfWeekTextField:[self getStyledTextFieldWithTag:3]];
        
        [self addSubview:nameLabel];
        [self addSubview:transportLabel];
        [self addSubview:dayOfWeekLabel];
        
        [self addSubview:nameTextField];
        [self addSubview:transportTextField];
        [self addSubview:dayOfWeekTextField];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float vPadding = 5;
    float vSectionPadding = 10;
    
    [[self nameLabel] setFrame:CGRectMake(10., vPadding * 10, self.frame.size.width - 20., 30)];
    [[self nameTextField] setFrame:CGRectMake(10., 
                                              nameLabel.frame.origin.y + nameLabel.frame.size.height + vPadding, 
                                              self.frame.size.width - 20., 
                                              30)];
    
    [[self transportLabel] setFrame:CGRectMake(10., nameTextField.frame.origin.y + nameTextField.frame.size.height + vSectionPadding
                                             ,self.frame.size.width - 20.
                                             ,30)];  
    
    [[self transportTextField] setFrame:CGRectMake(10., 
                                              transportLabel.frame.origin.y + transportLabel.frame.size.height + vPadding, 
                                              self.frame.size.width - 20, 
                                              30)];
    
    [[self dayOfWeekLabel] setFrame:CGRectMake(10., transportTextField.frame.origin.y + transportTextField.frame.size.height + vSectionPadding
                                             ,self.frame.size.width - 20.
                                             ,30)];
    
    [[self dayOfWeekTextField] setFrame:CGRectMake(10., 
                                                 dayOfWeekLabel.frame.origin.y + dayOfWeekLabel.frame.size.height + vPadding, 
                                                 self.frame.size.width - 20., 
                                                 30)];
}

- (void)dealloc
{
    
    [nameLabel release];
    [transportLabel release];
    [dayOfWeekLabel release];
    
    [nameTextField release];
    [transportLabel release];
    [dayOfWeekTextField release];
    
    [super dealloc];
}

#pragma mark - private methods
- (UILabel *)getStyledLabel
{
    UILabel *returnlabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [returnlabel setFont:[UIFont boldSystemFontOfSize:20]];
    [returnlabel setTextAlignment:UITextAlignmentLeft];
    [returnlabel setBackgroundColor:[UIColor clearColor]];
    
    return [returnlabel autorelease];    
}
                                
- (UITextField *)getStyledTextFieldWithTag:(int)tag
{
    UITextField *returnTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [returnTextField setTag:tag];
    [returnTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [returnTextField setReturnKeyType:UIReturnKeyDone];    
    
    return [returnTextField autorelease];
}


@end
