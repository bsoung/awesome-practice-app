//
//  Product.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithName:(NSString *)name andUrl:(NSString *)url andLogo:(NSString *)logo
{
    self.name = name;
    self.url = url;
    self.logo = logo;
    
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
