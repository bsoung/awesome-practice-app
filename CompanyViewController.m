//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Parent.h"
#import "Product.h"
#import "DataAccessObject.h"
#import "AddCompanyViewController.h"
 
@interface CompanyViewController ()

@end



@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
     self.clearsSelectionOnViewWillAppear = NO;
 
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     self.title = @"Mobile device makers";
    
     self.navigationItem.leftBarButtonItem = nil;
    
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (editing) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCompany: )];
        [self.navigationItem setLeftBarButtonItem:addButton];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];

}

- (void)addCompany:(id)sender
{
    NSLog(@"Adding company...");
    AddCompanyViewController *addVC = [[AddCompanyViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

- (void)dealloc
{
    [super dealloc];
    [self.productViewController release];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DataAccessObject sharedInstance] companyList] count];
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    Parent *parent = [DataAccessObject sharedInstance].companyList[indexPath.row];
    cell.textLabel.text = parent.name;
    cell.imageView.image = [UIImage imageNamed:parent.logo];
    
    
  
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
 


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {

        [[DataAccessObject sharedInstance].companyList removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = [DataAccessObject sharedInstance].companyList[sourceIndexPath.row];
    [[DataAccessObject sharedInstance].companyList removeObjectAtIndex:sourceIndexPath.row];
    [[DataAccessObject sharedInstance].companyList insertObject:stringToMove atIndex:destinationIndexPath.row];
}



 
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return YES;
}
 


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Parent *parent = [DataAccessObject sharedInstance].companyList[indexPath.row];
    NSLog(@"%@",parent.name);
    self.productViewController.title = parent.name;
    
    self.productViewController.company = parent;
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}




@end
