//
//  AddProductViewController.m
//  NavCtrl
//
//  Created by XCodeClub on 10/30/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "AddProductViewController.h"
#import "DataAccessObject.h"

@interface AddProductViewController ()

@end

@implementation AddProductViewController

- (void)dealloc
{
    [super dealloc];
    [self.addProductLogo release];
    [self.addProductName release];
    [self.addProductURL release];
    [self.productButton release];
    [self.cancelButton release];
    [self.company release];
    
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
    NSString *productName = self.addProductName.text;
    NSString *productLogo = self.addProductLogo.text;
    NSString *productURL = self.addProductURL.text;
    
    if (productName.length > 0 && productLogo.length > 0 && productURL.length > 0) {
        [[DataAccessObject sharedInstance] addProductWithName:productName andLogo:productLogo andUrl:productURL toCompanyWithID:self.company.company_ID andWriteToDataBase:YES andProductID:self.product.product_ID];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Name, logo, and URL must not be blank!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
    
    //+ andWritetodatabase bool, when adding companies already in the database, say no. otherwise, not yet in the database yes. bool yes here
    //loadcompanyfromdatabase method, bool no.
    //check if yes or no. if yes, call the write to database. else, no. call it from inside the addcompanywithname method
}

- (IBAction)pressCancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}


@end
