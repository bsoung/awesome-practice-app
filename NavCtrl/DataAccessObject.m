//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by XCodeClub on 10/29/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"
#import "Product.h"


@interface DataAccessObject ()


@property (nonatomic, retain, readwrite) NSMutableArray *companyList;

@property (nonatomic, retain, readwrite) NSMutableArray *appleProduct;
@property (nonatomic, retain, readwrite) NSMutableArray *samsungProduct;
@property (nonatomic, retain, readwrite) NSMutableArray *googleProduct;
@property (nonatomic, retain, readwrite) NSMutableArray *nokiaProduct;

@end


@implementation DataAccessObject


+ (instancetype)sharedInstance
{
    static DataAccessObject *instance;
    
    static dispatch_once_t onceToken; //# of times
    dispatch_once(&onceToken, ^
    {
        instance = [[DataAccessObject alloc] privateInit];
    });

    return instance;
}

- (instancetype)privateInit
{
    self = [super init];
    if (self)
    {
      
        self.appleProduct = [NSMutableArray arrayWithObjects:
                             [[Product alloc] initWithName:@"iPad" andUrl:@"https://www.apple.com/ipad/" andLogo:@"ipadlogo.jpeg"],
                             [[Product alloc] initWithName:@"iPhone" andUrl:@"https://www.apple.com/iphone/" andLogo:@"iphonelogo.jpeg"],
                             [[Product alloc] initWithName:@"iTouch" andUrl:@"https://www.apple.com/shop/buy-ipod/ipod-touch" andLogo:@"itouchlogo.jpeg"],
                             nil];
        
        self.samsungProduct = [NSMutableArray arrayWithObjects:
                               [[Product alloc] initWithName:@"Galaxy S4" andUrl:@"https://www.apple.com/iphone/" andLogo:@"galaxys4logo.jpeg"],
                               [[Product alloc] initWithName:@"Galaxy Note" andUrl:@"https://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find" andLogo:@"galaxynotelogo.jpeg"],
                               [[Product alloc] initWithName:@"Galaxy Tab" andUrl:@"https://www.samsung.com/us/mobile/galaxy-tab/" andLogo:@"galaxytablogo.jpeg"],
                               nil];
        
        self.googleProduct = [NSMutableArray arrayWithObjects:
                              [[Product alloc] initWithName:@"Nexus 6" andUrl:@"https://www.google.com/nexus/6p/" andLogo:@"nexus6logo.jpeg"],
                              [[Product alloc] initWithName:@"Nexus 7" andUrl:@"https://store.google.com/product/nexus_7" andLogo:@"nexus7logo.jpeg"],
                              [[Product alloc] initWithName:@"Nexus 9" andUrl:@"https://www.google.com/nexus/9/" andLogo:@"nexus9logo.jpg"],
                              nil];
        
        self.nokiaProduct = [NSMutableArray arrayWithObjects:
                             [[Product alloc] initWithName:@"Nokia 640" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia640/" andLogo:@"lumia640logo.jpeg"],
                             [[Product alloc] initWithName:@"Nokia 640 XL" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia640-xl/" andLogo:@"lumia640xllogo.jpeg"],
                             [[Product alloc] initWithName:@"Nokia 1520" andUrl:@"https://www.microsoft.com/en-us/mobile/phone/lumia1520/" andLogo:@"nokia1520logo.jpeg"], nil];
        
        self.companyList = [NSMutableArray arrayWithObjects:
                            [[Parent alloc] initWithName:@"Apple" andLogo:@"applelogo.jpeg" andProduct:self.appleProduct],
                            [[Parent alloc] initWithName:@"Samsung" andLogo:@"samsunglogo.jpeg" andProduct:self.samsungProduct],
                            [[Parent alloc] initWithName:@"Google" andLogo:@"googlelogo.jpeg" andProduct:self.googleProduct],
                            [[Parent alloc] initWithName:@"Nokia" andLogo:@"nokialogo.jpeg" andProduct:self.nokiaProduct], nil];
    }
    return self;


}

- (void)addCompanyWithName:(NSString *)name andLogo:(NSString *)logo
{
    logo = @"ipadlogo.jpeg";
    Parent *company = [[Parent alloc] initWithName:name andLogo:logo andProduct:[NSMutableArray array]];
    
    [self.companyList addObject:company];


}

- (void)addProductToCompany:(Parent *)company withName:(NSString *)name andLogo:(NSString *)logo andUrl:(NSString *)url
{
    logo = @"ipadlogo.jpeg";
    Product *product = [[Product alloc] initWithName:name andUrl:url andLogo:logo];
    
    [company.products addObject:product];



}

- (void)dealloc
{
    [super dealloc];
    [self.companyList release];
    [self.appleProduct release];
    [self.samsungProduct release];
    [self.googleProduct release];
    [self.nokiaProduct release];
}

@end
