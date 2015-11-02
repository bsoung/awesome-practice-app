//
//  Parent.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Parent.h"

@implementation Parent

-(instancetype)initWithName:(NSString *)name andLogo:(NSString *)logo andProduct:(NSMutableArray *)product
{
    self.name = name;
    self.logo = logo;
    self.products = product;
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [self.name release];
    [self.logo release];
    [self.products release];
}





@end
