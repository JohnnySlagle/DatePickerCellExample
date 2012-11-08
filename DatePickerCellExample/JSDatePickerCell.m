//
//  JSDatePickerCell.m
//  DatePickerCellExample
//
//  Created by Johnny on 11/8/12.
//  Copyright (c) 2012 Johnny Slagle. All rights reserved.
//

#import "JSDatePickerCell.h"

#pragma mark - Defines
#define USE_TAP_GESTURE_DISMISS 0

#pragma mark - Class Extension
@interface JSDatePickerCell ()

@property (nonatomic, strong) NSDate *dateValue;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) UIToolbar *inputAccessoryToolbar;

#if USE_TAP_GESTURE_DISMISS
@property (nonatomic, strong) UITapGestureRecognizer *tapDismissGesture;
#endif

@end

#pragma mark - Global Static Variables
//static CGFloat kDefaultDatePickerHeight = 300.0f;
static NSString *kDatePickerFormat = @"MMMM dd, yyyy";

@implementation JSDatePickerCell

// Note: For some reason all other properties were getting their automatic ivar except this one.
@synthesize dateValue = _dateValue;

#pragma mark - Init Methods
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Setup this cell's "inputView"
        [self setupInputView];
    }
    return self;
}

#pragma mark - Setup methods
- (void)setupInputView {
    // Setup with default date
    self.detailTextLabel.text = [self formattedDate];
}

#pragma mark - UIDatePicker Methods & Selectors
- (void)dateDidChange:(UIDatePicker *)iDatePicker {
    // Change the Date
	self.dateValue = iDatePicker.date;
    
    // Update the delegate
	if (self.delegate && self.dateValue) {
        if ([self.delegate respondsToSelector:@selector(datePickerCell:didEndEditingWithDate:)]) {
            [self.delegate datePickerCell:self didEndEditingWithDate:self.dateValue];
        }
	}
}

#pragma mark - UITableViewCell Overrides
- (UIView *)inputView {
    return self.datePicker;
}

-(UIView *)inputAccessoryView {
    return self.inputAccessoryToolbar;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
	if (selected) {
		[self becomeFirstResponder];

#if USE_TAP_GESTURE_DISMISS
        // Setup Tap Gesture
        UITableView *tableView = (UITableView *)self.superview;
        self.tapDismissGesture = [[UITapGestureRecognizer alloc]
                             initWithTarget:self
                             action:@selector(dismissInputView)];
        
        [tableView addGestureRecognizer:self.tapDismissGesture];
#endif
	}
}

#pragma mark - Lazy Instantiation Getters
- (NSDate *)dateValue {
    if(_dateValue == nil) {
        _dateValue = [NSDate date];
    }
    return _dateValue;
}

- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.hidden = NO;
        _datePicker.date = self.dateValue;
                
        [_datePicker addTarget:self
                        action:@selector(dateDidChange:)
              forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (NSDateFormatter *)dateFormatter {
    if(_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:kDatePickerFormat];
    }
    return _dateFormatter;
}

- (UIToolbar *)inputAccessoryToolbar {
    if(_inputAccessoryToolbar == nil) {
        _inputAccessoryToolbar = [[UIToolbar alloc] init];
        _inputAccessoryToolbar.barStyle = UIBarStyleBlackTranslucent;
        _inputAccessoryToolbar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_inputAccessoryToolbar sizeToFit];
        
        //FIXME: I think I can change this..sort of wacky
        CGRect frame = _inputAccessoryToolbar.frame;
        frame.size.height = 44.0f;
        _inputAccessoryToolbar.frame = frame;
        
        UIBarButtonItem *doneBarButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTapped)];
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft, doneBarButton, nil];
        [_inputAccessoryToolbar setItems:array];
    }
    return _inputAccessoryToolbar;
}

#pragma mark - Custom Setters
- (void)setDateValue:(NSDate *)dateValue {
    _dateValue = dateValue;
    self.detailTextLabel.text = [self formattedDate];
}


#pragma mark - Selectors & Misc Methods
- (NSString *) formattedDate {
    return [self.dateFormatter stringFromDate:self.dateValue];
}

- (void)doneTapped {
	[self resignFirstResponder];
}

#if USE_TAP_GESTURE_DISMISS
- (void) dismissInputView {
    [self resignFirstResponder];
    
    UITableView *tableView = (UITableView *)self.superview;
    [tableView removeGestureRecognizer:self.tapDismissGesture];
}
#endif


#pragma mark - Overriding Responder Methods
- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (BOOL)becomeFirstResponder {
    self.datePicker.date = self.dateValue;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
	UITableView *tableView = (UITableView *)self.superview;
	[tableView deselectRowAtIndexPath:[tableView indexPathForCell:self] animated:YES];
	return [super resignFirstResponder];
}
@end
