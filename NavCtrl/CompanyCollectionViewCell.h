//
//  CompanyCollectionViewCell.h
//  NavCtrl
//
//  Created by Benjamin Soung on 11/10/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain, readonly) UILabel *titleLabel;
@property (nonatomic, retain, readonly) UIImageView *imageView;
@property (nonatomic, retain, readonly) UILabel *stockSymbol;
@property (nonatomic, retain, readonly) UILabel *nameLabel;

@end
