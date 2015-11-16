//
//  Company+CoreDataProperties.h
//  NavCtrl
//
//  Created by Benjamin Soung on 11/12/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Company.h"

NS_ASSUME_NONNULL_BEGIN

@interface Company (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *company_logo;
@property (nullable, nonatomic, retain) NSString *company_name;
@property (nullable, nonatomic, retain) NSString *company_symbol;
@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSSet<Product *> *products;

@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addProductsObject:(Product *)value;
- (void)removeProductsObject:(Product *)value;
- (void)addProducts:(NSSet<Product *> *)values;
- (void)removeProducts:(NSSet<Product *> *)values;

@end

NS_ASSUME_NONNULL_END
