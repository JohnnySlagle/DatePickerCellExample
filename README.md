DatePickerCellExample
=====================

##Introduction
An example on how to use a UIDatePicker with a UITableViewCell without going through a UITextField.

##This Solution
This solution is done by creating our own subclass of UITableViewCell called **JSDatePickerCell** and updating the existing UITableView's detailTextLabel with a formatted date.

**JSDatePickerCell** handles all the logic of hiding and showing a UIDatePicker, is the datePicker's delegate, maintains a NSDate object and automatically formats and sets the current date to the detailTextLabel.

It also provides the option to become it's delegate to be notified of when the value changes.

Additional, when the date changes it posts the notification *JSDATEPICKERCELL_DID_END_EDITING_NOTIFICATION* to NSNotificationCenter with the cell as the object.


##How to Use
1. Include JSDatePickerCell.h and JSDatePickerCell.m into your project.
2. Use as you would a UITableViewCell

Example:

```
- (UITableViewCell *)tableView:(UITableView *)iTableView cellForRowAtIndexPath:(NSIndexPath *)iIndexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    JSDatePickerCell *cell = (JSDatePickerCell *)[iTableView dequeueReusableCellWithIdentifier:LabelIdentifier];
    
    if(cell == nil) {
		cell = [[JSDatePickerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LabelIdentifier];
    }
    
    cell.textLabel.text = @"Some Text";
    
    return cell;
}

```
*Note: Remember in iOS 6 they have the new dequeue method dequeueReusableCellWithIdentifier:forIndexPath: which requires you to provide registerClass:forCellReuseIdentifier:.*

##Limitations
- Currently only provides a UIDatePicker with the mode UIDatePickerModeDate. Thus, no custom views or other UIDatePicker modes.

##Other Solutions

Now, I am aware that there may be easier ways to do this and this solution might not work for your problem. Two of these *other solutions* are:

1. Use a UIDatePicker through a UITextField.  Just add a UITextField to the cell and setup up accordingly.
	- **Pros:** Simple.  UITextField already has the inputView and inputAccessoryView properties and logic.
	- **Cons:** Cannot hide the cursor without using private APIs.  Something still needs to handle the delegation of the UIDatePicker, date formatting, and such logic.
	
2. Create your own UILabel subclass, add inputView and inputAccessoryView properties, override UIResponder's *touchesEnded:withEvent:* and *canBecomeFirstResponder* to allow the label to becomeFirstResponder.
	- **Pros:** Can attach any view to the inputView and inputAccessoryView. 
	- **Cons:** A little more work than above.  You still need to handle the logic of whatever inputView you attach to it and the control when to resignFirstResponder and becomeFirstResponder.

*Note: These solutions are good but they each come with their individual pros and cons that one should compare and figure out which is best for their individual situation.*

