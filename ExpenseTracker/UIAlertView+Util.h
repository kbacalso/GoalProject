//
//  UIAlertView+Util.h
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Util)

+ (instancetype)alertViewInputWithTitle:(NSString *)title
                               delegate:(id)delegate
                      commitButtonTitle:(NSString *)buttonTitle
                            defaultText:(NSString *)text;

@end
