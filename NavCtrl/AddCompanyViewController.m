//
//  AddCompanyViewController.m
//  NavCtrl
//
//  Created by XCodeClub on 10/30/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "AddCompanyViewController.h"
#import "DataAccessObject.h"

@interface AddCompanyViewController ()

@end

@implementation AddCompanyViewController


#pragma mark - Adding a new company to the collection view

- (void)viewDidLoad {
    [super viewDidLoad];
 
}


- (IBAction)pressAddButton:(id)sender
{
    NSString *companyName = self.companyTextField.text;
    NSString *logoName = self.logoTextField.text;
    NSString *symbolName = self.symbolTextField.text;
    
    
    if (companyName.length) {
        [[DataAccessObject sharedInstance] addCompanyWithName:companyName andLogo:logoName andSymbol:symbolName];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Cannot add company with no name!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }

}

- (IBAction)pressCancelButton:(id)sender
{

         [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    
    [self.companyTextField release];
    [self.logoTextField release];
    [self.addCompanyText release];
    [self.cancelCompanyText release];
    [self.symbolTextField release];
    [super dealloc];
    
}

@end
