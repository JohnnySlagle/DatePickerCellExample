//
//  JSDateTableViewController.m
//  DatePickerCellExample
//
//  Created by Johnny on 11/8/12.
//  Copyright (c) 2012 Johnny Slagle. All rights reserved.
//

#import "JSDateTableViewController.h"

//#pragma mark - 
//#pragma mark Custom TableView Cell
//
//@interface UITextFieldCell : UITableViewCell
//
//@property (nonatomic, strong) UITextField *textField;
//
//@end


#pragma mark - Table Section Enum
typedef enum {
    JSDateTableSectionTextField,
    JSDateTableSectionLabel,
    numberOfTableSections
} JSDateTableSections;

#pragma mark - Class Extensions
@interface JSDateTableViewController ()


@property (nonatomic, strong) NSDate *currentlySelectedDate;

@end

#pragma mark - Global Static Variables

#pragma mark - JSDateTableViewController Implementation
@implementation JSDateTableViewController

#pragma mark - Init methods
- (id)initWithStyle:(UITableViewStyle)iStyle {
    self = [super initWithStyle:iStyle];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)iTableView {
    return numberOfTableSections;
}

- (NSInteger)tableView:(UITableView *)iTableView numberOfRowsInSection:(NSInteger)iSection {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)iTableView cellForRowAtIndexPath:(NSIndexPath *)iIndexPath {
    static NSString *LabelIdentifier = @"LabelCell";
    static NSString *TextFieldIdentifier = @"TextFieldCell";
    
    UITableViewCell *cell = nil;
    
    if(iIndexPath.section == JSDateTableSectionTextField) {
        cell = [iTableView dequeueReusableCellWithIdentifier:TextFieldIdentifier];
        
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextFieldIdentifier];
        }
        
        
    } else
    if(iIndexPath.section == JSDateTableSectionLabel) {
        cell = (JSDatePickerCell *)[iTableView dequeueReusableCellWithIdentifier:LabelIdentifier];
        
        if(cell == nil) {
            cell = [[JSDatePickerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LabelIdentifier];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
            cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:20.0];
        }

        cell.textLabel.text = @"Birthday";
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)iTableView didSelectRowAtIndexPath:(NSIndexPath *)iIndexPath {
    [iTableView deselectRowAtIndexPath:iIndexPath animated:YES];
}


#pragma mark - Lazy Instantiation
- (NSDate *)currentlySelectedDate {
    if (_currentlySelectedDate == nil) {
        _currentlySelectedDate = [NSDate date];
    }
    return _currentlySelectedDate;
}

#pragma mark - UIDatePicker Methods & Selectors

//- (void)dateDidChange:(UIDatePicker *)iDatePicker{
//    self.currentlySelectedDate = iDatePicker.date;
//    
//    // Note: If this was in a bigger table it would probably be smarter to ONLY reload the specific row or section
//    [self.tableView reloadData];
//}

#pragma mark - JSDatePickerCellDelegate
- (void)datePickerCell:(JSDatePickerCell *)iCell didEndEditingWithDate:(NSDate *)iDate {
    	NSLog(@"%@ date changed to: %@", iCell.detailTextLabel.text, iDate);
}

@end
