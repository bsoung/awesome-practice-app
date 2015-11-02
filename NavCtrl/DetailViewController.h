//
//  DetailViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/29/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"

@class Parent;
@class EditableDetailCell;

enum
{
    companyName,
    companyLogo,
  
 

};

typedef NSUInteger companyAttribute;

@interface DetailViewController : UITableViewController <UITextFieldDelegate>
{
    Parent *parent;
    DataAccessObject *accessObject;
    EditableDetailCell *nameCell;
    EditableDetailCell *logoCell;
   

}

@property (nonatomic, retain) Parent *parent;
@property (nonatomic, retain) DataAccessObject *accessObject;
@property (nonatomic, retain) EditableDetailCell *nameCell;
@property (nonatomic, retain) EditableDetailCell *logoCell;
 



@end
