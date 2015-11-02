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
@synthesize firstNameCell = _firstNameCell;
@synthesize lastNameCell = _lastNameCell;
@synthesize yearCell = _yearCell;
@synthesize imagePathCell = _imagePathCell;

#pragma mark -

- (void)dealloc
{
    [_listController release];
    [_book release];
    
    [_titleCell release];
    [_firstNameCell release];
    [_lastNameCell release];
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
    [self setLastNameCell: [self newDetailCellWithTag:BookLastName]];
    [self setFirstNameCell:[self newDetailCellWithTag:BookFirstName]];
    [self setYearCell:     [self newDetailCellWithTag:BookYear]];
    [self setImagePathCell:[self newDetailCellWithTag:BookImagePath]];
}

//  Override this method to automatically place the insertion point in the
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
//  -textFieldDidEndEditing: gets called. That will ensure that the current
//  UI values are flushed to our model object before we return to the list view.
//
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (NSUInteger section = 0; section < [[self tableView] numberOfSections]; section++)
    {
        for (NSUInteger row = 0; row < [[self tableView] numberOfRowsInSection:section]; row++)
        {
            NSUInteger indexes[] = { section, row };
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
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol

//  Sets the label of the keyboard's return key to 'Done' when the insertion
//  point moves to the table view's last field.
//
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField tag] == BookImagePath)
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
    static NSNumberFormatter *_formatter;
    
    if (_formatter == nil)
    {
        _formatter = [[NSNumberFormatter alloc] init];
    }
    
    NSString *text = [textField text];
    
    switch ([textField tag])
    {
        case BookTitle:     [_book setTitle:text];          break;
        case BookLastName:  [_book setLastName:text];       break;
        case BookFirstName: [_book setFirstName:text];      break;
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
    if ([textField returnKeyType] != UIReturnKeyDone)
    {
        //  If this is not the last field (in which case the keyboard's
        //  return key label will currently be 'Next' rather than 'Done'), 
        //  just move the insertion point to the next field.
        //
        //  (See the implementation of -textFieldShouldBeginEditing: above.)
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return section == 1 ? 2 : 1;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case TitleSection:  return @"Title";
        case AuthorSection: return @"Author";
        case YearSection:   return @"Year";
        case ImageSection:  return @"Image File";
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditableDetailCell *cell = nil;
    NSInteger tag = INT_MIN;
    NSString *text = nil;
    NSString *placeholder = nil;
    
    //  Pick the editable cell and the values for its textField
    //
    NSUInteger section = [indexPath section];
    switch (section) 
    {
        case TitleSection:
        {
            cell = [self titleCell];
            text = [_book title];
            tag = BookTitle;
            placeholder = @"Book Title";
            break;
        }
        case AuthorSection:
        {
            if ([indexPath row] == 0)
            {
                cell = [self lastNameCell];
                text = [_book lastName];
                tag = BookLastName;
                placeholder = @"Last Name";
            }
            else
            {
                cell = [self firstNameCell];
                text = [_book firstName];
                tag = BookFirstName;
                placeholder = @"First Name";
            }
            break;            
        }
        case YearSection:
        {
            cell = [self yearCell];
            text = [[_book publicationYear] stringValue];
            tag = BookYear;
            placeholder = @"Year";
            break;
        }
        case ImageSection:
        {
            cell = [self imagePathCell];
            text = [_book imageFilePath];
            tag = BookImagePath;
            break;
        }
    }
    
    UITextField *textField = [cell textField];
    [textField setTag:tag];
    [textField setText:text];
    [textField setPlaceholder:placeholder];
    
    if (section == YearSection)
    {
        // 'publicationYear' is an NSNumber, so show a numeric keyboard.
        [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    }
    
    return cell;
}

@end
