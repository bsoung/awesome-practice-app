//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by XCodeClub on 10/29/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Parent.h"
#import "Product.h"


//also known as a "factory class"

@interface DataAccessObject : NSObject

@property (nonatomic, retain, readonly) NSMutableArray *companyList;
@property (nonatomic, retain, readonly) NSMutableArray *products;

@property (nonatomic, retain, readonly) NSMutableArray *appleProduct;
@property (nonatomic, retain, readonly) NSMutableArray *samsungProduct;
@property (nonatomic, retain, readonly) NSMutableArray *googleProduct;
@property (nonatomic, retain, readonly) NSMutableArray *nokiaProduct;







+ (instancetype)sharedInstance;

- (void)addCompanyWithName:(NSString *)name andLogo:(NSString *)logo andSymbol:(NSString *)symbol andID:(NSInteger)company_ID andWriteToDataBase:(BOOL)writeToDataBase;

- (void)addProductWithName:(NSString *)name andLogo:(NSString *)logo andUrl:(NSString *)url toCompanyWithID:(NSInteger)company_ID andWriteToDataBase:(BOOL)writeToDataBase andProductID:(NSInteger)product_ID;

- (void)checkAndCreateDatabase;

- (void)writeCompanyToDataBase:(Parent *)company;
- (void)writeProductToDataBase:(Product *)product;



@end
