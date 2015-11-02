//
//  DetailViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/29/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "DetailViewController.h"
#import "Parent.h"
#import "EditableDetailCell.h"
#import "AddProductViewController.h"

@interface DetailViewController ()


@end

@implementation DetailViewController
@synthesize logoCell;
@synthesize parent;
@synthesize accessObject;
@synthesize nameCell;

- (void)dealloc
{
    [super dealloc];
    [self.parent release];
    [self.accessObject release];
    [self.nameCell release];
    [self.logoCell release];
   

}




- (void)addProduct:(id)sender
{
    NSLog(@"Adding company...");
    AddProductViewController *addVC = [[AddProductViewController alloc] init];
    addVC.company = 
    
    [self.navigationController pushViewController:addVC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct: )];
    [self.navigationItem setLeftBarButtonItem:addButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUInteger indexes[] = { 0, 0 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes
                                                        length:2];
    
    EditableDetailCell *cell = (EditableDetailCell *)[[self tableView]
                                                      cellForRowAtIndexPath:indexPath];
    
    [[cell textField] becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (NSUInteger section = 0; section < [[self tableView] numberOfSections]; section++)
    {
        NSUInteger indexes[] = { section, 0 };
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes
                                                            length:2];
        
        EditableDetailCell *cell = (EditableDetailCell *)[[self tableView]
                                                          cellForRowAtIndexPath:indexPath];
        if ([[cell textField] isFirstResponder])
        {
            [[cell textField] resignFirstResponder];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField tag] == 3)
    {
        [textField setReturnKeyType:UIReturnKeyDone];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    static NSNumberFormatter *_formatter;
    if (_formatter == nil)
        _formatter = [[NSNumberFormatter alloc] init];
    
    NSString *text = [textField text];
  
    NSUInteger tag = [textField tag];
    
    switch (tag) {
        case companyName:
            [self.parent setName:text];
            break;
            
        case companyLogo:
            [self.parent setLogo:text];
            
         }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField returnKeyType] == UIReturnKeyNext)
    {
        NSInteger nextTag = [textField tag] +1;
        UIView *nextTextField = [[self tableView] viewWithTag:nextTag];
        
        [nextTextField becomeFirstResponder];
    
    } else if ([self isModal]){
        [self save];
    
    } else {
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Name";
            break;
            
        case 1:
            return @"Logo";
            
         
    }
    
    return nil;

}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Determine the text field's value. Each section of the table view
    //  is mapped to a property of the book object we're displaying.
    //
    EditableDetailCell *cell = nil;
    NSString *text = nil;
    
    NSUInteger section = [indexPath section];
    switch (section) {
        case companyName:
            cell = [self nameCell];
            break;
            
        case companyLogo:
            cell = [self logoCell];
            
    }
    
    UITextField *textField = [cell textField];
    [textField setText:text];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 


@end
