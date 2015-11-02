//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by XCodeClub on 10/29/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parent.h"

@interface DataAccessObject : NSObject

@property (nonatomic, retain, readonly) NSMutableArray *companyList;

@property (nonatomic, retain, readonly) NSMutableArray *appleProduct;
@property (nonatomic, retain, readonly) NSMutableArray *samsungProduct;
@property (nonatomic, retain, readonly) NSMutableArray *googleProduct;
@property (nonatomic, retain, readonly) NSMutableArray *nokiaProduct;



+ (instancetype)sharedInstance;

- (void)addCompanyWithName:(NSString *)name andLogo:(NSString *)logo;
- (void)addProductToCompany:(Parent *)company withName:(NSString *)name andLogo:(NSString *)logo andUrl:(NSString *)url;

@end
