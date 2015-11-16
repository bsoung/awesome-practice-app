//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by XCodeClub on 10/29/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Company+CoreDataProperties.h"
#import "Product+CoreDataProperties.h"
#import "CompanyViewController.h"

//also known as a "factory class"

@interface DataAccessObject : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *products;

@property (nonatomic, retain) NSMutableArray *appleProduct;
@property (nonatomic, retain) NSMutableArray *samsungProduct;
@property (nonatomic, retain) NSMutableArray *googleProduct;
@property (nonatomic, retain) NSMutableArray *nokiaProduct;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)addCompanyWithName:(NSString *)name andLogo:(NSString *)logo andSymbol:(NSString *)symbol;
- (void)addProductToCompany:(Company *)company andName:(NSString *)name andLogo:(NSString *)logo andUrl:(NSString *)url;


- (void)removeProduct:(Product *)product fromCompany:(Company *)company;
- (void)removeCompany:(Company *)company;


@end
