//
//  Product+CoreDataProperties.h
//  NavCtrl
//
//  Created by Benjamin Soung on 11/6/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *product_name;
@property (nullable, nonatomic, retain) NSString *product_logo;
@property (nullable, nonatomic, retain) NSString *product_url;
@property (nullable, nonatomic, retain) Company *company;

@end

NS_ASSUME_NONNULL_END
