//
//  ETExpenseDetailViewController.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/19/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseDetailViewController.h"
#import "ETExpenseItem.h"
#import "ETExpenseType.h"

typedef enum {
    ETExpenseTextFieldDate,
    ETExpenseTextFieldName,
    ETExpenseTextFieldAmount,
    ETExpenseTextFieldCategory,
}ETExpenseTextField;

@interface ETExpenseDetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;

@end

@implementation ETExpenseDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.dateTextField.text = [self.item.dateSpent stringWithFormat:@"MMM d, YYYY"];
    self.nameTextField.text = self.item.name;
    self.amountTextField.text = [self.item.amount stringValue];
    self.categoryTextField.text = self.item.type.name;
}


#pragma mark - Text Field Delegate methods

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BOOL shouldReturn = (textField.text != nil);
    if (shouldReturn) {
        [self.view endEditing:YES];
    }
    return shouldReturn;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL shouldReturn = (textField.text != nil);
    if (shouldReturn) {
        [self.view endEditing:YES];
    }
    return shouldReturn;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case ETExpenseTextFieldDate:
            self.item.dateSpent = [textField.text dateWithFormat:@"MMM d, YYYY"];
            self.item.dayId = [self.item.dateSpent stringWithFormat:@"YYYYMMMd"];
            break;
            
        case ETExpenseTextFieldName:
            self.item.name = textField.text;
            break;
            
        case ETExpenseTextFieldAmount:
            self.item.amount = [NSNumber numberWithFloat:[textField.text floatValue]];
            break;
            
        case ETExpenseTextFieldCategory:
            self.item.type.name = textField.text;
            break;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[ETStore sharedStore] saveChanges];
}



@end
