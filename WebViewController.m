//
//  webView.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "Company.h"

@interface WebViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{

    self = [super initWithCoder:aDecoder];
    return self;

}


- (void)dealloc
{
    [super dealloc];
    if (self.url)
    [self.url release];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];

}




@end
