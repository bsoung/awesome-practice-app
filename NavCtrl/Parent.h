//
//  Parent.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parent : NSObject


@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSMutableArray *products;

- (instancetype)initWithName:(NSString *)name andLogo:(NSString *)logo andProduct:(NSMutableArray *)product;



@end
