//
//  ETExpenseTodayViewController.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/18/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseTodayViewController.h"

@interface ETExpenseTodayViewController ()

@property (nonatomic, weak) IBOutlet UITableView* tableView;

@end

@implementation ETExpenseTodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog( @"DAY: %@", [[ETStore sharedStore] getDayExpenses:[NSDate date]] );
}

@end
