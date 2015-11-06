//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by XCodeClub on 10/29/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"
#import "Product.h"


@interface DataAccessObject ()


@property (nonatomic, retain, readwrite) NSMutableArray *companyList;
@property (nonatomic, retain, readwrite) NSMutableArray *products;
@property (nonatomic, retain, readwrite) NSMutableArray *appleProduct;
@property (nonatomic, retain, readwrite) NSMutableArray *samsungProduct;
@property (nonatomic, retain, readwrite) NSMutableArray *googleProduct;
@property (nonatomic, retain, readwrite) NSMutableArray *nokiaProduct;


@end

//declaring database
static sqlite3 *database;


@implementation DataAccessObject


+ (instancetype)sharedInstance
{
    static DataAccessObject *instance;
    
    static dispatch_once_t onceToken; //# of times
    dispatch_once(&onceToken, ^
    {
        instance = [[DataAccessObject alloc] init];
    });

    return instance;
}


-(void)loadCompanyManually{
    self.appleProduct = [NSMutableArray arrayWithObjects:
                         [[Product alloc]
                          initWithName:@"iPad"
                          andUrl:@"https://www.apple.com/ipad/"
                          andLogo:@"ipadlogo.jpeg" andCompanyID:1 andProductID:1],
                         
                         [[Product alloc]
                          initWithName:@"iPhone"
                          andUrl:@"https://www.apple.com/iphone/"
                          andLogo:@"iphonelogo.jpeg" andCompanyID:1 andProductID:2],
                         
                         [[Product alloc]
                          initWithName:@"iTouch"
                          andUrl:@"https://www.apple.com/shop/buy-ipod/ipod-touch"
                          andLogo:@"itouchlogo.jpeg" andCompanyID:1 andProductID:3],
                         nil];
    
    self.samsungProduct = [NSMutableArray arrayWithObjects:
                           [[Product alloc]
                            initWithName:@"Galaxy S4"
                            andUrl:@"http://www.samsung.com/global/microsite/galaxys4/"
                            andLogo:@"galaxys4logo.jpeg" andCompanyID:2 andProductID:4],
                           
                           [[Product alloc]
                            initWithName:@"Galaxy Note"
                            andUrl:@"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find"
                            andLogo:@"galaxynotelogo.jpeg" andCompanyID:2 andProductID:5],
                           
                           [[Product alloc]
                            initWithName:@"Galaxy Tab"
                            andUrl:@"https://www.samsung.com/us/mobile/galaxy-tab/"
                            andLogo:@"galaxytablogo.jpeg" andCompanyID:2 andProductID:6],
                           nil];
    
    self.googleProduct = [NSMutableArray arrayWithObjects:
                          [[Product alloc]
                           initWithName:@"Nexus 6"
                           andUrl:@"https://www.google.com/nexus/6p/"
                           andLogo:@"nexus6logo.jpeg" andCompanyID:3 andProductID:7],
                          
                          [[Product alloc]
                           initWithName:@"Nexus 7"
                           andUrl:@"https://store.google.com/product/nexus_7"
                           andLogo:@"nexus7logo.jpeg" andCompanyID:3 andProductID:8],
                          
                          [[Product alloc]
                           initWithName:@"Nexus 9"
                           andUrl:@"https://www.google.com/nexus/9/"
                           andLogo:@"nexus9logo.jpg" andCompanyID:3 andProductID:9],
                          nil];
    
    self.nokiaProduct = [NSMutableArray arrayWithObjects:
                         [[Product alloc]
                          initWithName:@"Nokia 640"
                          andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia640/"
                          andLogo:@"lumia640logo.jpeg" andCompanyID:4 andProductID:10],
                         
                         [[Product alloc]
                          initWithName:@"Nokia 640 XL"
                          andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia640-xl/"
                          andLogo:@"lumia640xllogo.jpeg" andCompanyID:4 andProductID:11],
                         
                         [[Product alloc]
                          initWithName:@"Nokia 1520"
                          andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia1520/"
                          andLogo:@"nokia1520logo.jpeg" andCompanyID:4 andProductID:12], nil];
    
    self.companyList = [NSMutableArray arrayWithObjects:
                        [[Parent alloc]
                         initWithName:@"Apple"
                         andLogo:@"applelogo.jpeg"
                         andProduct:self.appleProduct
                         andSymbol:@"AAPL" andID:1],
                        
                        [[Parent alloc]
                         initWithName:@"Samsung"
                         andLogo:@"samsunglogo.jpeg"
                         andProduct:self.samsungProduct
                         andSymbol:@"BBRY" andID:2],
                        
                        [[Parent alloc]
                         initWithName:@"Google"
                         andLogo:@"googlelogo.jpeg"
                         andProduct:self.googleProduct
                         andSymbol:@"GOOG" andID:3],
                        
                        [[Parent alloc]
                         initWithName:@"Nokia"
                         andLogo:@"nokialogo.jpeg"
                         andProduct:self.nokiaProduct
                         andSymbol:@"MSFT" andID:4], nil];
}

- (void)addCompanyWithName:(NSString *)name andLogo:(NSString *)logo andSymbol:(NSString *)symbol andID:(NSInteger)company_ID andWriteToDataBase:(BOOL)writeToDataBase
{
    if (!logo || logo.length == 0) {
    logo = @"questionmark.jpeg";
    }
    
    //check if yes or no. if yes, call the write to database. else, no. call it from inside the addcompanywithname method
    
    if (writeToDataBase == YES) {
        Parent *company = [[Parent alloc] initWithName:name andLogo:logo andProduct:[NSMutableArray array] andSymbol:symbol andID:company_ID];
        [self.companyList addObject:company];
        [self writeCompanyToDataBase:company];
    } else {
    Parent *company = [[Parent alloc] initWithName:name andLogo:logo andProduct:[NSMutableArray array] andSymbol:symbol andID:company_ID];
    
    [self.companyList addObject:company];
    
    NSLog(@"Adding company: %@", name);
    }

}

//- (void)addProductToCompany:(Parent *)company withName:(NSString *)name andLogo:(NSString *)logo andUrl:(NSString *)url

- (void)addProductWithName:(NSString *)name andLogo:(NSString *)logo andUrl:(NSString *)url toCompanyWithID:(NSInteger)company_ID andWriteToDataBase:(BOOL)writeToDataBase andProductID:(NSInteger)product_ID;
{
    if (!logo || logo.length == 0) {
        logo = @"questionmark.jpeg";
    }
    
    
    if ([self.companyList count] == 0) {
        return;
    }
    
    if (writeToDataBase == YES) {
        Product *product = [[Product alloc] initWithName:name andUrl:url andLogo:logo andCompanyID:company_ID andProductID:product_ID];
        [self.products addObject:product];
        [self writeProductToDataBase:product];
        NSLog(@"Adding product: %@", name);
        }
    
    Parent *theCompany = nil;
    for (Parent *company in self.companyList) {
        if (company.company_ID == company_ID) { //here company.company_ID == company_ID
            theCompany = company;
            break;
            
        }
        
    }
        if (theCompany) {
            Product *product = [[Product alloc] initWithName:name andUrl:url andLogo:logo andCompanyID:company_ID andProductID:product_ID];
            [theCompany.products addObject:product];
            [self writeProductToDataBase:product];
            NSLog(@"Adding product: %@", name);
        }

}




- (NSString *)databaseDocumentPath
{
    //get path to documents directory
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:@"Company.sql"];
    NSLog(@"%@",path);
    return path;
}

- (void)checkAndCreateDatabase
{
    //enter code
    NSString *path = [self databaseDocumentPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        
        //Copy your db file from bundle to your path
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Company.sql"];
        NSLog(@"%@",sourcePath);
        NSError *error;
        
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath
                                                toPath:path
                                                 error:&error];
        
        if (error) {
            NSLog(@"Error description-%@ \n", [error localizedDescription]);
            NSLog(@"Error reason-%@", [error localizedFailureReason]);
        }
       
        
        // Here call the method which load self.companyList
        [self loadCompanyManually];
            
        // Load the database using self.companyList
        for (int i=0; i<[self.companyList count]; i++) {
            Parent *company = [self.companyList objectAtIndex:i];
            [self writeCompanyToDataBase:company];
            for (int j=0; j<[company.products count]; j++) {
                Product *product = [company.products objectAtIndex:j];
                [self writeProductToDataBase:product];
            }
        }
        
    } else {
        NSLog(@"File Already Exist");
        
       
        [self loadCompanyFromDatabase];
        [self loadProductFromDataBase];
        
        // Fetch From Database
    }
    
}

- (void)loadCompanyFromDatabase
{
    if ( (sqlite3_open( [[self databaseDocumentPath] UTF8String], &database)) != SQLITE_OK) {
        NSLog(@"Error: cannot open database");
    } else {
        
        NSString *sqlStatement = [NSString stringWithFormat:@"select * from Company"];
        sqlite3_stmt *selectStatement;
        
        if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
            int i = 0;
            self.companyList = [NSMutableArray array];
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                
                NSString *name = nil;
                NSString *symbol = nil;
                NSString *logo = nil;
                NSInteger company_id = 0;
                
                char *chName = (char *)sqlite3_column_text(selectStatement, 0);
                if (chName != NULL) {
                    name = [NSString stringWithUTF8String:chName];
                } else {
                    i++;
                    continue;
                }
                
                char *chSymbol = (char *)sqlite3_column_text(selectStatement, 1);
                if (chSymbol != NULL) {
                    symbol = [NSString stringWithUTF8String:chSymbol];
                } else {
                    i++;
                    continue;
                }
                
                char *chLogo = (char *)sqlite3_column_text(selectStatement, 2);
                if (chLogo != NULL) {
                    logo = [NSString stringWithUTF8String:chLogo];
                } else {
                    i++;
                    continue;
                }
                
                company_id = sqlite3_column_int(selectStatement, 3);
                
                [self addCompanyWithName:name andLogo:logo andSymbol:symbol andID:company_id andWriteToDataBase:NO]; //helper method
            }
       
        }
        sqlite3_close(database);
    }

}

- (void)loadProductFromDataBase
{
    if ( (sqlite3_open( [[self databaseDocumentPath] UTF8String], &database)) != SQLITE_OK) {
        NSLog(@"Error: cannot open database");
    } else {
        
        NSString *sqlStatement = [NSString stringWithFormat:@"select * from Product"]; //open product
        sqlite3_stmt *selectStatement;
        
        if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &selectStatement, NULL) == SQLITE_OK) {
            int i = 0;
            self.products = [NSMutableArray array];
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                
                NSString *name = nil;
                NSString *logo = nil;
                NSString *url = nil;
                NSInteger company_id = -1;
                NSInteger product_id = 0;
                
                char *chName = (char *)sqlite3_column_text(selectStatement, 1);
                if (chName != NULL) {
                    name = [NSString stringWithUTF8String:chName];
                } else {
                    i++;
                    continue;
                }
                
                char *chLogo = (char *)sqlite3_column_text(selectStatement, 2);
                if (chLogo != NULL) {
                    logo = [NSString stringWithUTF8String:chLogo];
                } else {
                    i++;
                    continue;
                }
                
                char *chUrl = (char *)sqlite3_column_text(selectStatement, 3);
                if (chUrl != NULL) {
                    url = [NSString stringWithUTF8String:chUrl];
                } else {
                    i++;
                    continue;
                }
                
                company_id = sqlite3_column_int(selectStatement, 4);
                
                product_id = sqlite3_column_int(selectStatement, 0);
                
        
                [self addProductWithName:name andLogo:logo andUrl:url toCompanyWithID:company_id andWriteToDataBase:NO andProductID:product_id];
            }
            
        }
        
        sqlite3_close(database);
        
    }
    
}

- (void)writeCompanyToDataBase:(Parent *)company //use this method
{
    
    char *error = NULL;
    
    if ( (sqlite3_open( [[self databaseDocumentPath] UTF8String], &database)) == SQLITE_OK) {
        NSLog(@"Error: cannot open database");
        NSString *sqlStatement = [NSString stringWithFormat:
                                  @"insert into Company (company_name, company_symbol, company_logo, company_id) values ('%s' ,'%s', '%s', '%d')",
                                  [company.name UTF8String],
                                  [company.symbol UTF8String],
                                  [company.logo UTF8String],
                                  (int)company.company_ID];
        
        if (sqlite3_exec(database, [sqlStatement UTF8String], NULL, NULL, &error) == SQLITE_OK) {
            NSLog(@"Company added to DB");
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add Company Complete" message:@"Company added to DB" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert show];
        }
        sqlite3_close(database);

    } else {
        NSLog(@"Error: %s", error);
    }

}

- (void)writeProductToDataBase:(Product *)product
{
    char *error = NULL;
    
    if ( (sqlite3_open( [[self databaseDocumentPath] UTF8String], &database)) == SQLITE_OK) {
        
        NSString *sqlStatement = [NSString stringWithFormat:
                                  @"insert into Product (product_name, product_logo, product_url, product_id, company_id) values('%s','%s','%s',%d,%d)",
                                  [product.name UTF8String],
                                  [product.logo UTF8String],
                                  [product.url UTF8String],
                                  (int)product.product_ID,
                                  (int)product.company_ID];
        
        if (sqlite3_exec(database, [sqlStatement UTF8String], NULL, NULL, &error) == SQLITE_OK) {
            NSLog(@"Product added to DB");
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add Product Complete" message:@"Product added to DB" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//            [alert show];
        }
        sqlite3_close(database);
        
    } else {
        NSLog(@"Error: %s", error);
    }
}

- (void)dealloc
{
    [super dealloc];
    [self.companyList release];
    [self.appleProduct release];
    [self.samsungProduct release];
    [self.googleProduct release];
    [self.nokiaProduct release];
}

@end
