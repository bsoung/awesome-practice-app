//
//  Product.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, retain, readonly) NSString *url;
@property (nonatomic, retain, readonly) NSString *logo;
@property (nonatomic, assign, readonly) NSInteger company_ID;
@property (nonatomic, assign, readonly) NSInteger product_ID;

-(instancetype)initWithName:(NSString *)name andUrl:(NSString *)url andLogo:(NSString *)logo andCompanyID:(NSInteger)company_ID andProductID:(NSInteger)product_ID;

@end
