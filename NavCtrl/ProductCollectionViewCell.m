//
//  ProductCollectionViewCell.m
//  NavCtrl
//
//  Created by Benjamin Soung on 11/10/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionViewCell.h"
@interface ProductCollectionViewCell ()

@property (nonatomic, retain, readwrite) UILabel *titleLabel;
@property (nonatomic, retain, readwrite) UIImageView *imageView;

@end

#pragma mark - Programmatically creating the cells

@implementation ProductCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor lightGrayColor]];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width / 6, self.contentView.frame.size.height)];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:_imageView];
        
        if (self.titleLabel) {
            [self.titleLabel removeFromSuperview];
            [self.titleLabel release];
            self.titleLabel = nil;
        }
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.frame.size.width, 0, self.contentView.frame.size.width - self.imageView.frame.size.width, self.contentView.frame.size.height)];
        [self.contentView addSubview:self.titleLabel];
        
    }
    
    return self;
}

-(void)dealloc
{   //removed from superview.
    [self.titleLabel removeFromSuperview];
    [_imageView removeFromSuperview];
    
    [self.titleLabel release];
    [_imageView release];
    [super dealloc];

}

@end
