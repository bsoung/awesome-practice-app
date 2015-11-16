//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "CompanyViewController.h"
#import "WebViewController.h"
#import "Product.h"
#import "AddProductViewController.h"
#import "ProductCollectionViewCell.h"



@interface ProductViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ProductViewController

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Devices";
    self.navigationItem.leftBarButtonItem = nil;
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    static UIBarButtonItem *addButton = nil;
    
    if (editing) {
        if (addButton) {
            [addButton release];
            addButton = nil;
        }
        
        addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct: )];
        [self.navigationItem setLeftBarButtonItem:addButton]; 
    } else {
        if (addButton) {
            [addButton release];
            addButton = nil;
        }
        self.navigationItem.leftBarButtonItem = nil;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.products = [NSMutableArray arrayWithArray: [self.company.products allObjects]];
    
    //sorting array, or else the indexes change but nothing is sorted
   self.products = [NSMutableArray arrayWithArray:[self.products sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
       Product *productOne = (Product *)obj1;
       Product *productTwo = (Product *)obj2;
       
       if (productOne.index < productTwo.index) {
           return NSOrderedAscending;
       } else {
           return NSOrderedDescending;
       }
   }]];
    
    [self.collectionView reloadData];
 
}


#pragma mark - Collection view data source


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.products count];

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Product *product = [self.products objectAtIndex:[indexPath row]];
    
    static NSString *cellIdentifier = @"ProductCell";
    
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = product.product_name;
    UIImage *image = [UIImage imageNamed:product.product_logo];
    cell.imageView.image = image;
   
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.products[sourceIndexPath.row];
    [self.products removeObjectAtIndex:sourceIndexPath.row];
    [self.products insertObject:stringToMove atIndex:destinationIndexPath.row];
    
    //override index by for/in loop
    NSInteger i = 0;
    for (Product *product in self.products) {
        product.index = @(i);
        i++;
    }

    [[DataAccessObject sharedInstance] saveContext];
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;

}

#pragma mark - Collection view delegate


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        [self.collectionView performBatchUpdates:^{
            
            NSArray *selectedItemsAtIndexPath = [self.collectionView indexPathsForSelectedItems];
            
            [self deleteItemsFromDataSourceAtIndexPaths:selectedItemsAtIndexPath];
            [self.collectionView deleteItemsAtIndexPaths:selectedItemsAtIndexPath];
            
        }  completion:nil];
        
        
    } else {
        
        Product *product = self.products[indexPath.row];
        
        WebViewController *webview = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle]];
        webview.url = [NSURL URLWithString:product.product_url];
        
        [self.navigationController
         pushViewController:webview
         animated:YES];
    }
    
}

#pragma mark - Methods for manipulating Collection view

- (void)deleteItemsFromDataSourceAtIndexPaths:(NSArray *)itemPaths
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSIndexPath *itemPath in itemPaths) {
        [indexSet addIndex:itemPath.row];
        
        //get product first, by referring to its location
        Product *product = [self.products objectAtIndex:itemPath.row];
        [[DataAccessObject sharedInstance] removeProduct:product fromCompany:self.company];
    }
    
    [self.products removeObjectsAtIndexes:indexSet];
}

- (void)addProduct:(id)sender
{
    NSLog(@"Adding company...");
    AddProductViewController *addVC = [[AddProductViewController alloc] init];
    addVC.company = self.company;
    
    [self.navigationController pushViewController:addVC animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [self.company release];
    [self.products release];
    [super dealloc];
    
}


@end
