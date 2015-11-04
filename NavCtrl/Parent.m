//
//  Parent.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Parent.h"

@interface Parent ()

@property (nonatomic, retain, readwrite) NSString *name;
@property (nonatomic, retain, readwrite) NSString *logo;
@property (nonatomic, retain, readwrite) NSString *symbol;
@property (nonatomic, retain, readwrite) NSMutableArray *products;

@end

@implementation Parent

-(instancetype)initWithName:(NSString *)name andLogo:(NSString *)logo andProduct:(NSMutableArray *)product andSymbol:(NSString *)symbol
{
    self.name = name;
    self.logo = logo;
    self.products = product;
    self.symbol = symbol;
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [self.name release];
    [self.logo release];
    [self.products release];
    [self.symbol release];
}





@end
