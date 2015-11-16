//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Company+CoreDataProperties.h"
#import "Product+CoreDataProperties.h"
#import "DataAccessObject.h"
#import "AddCompanyViewController.h"
#import "CompanyCollectionViewCell.h"
#import "AFNetworking.h"
 
@interface CompanyViewController ()

@property (nonatomic, retain, readwrite) NSString *nameLabel;
@property (nonatomic, retain, readwrite) NSString *priceLabel;
@property (nonatomic, retain, readwrite) DataAccessObject *model;

@end

@implementation CompanyViewController



- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Mobile device makers";
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}


#pragma mark - Methods for editing Collection view


- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    static UIBarButtonItem *addButton = nil;
    
    if (editing) {
        if (addButton) {
            [addButton release];
            addButton = nil;
        }
        addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCompany: )];
        [self.navigationItem setLeftBarButtonItem:addButton];
    } else {
        if (addButton) {
            [addButton release];
            addButton = nil;
        }
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)deleteItemsFromDataSourceAtIndexPaths:(NSArray *)itemPaths
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSIndexPath *itemPath in itemPaths) {
        [indexSet addIndex:itemPath.row];
        Company *company = [[DataAccessObject sharedInstance].companyList objectAtIndex:itemPath.row];
        [[DataAccessObject sharedInstance] removeCompany:company];
    }
    
}


- (void)addCompany:(id)sender
{
    AddCompanyViewController *addVC = [[AddCompanyViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];

}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Company *companyToMove = [DataAccessObject sharedInstance].companyList[sourceIndexPath.row];
    [[DataAccessObject sharedInstance].companyList removeObjectAtIndex:sourceIndexPath.row];
    [[DataAccessObject sharedInstance].companyList insertObject:companyToMove atIndex:destinationIndexPath.row];
    
    NSInteger i = 0;
    for (Company *company in [DataAccessObject sharedInstance].companyList) {
        company.index = @(i);
        i++;
    }
    
    [[DataAccessObject sharedInstance] saveContext];
    
}

#pragma mark - Collection view data source WITH AFNetworking

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[DataAccessObject sharedInstance] companyList] count];

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Company *company = [DataAccessObject sharedInstance].companyList[indexPath.row];
    
    static NSString *cellIdentifier = @"CompanyCell";
    
    CompanyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = company.company_name;
    UIImage *image = [UIImage imageNamed:company.company_logo];
    cell.imageView.image = image;
    cell.stockSymbol.text = company.company_symbol;
    
    NSString *stockSymbol = company.company_symbol;
    
    //AFNetworking
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //Set rules for acceptable types of content from stock quote API
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    
    //Getting stock quotes
    [manager GET:[NSString stringWithFormat:@"http://dev.markitondemand.com/Api/v2/Quote/json?symbol=%@", stockSymbol]
      parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             
             cell.nameLabel.text = [NSString stringWithFormat:@" | Current Stock Price %@", [responseObject objectForKey:@"LastPrice"]];
             NSLog(@"JSON: %@", responseObject);
             
         }
         failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             cell.nameLabel.text = @"";
             NSLog(@"Error: %@", error);
         }];
    
    
    return cell;
    
}

#pragma mark - Collection view delegate


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.editing) {
        [self.collectionView performBatchUpdates:^{
            
            NSArray *selectedItemsAtIndexPath = [self.collectionView indexPathsForSelectedItems];
            
            //delete the items from data source
            [self deleteItemsFromDataSourceAtIndexPaths: selectedItemsAtIndexPath];
            
            //delete the items from index path as well
            [self.collectionView deleteItemsAtIndexPaths:selectedItemsAtIndexPath];
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    } else {
        
        Company *company = [DataAccessObject sharedInstance].companyList[indexPath.row];
        NSLog(@"%@",company.company_name);
        
        //Must create and pass in a layout object when initializing
        ProductViewController *productViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductViewController"];
        
        productViewController.title = company.company_name;
        productViewController.company = company;
        
        [self.navigationController
         pushViewController:productViewController
         animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [self.nameLabel release];
    [self.priceLabel release];
    [self.model release];
    [self.collectionView release];
    [super dealloc];
}
    
    


@end
