//
//  ETExpenseDetailViewController.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/19/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseDetailViewController.h"

@interface ETExpenseDetailViewController ()

@end

@implementation ETExpenseDetailViewController

- (IBAction)cancelAction:(id)sender
{
    NSLog( @"assa" );
    [self.delegate dismissDetailViewController:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog( @"%@", self.delegate );
}
@end
