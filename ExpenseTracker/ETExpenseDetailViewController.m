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

@property (strong, nonatomic) UIBarButtonItem *cancelButton;
@property (strong, nonatomic) UIBarButtonItem *doneButton;

@end

@implementation ETExpenseDetailViewController

- (void)viewDidLoad
{
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(cancelAction:)];
    self.cancelButton = cancelButton;
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(doneAction:)];
    self.doneButton = doneButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString* dateFormat = @"MMMM d, yyyy";
    
    if ( self.item ) {
        self.dateTextField.text = [self.item.dateSpent stringWithFormat:dateFormat];
        self.nameTextField.text = self.item.name;
        self.amountTextField.text = [self.item.amount stringValue];
        self.categoryTextField.text = self.item.type.name;
        [self shouldShowBarButtons:NO];
    } else {
        self.dateTextField.text = [[NSDate date] stringWithFormat:dateFormat];
        self.nameTextField.placeholder = @"e.g. Starbucks Coffee";
        self.amountTextField.placeholder = @"e.g. 150";
        self.categoryTextField.placeholder = @"Eating Out";
        [self shouldShowBarButtons:YES];
    }
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
            self.item.dateSpent = [textField.text dateWithFormat:@"MMM d, yyyy"];
            self.item.dayId = [self.item.dateSpent stringWithFormat:@"yyyyMMMd"];
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
    [self willDismiss];
}

#pragma mark - Private Methods

- (void)shouldShowBarButtons:(BOOL)show
{
    if (show) {
        self.navigationItem.leftBarButtonItem = self.cancelButton;
        self.navigationItem.rightBarButtonItem = self.doneButton;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem =nil;
    }
}

- (void)cancelAction:(id)sender
{
    [self didCancel];
    [self dismiss];
}

- (void)doneAction:(id)sender
{
    [self didFinish];
    [self dismiss];
}

- (void)willDismiss
{
    if ( [self.delegate respondsToSelector:@selector(willDismissDetailViewController:)] ) {
        [self.delegate willDismissDetailViewController:self];
    }
}

- (void)didCancel
{
    if ( [self.delegate respondsToSelector:@selector(didCancelDetailViewController:)] ) {
        [self.delegate didCancelDetailViewController:self];
    }
}

- (void)didFinish
{
    if ( [self.delegate respondsToSelector:@selector(didFinishDetailViewController:)] ) {
        [self.delegate didFinishDetailViewController:self];
    }
}

- (void)dismiss
{
    if ( [self.delegate respondsToSelector:@selector(dismissDetailViewController:)] ) {
        [self.delegate dismissDetailViewController:self];
    }
}

@end
