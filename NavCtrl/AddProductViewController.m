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



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Adding a new product to the collection view

- (IBAction)pressAddButton:(id)sender
{
    NSString *productName = self.addProductName.text;
    NSString *productLogo = self.addProductLogo.text;
    NSString *productURL = self.addProductURL.text;
    
    if (productName.length && productLogo.length && productURL.length) {
        
        [[DataAccessObject sharedInstance] addProductToCompany:self.company andName:productName andLogo:productLogo andUrl:productURL];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Name, logo, and URL must not be blank!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (IBAction)pressCancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.addProductLogo release];
    [self.addProductName release];
    [self.addProductURL release];
    [self.productButton release];
    [self.cancelButton release];
    [self.company release];
    [self.product release];
    [super dealloc];
    
}


@end
