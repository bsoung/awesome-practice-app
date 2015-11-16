//
//  Product+CoreDataProperties.m
//  NavCtrl
//
//  Created by Benjamin Soung on 11/12/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product+CoreDataProperties.h"

@implementation Product (CoreDataProperties)

@dynamic product_logo;
@dynamic product_name;
@dynamic product_url;
@dynamic index;
@dynamic company;

-(void)dealloc
{
    [self.product_logo release];
    [self.product_name release];
    [self.product_url release];
    [self.company release];
    [self.index release];
    [super dealloc];
}

@end
