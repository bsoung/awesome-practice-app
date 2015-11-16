//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "ProductViewController.h"


@interface CompanyViewController : UICollectionViewController
@property (nonatomic, retain, readonly) NSString *nameLabel;
@property (nonatomic, retain, readonly) NSString *priceLabel;


- (void)addCompany:(id)sender;


@end
