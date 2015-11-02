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

- (void)dealloc
{
    [super dealloc];
    [self.companyTextField release];
    [self.logoTextField release];
    [self.addCompanyText release];
    [self.cancelCompanyText release];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressAddButton:(id)sender
{
    NSString *companyName = self.companyTextField.text;
    NSString *logoName = self.logoTextField.text;
    NSString *symbolName = self.symbolTextField.text;
    
    
    if (companyName.length > 0)
    {
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

@end
