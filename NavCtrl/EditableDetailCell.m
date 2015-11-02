//
//  EditableDetailCell.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/29/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "EditableDetailCell.h"

@implementation EditableDetailCell

 

- (void)dealloc
{
    
    [_textField performSelector:@selector(release)
                     withObject:nil
                     afterDelay:1.0];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)identifier
{
    self = [super initWithStyle:style reuseIdentifier:identifier];
    
    if (self == nil)
    {
        return nil;
    }
    
    CGRect bounds = [[self contentView] bounds];
    CGRect rect = CGRectInset(bounds, 20.0, 10.0);
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    
    //  Set the keyboard's return key label to 'Next'.
    //
    [textField setReturnKeyType:UIReturnKeyNext];
    
    //  Make the clear button appear automatically.
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setOpaque:YES];
    
    [[self contentView] addSubview:textField];
    [self setTextField:textField];
    
    //  The table view may release its cells when they scroll off screen.
    [textField release];
    
    return self;
}

//  Disable highlighting of currently selected cell.
//
- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

@end