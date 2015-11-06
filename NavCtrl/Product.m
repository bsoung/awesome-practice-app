//
//  Product.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@interface Product ()

@property (nonatomic, retain, readwrite) NSString *name;
@property (nonatomic, retain, readwrite) NSString *url;
@property (nonatomic, retain, readwrite) NSString *logo;
@property (nonatomic, assign, readwrite) NSInteger company_ID;
@property (nonatomic, assign, readwrite) NSInteger product_ID;

@end

@implementation Product

-(instancetype)initWithName:(NSString *)name andUrl:(NSString *)url andLogo:(NSString *)logo andCompanyID:(NSInteger)company_ID andProductID:(NSInteger)product_ID
{
    self.name = name;
    self.url = url;
    self.logo = logo;
    self.company_ID = company_ID;
    self.product_ID = product_ID;
    
    return self;

}


- (void)dealloc
{
    [super dealloc];
    [self.name release];
    [self.url release];
    [self.logo release];

}

@end
