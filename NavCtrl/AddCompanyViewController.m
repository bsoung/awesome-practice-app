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
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)pressAddButton:(id)sender
{
    NSString *companyName = self.companyTextField.text;
    NSString *logoName = self.logoTextField.text;
    NSString *symbolName = self.symbolTextField.text;
    
    
    if (companyName.length > 0) {
        Parent *lastCompany =  [[DataAccessObject sharedInstance].companyList lastObject];
        [[DataAccessObject sharedInstance]
         addCompanyWithName:companyName
         andLogo:logoName
         andSymbol:symbolName
         andID:lastCompany.company_ID+1
         andWriteToDataBase:YES];
        
        //+ andWritetodatabase bool, when adding companies already in the database, say no. otherwise, not yet in the database yes. bool yes here
        //loadcompanyfromdatabase method, bool no.
        //check if yes or no. if yes, call the write to database. else, no. call it from inside the addcompanywithname method
        
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
