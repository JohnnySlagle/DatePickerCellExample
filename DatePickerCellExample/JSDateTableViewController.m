//
//  JSDateTableViewController.m
//  DatePickerCellExample
//
//  Created by Johnny on 11/8/12.
//  Copyright (c) 2012 Johnny Slagle. All rights reserved.
//

#import "JSDateTableViewController.h"

//
//TODO: Implement other solutions to use a UIDatePicker or custom view with a UITableViewCell
//

#pragma mark - Table Section Enum
typedef enum {
    JSDateTableSectionLabel,
    numberOfTableSections
} JSDateTableSections;


#pragma mark - JSDateTableViewController Class Extension
@interface JSDateTableViewController ()

@property (nonatomic, strong) NSDate *currentlySelectedDate;

@end


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
    
    UITableViewCell *cell = nil;
    
    if(iIndexPath.section == JSDateTableSectionLabel) {
        cell = (JSDatePickerCell *)[iTableView dequeueReusableCellWithIdentifier:LabelIdentifier];
        
        if(cell == nil) {
            cell = [[JSDatePickerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LabelIdentifier];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
            cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:17.0];
        }

        cell.textLabel.text = @"Birthday";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == JSDateTableSectionLabel) {
        return @"TableViewCell Subclass Solution";
    }
    return nil;
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

#pragma mark - JSDatePickerCellDelegate
- (void)datePickerCell:(JSDatePickerCell *)iCell didEndEditingWithDate:(NSDate *)iDate {
    	NSLog(@"%@ date changed to: %@", iCell.detailTextLabel.text, iDate);
}

@end
