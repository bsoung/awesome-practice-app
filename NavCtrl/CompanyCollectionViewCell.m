//
//  CompanyCollectionViewCell.m
//  NavCtrl
//
//  Created by Benjamin Soung on 11/10/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewCell.h"
@interface CompanyCollectionViewCell ()

@property (nonatomic, retain, readwrite) UILabel *titleLabel;
@property (nonatomic, retain, readwrite) UIImageView *imageView;
@property (nonatomic, retain, readwrite) UILabel *stockSymbol;
@property (nonatomic, retain, readwrite) UILabel *nameLabel;

@end

@implementation CompanyCollectionViewCell

#pragma mark - Programmatically setting up the Cells within Collection view

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width / 6, self.contentView.frame.size.height)];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.frame.size.width, 0, self.contentView.frame.size.width - self.imageView.frame.size.width, self.contentView.frame.size.height / 2)];
        [self.contentView addSubview:self.titleLabel];
        
        self.stockSymbol = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.frame.size.width, self.titleLabel.frame.size.height, (self.contentView.frame.size.width - self.imageView.frame.size.width) / 4, self.contentView.frame.size.height / 2)];
        [self.contentView addSubview:self.stockSymbol];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.stockSymbol.frame.origin.x + self.stockSymbol.frame.size.width, self.stockSymbol.frame.origin.y, self.contentView.frame.size.width - CGRectGetMaxX(self.stockSymbol.frame), CGRectGetHeight(self.stockSymbol.frame))];
        
        [self.contentView addSubview:self.nameLabel];
        
    }

    return self;

}

-(void)dealloc
{
    [self.titleLabel release];
    [self.imageView release];
    [self.stockSymbol release];
    [self.nameLabel release];
    [super dealloc];
}

@end
