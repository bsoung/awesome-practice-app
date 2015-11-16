//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by XCodeClub on 10/29/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"




@interface DataAccessObject ()


@property (nonatomic, assign) BOOL doesDatabaseExist;

@end

@implementation DataAccessObject

#pragma mark - Singleton pattern creation

+ (instancetype)sharedInstance
{
    static DataAccessObject *instance;
    
    //# of times, only once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instance = [[DataAccessObject alloc] init];
        
        //set up store coordinator for core data
        [instance persistentStoreCoordinator];
        [instance createDataIfNeeded];
        
    });

    return instance;
}


- (void)createDataIfNeeded
{
    self.companyList = [NSMutableArray array];

    if (![self doesDatabaseExist]) {
        [self createAppleData];
        [self createSamsungData];
        [self createGoogleProduct];
        [self createNokiaData];
        [self saveContext];
        
    } else {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entityDescription];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
        
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        

        NSError *error = nil;
        NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        if (!error) {
            self.companyList = [NSMutableArray arrayWithArray:fetchedObjects];
            
        } else {
            NSLog(@"Cannot fetch companies: %@", error);
        }
        
        [fetchRequest release];
        [sortDescriptor release];
    }
    
}

#pragma mark - Methods for creating each Company and Product

- (void)createAppleData
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    Company *company = (Company *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    company.company_name = @"Apple";
    company.company_logo = @"applelogo.jpeg";
    company.company_symbol = @"AAPL";
    company.index = @0;
    
    NSMutableSet *products = [NSMutableSet set];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productOne = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productOne.product_name = @"iPad";
    productOne.product_logo = @"ipadlogo.jpeg";
    productOne.product_url = @"https://www.apple.com/ipad/"; 
    productOne.index = @0;
    
    [products addObject:productOne];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productTwo = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productTwo.product_name = @"iPhone";
    productTwo.product_logo = @"iphonelogo.jpeg";
    productTwo.product_url = @"https://www.apple.com/iphone/";
    productTwo.index = @1;
    
    [products addObject:productTwo];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productThree = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productThree.product_name = @"iTouch";
    productThree.product_logo = @"itouchlogo.jpeg";
    productThree.product_url = @"https://www.apple.com/shop/buy-ipod/ipod-touch";
    productThree.index = @2;
    
    [products addObject:productThree];
    
    company.products = [NSSet setWithSet:products];
    
    [self.companyList addObject:company];

}

- (void)createSamsungData
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    Company *company = (Company *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    company.company_name = @"Samsung";
    company.company_logo = @"samsunglogo.jpeg";
    company.company_symbol = @"BBRY";
    company.index = @1;
    
    NSMutableSet *products = [NSMutableSet set];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productOne = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productOne.product_name = @"Galaxy S4";
    productOne.product_logo = @"galaxys4logo.jpeg";
    productOne.product_url = @"https://www.samsung.com/global/microsite/galaxys4/";
    productOne.index = @0;
    
    [products addObject:productOne];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productTwo = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productTwo.product_name = @"Galaxy Note";
    productTwo.product_logo = @"galaxynotelogo.jpeg";
    productTwo.product_url = @"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find";
    productTwo.index = @1;
    
    [products addObject:productTwo];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productThree = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productThree.product_name = @"Galaxy Tab";
    productThree.product_logo = @"galaxytablogo.jpeg";
    productThree.product_url = @"https://www.samsung.com/us/mobile/galaxy-tab/";
    productOne.index = @2;
    
    [products addObject:productThree];
    
    company.products = [NSSet setWithSet:products];
    
    [self.companyList addObject:company];

}

- (void)createGoogleProduct
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    Company *company = (Company *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    company.company_name = @"Google";
    company.company_logo = @"googlelogo.jpeg";
    company.company_symbol = @"GOOG";
    company.index = @2;
    
    NSMutableSet *products = [NSMutableSet set];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productOne = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productOne.product_name = @"Nexus 6";
    productOne.product_logo = @"nexus6logo.jpeg";
    productOne.product_url = @"https://www.google.com/nexus/6p/";
    productOne.index = @0;
    
    [products addObject:productOne];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productTwo = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productTwo.product_name = @"Nexus 7";
    productTwo.product_logo = @"nexus7logo.jpeg";
    productTwo.product_url = @"https://store.google.com/product/nexus_7";
    productTwo.index = @1;
    
    [products addObject:productTwo];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productThree = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productThree.product_name = @"Nexus 9";
    productThree.product_logo = @"nexus9logo.jpg";
    productThree.product_url = @"https://www.google.com/nexus/9/";
    productThree.index = @2;
    
    [products addObject:productThree];
    
    company.products = [NSSet setWithSet:products];
    
    [self.companyList addObject:company];

}

- (void)createNokiaData
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    Company *company = (Company *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    company.company_name = @"Nokia";
    company.company_logo = @"nokialogo.jpeg";
    company.company_symbol = @"MSFT";
    company.index = @3;
    
    NSMutableSet *products = [NSMutableSet set];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productOne = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productOne.product_name = @"Lumia 640";
    productOne.product_logo = @"lumia640logo.jpeg";
    productOne.product_url = @"https://www.microsoft.com/en-us/mobile/phone/lumia640/";
    productOne.index = @0;
    
    [products addObject:productOne];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productTwo = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productTwo.product_name = @"Lumia 640 XL";
    productTwo.product_logo = @"lumia640xllogo.jpeg";
    productTwo.product_url = @"https://www.microsoft.com/en-us/mobile/phone/lumia640-xl/";
    productTwo.index = @1;
    
    [products addObject:productTwo];
    
    entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *productThree = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    productThree.product_name = @"Lumia 1520";
    productThree.product_logo = @"nokia1520logo.jpeg";
    productThree.product_url = @"https://www.microsoft.com/en-us/mobile/phone/lumia1520/";
    productThree.index = @2;
    
    [products addObject:productThree];
    
    company.products = [NSSet setWithSet:products];
    
    [self.companyList addObject:company];

}

#pragma mark - Methods for manipulating Companies and Products


- (void)addCompanyWithName:(NSString *)name andLogo:(NSString *)logo andSymbol:(NSString *)symbol
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    Company *company = (Company *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    company.company_name = name;
    company.company_logo = logo;
    company.company_symbol = symbol;
    company.index = @([self.companyList count]);
    
    [self.companyList addObject:company];
    [self saveContext];
}

- (void)addProductToCompany:(Company *)company andName:(NSString *)name andLogo:(NSString *)logo andUrl:(NSString *)url;
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    Product *product = (Product *)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    product.product_name = name;
    product.product_logo = logo;
    product.product_url = url;
    product.index = @([company.products count]);
    
    company.products = [company.products setByAddingObject:product];
    
    [self saveContext];

}

- (void)removeProduct:(Product *)product fromCompany:(Company *)company
{
    company.products = [company.products objectsPassingTest:^BOOL(Product * _Nonnull obj, BOOL * _Nonnull stop) {
        return obj != product;
    }];
    
    [self saveContext];

}

- (void)removeCompany:(Company *)company
{
    [self.companyList removeObject:company];
    [self.managedObjectContext deleteObject:company];
    
    [self saveContext];

}

- (void)dealloc
{
    
    [self.companyList release];
    [self.products release];
    [self.appleProduct release];
    [self.samsungProduct release];
    [self.googleProduct release];
    [self.nokiaProduct release];
    [super dealloc];
  
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.benjamin.coredatatest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"coredatatest.sqlite"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
        self.doesDatabaseExist = YES;
        NSLog(@"Database does exist!");
    } else {
        self.doesDatabaseExist = NO;
        NSLog(@"Database does not exist!");
    }
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
