/*
 Disclaimer: IMPORTANT:  This About Objects software is supplied to you by
 About Objects, Inc. ("AOI") in consideration of your agreement to the 
 following terms, and your use, installation, modification or redistribution
 of this AOI software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this AOI software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, AOI grants you a personal, non-exclusive
 license, under AOI's copyrights in this original AOI software (the
 "AOI Software"), to use, reproduce, modify and redistribute the AOI
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the AOI Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the AOI Software.
 Neither the name, trademarks, service marks or logos of About Objects, Inc.
 may be used to endorse or promote products derived from the AOI Software
 without specific prior written permission from AOI.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by AOI herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the AOI Software may be incorporated.
 
 The AOI Software is provided by AOI on an "AS IS" basis.  AOI
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE AOI SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL AOI BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE AOI SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF AOI HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) About Objects, Inc. 2009. All rights reserved.
 */
#import "Book.h"

@implementation Book

@synthesize title = _title;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;

@dynamic author;

@synthesize publicationYear = _publicationYear;
@synthesize imageFilePath = _imageFilePath;

- (void)dealloc
{
    [_title release];
    [_firstName release];
    [_lastName release];
    [_imageFilePath release];
    [_publicationYear release];
    
    [super dealloc];
}

+ (NSArray *)keys
{
    return [NSArray arrayWithObjects:
            @"title",
            @"firstName",
            @"lastName",
            @"publicationYear",
            @"imageFilePath",
            nil];
}

+ (NSNumberFormatter *)numberFormatter
{
    static NSNumberFormatter *_formatter;
    
    if (_formatter == nil)
    {
        _formatter = [[NSNumberFormatter alloc] init];
    }
    
    return _formatter;
}

- (id)init
{
    self = [super init];
    
    //  Set these to blank string to avoid writing nil to the
    //  plist file if user doesn't set all the values.
    //
    [self setTitle:@""];
    [self setLastName:@""];
    [self setFirstName:@""];
    
    [self setImageFilePath:@"NoImage.png"];
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    
    NSString *yearStr = [dictionary valueForKey:@"publicationYear"];
    NSNumber *year = [[[self class] numberFormatter] numberFromString:yearStr];
    [self setPublicationYear:year];
    
    NSMutableDictionary *mutableDict = [dictionary mutableCopy];
    [mutableDict removeObjectForKey:@"publicationYear"];
    
    [self setValuesForKeysWithDictionary:mutableDict];
    
    return self;
}

- (NSString *)author
{
    return [NSString stringWithFormat:@"%@, %@", 
            [self lastName], 
            [self firstName]];
}

@end
