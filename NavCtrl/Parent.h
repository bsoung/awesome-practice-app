//
//  Parent.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parent : NSObject


@property (nonatomic, retain, readonly) NSString *name;
@property (nonatomic, retain, readonly) NSString *logo;
@property (nonatomic, retain, readonly) NSString *symbol;
@property (nonatomic, retain, readonly) NSMutableArray *products;
@property (nonatomic, assign, readonly) NSInteger company_ID;

- (instancetype)initWithName:(NSString *)name andLogo:(NSString *)logo andProduct:(NSMutableArray *)product andSymbol:(NSString *)symbol andID:(NSInteger)company_id;



@end
