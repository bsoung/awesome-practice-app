//
//  EditableDetailCell.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/29/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableDetailCell : UITableViewCell
{
    UITextField *_textField;
}

@property (nonatomic, retain) UITextField *textField;

@end