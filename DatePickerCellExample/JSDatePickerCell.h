//
//  JSDatePickerCell.h
//  DatePickerCellExample
//
//  Created by Johnny on 11/8/12.
//  Copyright (c) 2012 Johnny Slagle. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JSDatePickerCell;

/*
 *  The name of the notification posted to NSNotificationCenter when the date is changed.
 */
static NSString *JSDATEPICKERCELL_DID_END_EDITING_NOTIFICATION = @"JSDATEPICKERCELL_DID_END_EDITING_NOTIFICATION";


/*
 *  JSDatePickerCellDelegate
 *
 *  This protocol is to be used to inform a delegate that the cell's date picker did change it's value
 */
#pragma mark - JSDatePickerCellDelegate
@protocol JSDatePickerCellDelegate <NSObject>

@optional
- (void)datePickerCell:(JSDatePickerCell *)iCell didEndEditingWithDate:(NSDate *)iDate;

@end

#pragma mark - JSDatePickerCell Interface
@interface JSDatePickerCell : UITableViewCell

#pragma mark - Properties
@property (nonatomic, weak) id<JSDatePickerCellDelegate> delegate;

@property (nonatomic, assign, getter = isTapGestureDismissEnabled) BOOL tapGestureDismissEnabled;

@end
