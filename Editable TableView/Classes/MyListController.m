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
#import "MyListController.h"
#import "MyDetailController.h"
#import "UIImage+Resizing.h"
#import "Book.h"

@implementation MyListController

@synthesize displayedObjects = _displayedObjects;

#pragma mark -

- (void)dealloc
{
    [_displayedObjects release];
    
    [super dealloc];
}

//  Lazily initializes array of displayed objects
//
- (NSMutableArray *)displayedObjects
{
    if (_displayedObjects == nil)
    {
        _displayedObjects = [[NSMutableArray alloc] initWithObjects:
                             [Book bookWithTitle:@"Middlemarch"
                                          author:@"Eliot, George"
                                            year:1874
                                   imageFilePath:@"Eliot.jpg"],
                             [Book bookWithTitle:@"War and Peace"
                                          author:@"Tolstoy, Leo"
                                            year:1869
                                   imageFilePath:@"Tolstoy.jpg"],
                             [Book bookWithTitle:@"Mansfield Park"
                                          author:@"Austen, Jane"
                                            year:1814
                                   imageFilePath:@"Austen.jpg"],
                             [Book bookWithTitle:@"The New Atlantis"
                                          author:@"Bacon, Francis"
                                            year:1627
                                   imageFilePath:@"Bacon.jpg"],
                             [Book bookWithTitle:@"The Old Man and the Sea"
                                          author:@"Hemingway, Ernest"
                                            year:1952
                                   imageFilePath:@"Hemingway.jpg"],
                             nil];
    }
    
    return _displayedObjects;
}

- (void)addObject:(id)anObject
{
    if (anObject != nil)
    {
        [[self displayedObjects] addObject:anObject];
    }
}

#pragma mark -
#pragma mark UIViewController

//  Override inherited method to automatically refresh table view's data
//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self tableView] reloadData];
}


//  Override inherited method to configure Add and Edit buttons
//
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  The controller's title (if set) will be displayed in the
    //  navigation controller's navigation bar at the top of the screen.
    //
    [self setTitle:@"Books"];
    
    [[self tableView] setRowHeight:54.0];
    
    //  Configure the Edit button
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    //  Configure the Add button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(add)];
    
    [[self navigationItem] setRightBarButtonItem:addButton];
    [addButton release];
}

//  Override inherited method to enable/disable Edit button
//
- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated
{
    [super setEditing:editing
             animated:animated];
    
    UIBarButtonItem *editButton = [[self navigationItem] rightBarButtonItem];
    [editButton setEnabled:!editing];
}

#pragma mark -
#pragma mark Action Methods

//  Creates a new nav controller with an instance of MyDetailController as
//  its root view controller, and runs it as a modal view controller. By
//  default, that causes the detail view to be animated as sliding up from
//  the bottom of the screen. And because the detail controller is the root
//  view controller, there's no back button.
//
- (void)add
{
    MyDetailController *controller = [[MyDetailController alloc]
                                      initWithStyle:UITableViewStyleGrouped];
    
    id book = [[Book alloc] init];
    [controller setBook:book];
    [controller setListController:self];
    
    UINavigationController *newNavController = [[UINavigationController alloc]
                                                initWithRootViewController:controller];
    
    [[self navigationController] presentModalViewController:newNavController
                                                   animated:YES];
    
    [book release];
    [controller release];
}


#pragma mark -
#pragma mark UITableViewDelegate Protocol
//
//  The table view's delegate is notified of runtime events, such as when
//  the user taps on a given row, or attempts to add, remove or reorder rows.

//  Notifies the delegate when the user selects a row.
//
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyDetailController *controller = [[MyDetailController alloc]
                                      initWithStyle:UITableViewStyleGrouped];
    
    NSUInteger index = [indexPath row];
    id book = [[self displayedObjects] objectAtIndex:index];
    
    [controller setBook:book];
    [controller setTitle:[book title]];
    
    [[self navigationController] pushViewController:controller
                                           animated:YES];
	[controller release];
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol
//
//  By default, UITableViewController makes itself the delegate of its own
//  UITableView instance, so we can implement data source protocol methods here.
//  You can move these methods to another class if you prefer -- just be sure 
//  to send a -setDelegate: message to the table view if you do.


//  Returns the number of rows in the current section.
//
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[self displayedObjects] count];
}

//  Return YES to allow the user to reorder table view rows
//
- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//  Invoked when the user drags one of the table view's cells. Mirror the
//  change in the user interface by updating the array of displayed objects.
//
- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)targetIndexPath
{
    NSUInteger sourceIndex = [sourceIndexPath row];
    NSUInteger targetIndex = [targetIndexPath row];
    
    if (sourceIndex != targetIndex)
    {
        [[self displayedObjects] exchangeObjectAtIndex:sourceIndex
                                     withObjectAtIndex:targetIndex];
    }
}

//  Update array of displayed objects by inserting/removing objects as necessary.
//
- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[self displayedObjects] removeObjectAtIndex:[indexPath row]];
        
        //  Animate deletion
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [[self tableView] deleteRowsAtIndexPaths:indexPaths
                                withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Return a cell containing the text to display at the provided row index.
//
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"MyCell"];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        UIFont *titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:18.0];
        [[cell textLabel] setFont:titleFont];
        
        UIFont *detailFont = [UIFont fontWithName:@"Georgia" size:16.0];
        [[cell detailTextLabel] setFont:detailFont];
        
        [cell autorelease];
    }
    
    NSUInteger index = [indexPath row];
    id book = [[self displayedObjects] objectAtIndex:index];
    
    NSString *title = [book title];
    [[cell textLabel] setText:(title == nil || [title length] < 1 ? @"?" : title)];
    
    NSString *detailText = [NSString stringWithFormat:
                            @"%@    %@",
                            [book publicationYear],
                            [book author]];
    
    [[cell detailTextLabel] setText:detailText];
    
    NSString *path = [book imageFilePath];
    if (path != nil)
    {
        UIImage *image = [UIImage imageNamed:path];
        image = [image imageScaledToSize:CGSizeMake(36.0, 42.0)];
        [[cell imageView] setImage:image];
    }
    
    return cell;
}

@end
