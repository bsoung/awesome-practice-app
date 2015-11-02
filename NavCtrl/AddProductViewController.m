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
        [[DataAccessObject sharedInstance] addProductToCompany:self.company withName:productName andLogo:productLogo andUrl:productURL];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Name, logo, and URL must not be blank!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }



}

- (IBAction)pressCancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
