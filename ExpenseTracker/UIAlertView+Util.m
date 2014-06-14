//
//  UIAlertView+Util.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "UIAlertView+Util.h"

@implementation UIAlertView (Util)

+ (instancetype)alertViewInputWithTitle:(NSString *)title
                               delegate:(id)delegate
                      commitButtonTitle:(NSString *)buttonTitle
                            defaultText:(NSString *)defaultText
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:nil
                                                           delegate:delegate
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:buttonTitle,nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alertView textFieldAtIndex:0] setText:defaultText];
    return alertView;
}

@end
