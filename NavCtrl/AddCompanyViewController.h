//
//  AddCompanyViewController.h
//  NavCtrl
//
//  Created by XCodeClub on 10/30/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCompanyViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *companyTextField;
@property (nonatomic, retain) IBOutlet UITextField *logoTextField;
@property (nonatomic, retain) IBOutlet UITextField *symbolTextField;
@property (nonatomic, retain) IBOutlet UIButton *addCompanyText;
@property (nonatomic, retain) IBOutlet UIButton *cancelCompanyText;



- (IBAction)pressAddButton:(id)sender;
- (IBAction)pressCancelButton:(id)sender;

@end
