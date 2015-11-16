//
//  AddProductViewController.h
//  NavCtrl
//
//  Created by XCodeClub on 10/30/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company+CoreDataProperties.h"
#import "Product+CoreDataProperties.h"

@interface AddProductViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *addProductName;
@property (nonatomic, retain) IBOutlet UITextField *addProductLogo;
@property (nonatomic, retain) IBOutlet UITextField *addProductURL;
@property (nonatomic, retain) IBOutlet UIButton *productButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) Product *product;


- (IBAction)pressAddButton:(id)sender;
- (IBAction)pressCancelButton:(id)sender;

@end
