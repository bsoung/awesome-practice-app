//
//  Company+CoreDataProperties.m
//  NavCtrl
//
//  Created by Benjamin Soung on 11/12/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Company+CoreDataProperties.h"

@implementation Company (CoreDataProperties)

@dynamic company_logo;
@dynamic company_name;
@dynamic company_symbol;
@dynamic index;
@dynamic products;

-(void)dealloc
{
    [self.company_logo release];
    [self.company_name release];
    [self.company_symbol release];
    [self.products release];
    [self.index release];
    [super dealloc];

}

@end
