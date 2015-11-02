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
#import "MyDetailController.h"
#import "EditableDetailCell.h"
#import "Book.h"

@implementation MyDetailController

@synthesize book = _book;
@synthesize listController = _listController;

@synthesize titleCell = _titleCell;
@synthesize authorCell = _authorCell;
@synthesize yearCell = _yearCell;
@synthesize imagePathCell = _imagePathCell;

#pragma mark -

- (void)dealloc
{
    [_book release];
    [_listController release];
    
    [_titleCell release];
    [_authorCell release];
    [_yearCell release];
    [_imagePathCell release];
    
    [super dealloc];
}

- (BOOL)isModal
{
    NSArray *viewControllers = [[self navigationController] viewControllers];
    UIViewController *rootViewController = [viewControllers objectAtIndex:0];
    
    return rootViewController == self;
}

//  Convenience method that returns a fully configured new instance of 
//  EditableDetailCell. Note that methods whose names begin with 'alloc' or
//  'new', or whose names contain 'copy', should return a non-autoreleased
//  instance with a retain count of one, as we do here.
//
- (EditableDetailCell *)newDetailCellWithTag:(NSInteger)tag
{
    EditableDetailCell *cell = [[EditableDetailCell alloc] initWithFrame:CGRectZero 
                                                         reuseIdentifier:nil];
    [[cell textField] setDelegate:self];
    [[cell textField] setTag:tag];
    
    return cell;
}

#pragma mark -
#pragma mark Action Methods

- (void)save
{
    [[self listController] addObject:[self book]];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIViewController Methods

- (void)viewDidLoad
{
    //  If the user clicked the '+' button in the list view, we're
    //  creating a new entry rather than modifying an existing one, so 
    //  we're in a modal nav controller. Modal nav controllers don't add
    //  a back button to the nav bar; instead we'll add Save and 
    //  Cancel buttons.
    //  
    if ([self isModal])
    {
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] 
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                       target:self
                                       action:@selector(save)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        [saveButton release];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                         target:self
                                         action:@selector(cancel)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        [cancelButton release];
    }
    
    [self setTitleCell:    [self newDetailCellWithTag:BookTitle]];
    [self setAuthorCell:   [self newDetailCellWithTag:BookAuthor]];
    [self setYearCell:     [self newDetailCellWithTag:BookYear]];
    [self setImagePathCell:[self newDetailCellWithTag:BookImagePath]];
}

//  Override inherited method to automatically place the insertion point in the
//  first field.
//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUInteger indexes[] = { 0, 0 };
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes
                                                        length:2];
    
    EditableDetailCell *cell = (EditableDetailCell *)[[self tableView]
                                                      cellForRowAtIndexPath:indexPath];
    
    [[cell textField] becomeFirstResponder];
}

//  Force textfields to resign firstResponder so that our implementation of
//  -textFieldDidEndEditing: will be called. That'll ensure that all current
//  UI values are flushed to our model object before the detail view disappears.
//
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (NSUInteger section = 0; section < [[self tableView] numberOfSections]; section++)
    {
        NSUInteger indexes[] = { section, 0 };
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes
                                                            length:2];
        
        EditableDetailCell *cell = (EditableDetailCell *)[[self tableView]
                                                          cellForRowAtIndexPath:indexPath];
        if ([[cell textField] isFirstResponder])
        {
            [[cell textField] resignFirstResponder];
        }
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol

//  Sets the label of the keyboard's return key to 'Done' when the insertion
//  point moves to the table view's last field.
//
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField tag] == 3)
    {
        [textField setReturnKeyType:UIReturnKeyDone];
    }
    
    return YES;
}

//  UITextField sends this message to its delegate after resigning
//  firstResponder status. Use this as a hook to save the text field's
//  value to the corresponding property of the model object.
//  
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //  Keep a single NSNumberFormatter instance in a static variable so we
    //  don't have to create a new one each time. Note: We're allowing this code 
    //  to leak the instance, since only one instance will ever be created.
    //
    static NSNumberFormatter *_formatter;
    if (_formatter == nil)
        _formatter = [[NSNumberFormatter alloc] init];
    
    NSString *text = [textField text];
    NSUInteger tag = [textField tag];
    
    switch (tag)
    {
        case BookTitle:     [_book setTitle:text];          break;
        case BookAuthor:    [_book setAuthor:text];         break;
        case BookYear:      [_book setPublicationYear:[_formatter numberFromString:text]]; break;
        case BookImagePath: [_book setImageFilePath:text];  break;
    }
}

//  UITextField sends this message to its delegate when the return key
//  is pressed. Use this as a hook to navigate back to the list view 
//  (by 'popping' the current view controller, or dismissing a modal nav
//  controller, as the case may be).
//
//  If the user is adding a new item rather than editing an existing one,
//  respond to the return key by moving the insertion point to the next cell's
//  textField, unless we're already at the last cell.
//
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField returnKeyType] == UIReturnKeyNext)
    {
        //  The keyboard's return key is currently displaying 'Next' instead of
        //  'Done', so just move the insertion point to the next field. The
        //  keyboard will display 'Done' when we're at the last field.
        //
        //  (See the implementation of -textFieldShouldBeginEditing:, above.)
        //
        NSInteger nextTag = [textField tag] + 1;
        UIView *nextTextField = [[self tableView] viewWithTag:nextTag];
        
        [nextTextField becomeFirstResponder];
    }
    else if ([self isModal])
    {
        //  We're in a modal navigation controller, which means the user is
        //  adding a new book rather than editing an existing one.
        //
        [self save];
    }
    else
    {
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
    return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    //  One section for each of the book's properties.
    //
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:  return @"Title";
        case 1:  return @"Author";
        case 2:  return @"Year";
        case 3:  return @"Image File";
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Determine the text field's value. Each section of the table view
    //  is mapped to a property of the book object we're displaying.
    //
    EditableDetailCell *cell = nil;
    NSString *text = nil;
    
    NSUInteger section = [indexPath section];
    switch (section) 
    {
        case BookTitle:
            cell = [self titleCell];
            text = [_book title];
            break;
        case BookAuthor:
            cell = [self authorCell];
            text = [_book author];
            break;
        case BookYear:
            cell = [self yearCell];
            text = [[_book publicationYear] stringValue];
            break;
        case BookImagePath:
            cell = [self imagePathCell];
            text = [_book imageFilePath];
            break;
    }
    
    UITextField *textField = [cell textField];
    [textField setText:text];
    
    if (section == BookYear)
    {
        //  The 'publicationYear' property is an NSNumber, so switch the 
        //  textField's keyboard type to UIKeyboardTypeNumbersAndPunctuation.
        //
        [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    }
    
    return cell;
}

@end

