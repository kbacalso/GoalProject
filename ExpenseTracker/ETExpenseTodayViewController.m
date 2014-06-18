//
//  ETExpenseTodayViewController.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/18/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseTodayViewController.h"
#import "ETExpenseTableViewCell.h"
#import "ETExpenseItem.h"
#import "ETExpenseType.h"

@interface ETExpenseTodayViewController () <UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UILabel*   totalExpenseLabel;
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* currentExpenses;

@end

@implementation ETExpenseTodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadData];
}

#pragma mark - Table View Data Source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[NSDate date] stringWithFormat:@"MMM dd, YYYY"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger totalItemExpenses = [self.currentExpenses count];
    return (totalItemExpenses > 0)? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentExpenses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETExpenseItem* expenseItem = self.currentExpenses[indexPath.row];
    ETExpenseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ETExpenseTableViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.expenseNameLabel.text = expenseItem.name;
    cell.expenseTypeLabel.text = expenseItem.type.name;
    cell.expenseAmountLabel.text = [expenseItem.amount stringValue];
    return cell;
}


#pragma mark - Private Methods

- (void)reloadData
{
    self.currentExpenses = [[[ETStore sharedStore] getDayExpenses:[NSDate date]] mutableCopy];
    self.totalExpenseLabel.text = [[self.currentExpenses valueForKeyPath:@"@sum.amount"] stringValue];
    NSLog( @"current: %@", self.currentExpenses );
    NSLog( @"sum: %@", self.totalExpenseLabel.text );
}


@end
