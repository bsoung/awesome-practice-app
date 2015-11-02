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
#import "MyAppDelegate.h"
#import "MyListController.h"

@implementation MyAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize listController = _listController;

#pragma mark -

- (void)dealloc 
{
    [_window release];
    [_navigationController release];
    [_listController release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate Protocol

//  Invoked just before the application terminates. Use this as a hook to
//  save any changes the user has made.
//
- (void)applicationWillTerminate:(UIApplication *)application
{
    [_listController save];
}

//  Creates a window and a table view controller, and makes the table view
//  controller's view a subview of the window.
//
- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:rect];
    [self setWindow:window];
    
    //  By default, UITableViewController populates its own 'view' property
    //  with a new instance of UITableView, and makes itself the table view
    //  instance's data source and delegate.
    //
    MyListController *tableViewController = [[MyListController alloc]
                                             initWithStyle:UITableViewStylePlain];
    [self setListController:tableViewController];
    
    //  UINavigationController is initialized with the view controller that
    //  manages its initial, or root, view. The navigation controller sets its
    //  own view property to point to the view of the view controller at the
    //  top of its internal stack of view controllers.
    //
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:tableViewController];
    
    [self setNavigationController:navController];
    
    [window addSubview:[navController view]];
    [window makeKeyAndVisible];
    
    [window release];
    [navController release];
}

@end
