//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company+CoreDataProperties.h"


@interface ProductViewController : UICollectionViewController

@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) NSMutableArray *products;





@end
