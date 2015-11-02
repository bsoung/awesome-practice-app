//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductViewController;

@interface CompanyViewController : UITableViewController
@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;
@property (nonatomic, retain) NSString *nameLabel;
@property (nonatomic, retain) NSString *priceLabel;

- (void)addCompany:(id)sender;


@end
