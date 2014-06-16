//
//  ETExpenseTypeTableViewController.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseTypeTableViewController.h"
#import "ETExpenseType.h"
#import "UIAlertView+Util.h"
#import "UITableView+Util.h"

static NSString* const cellIdentifier = @"ExpenseTypeCell";

typedef enum {
    ETExpenseTypeAlertViewAdd,
    ETExpenseTypeAlertViewEdit,
}ETExpenseTypeAlertViewType;

@interface ETExpenseTypeTableViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray* expenseTypes;

@end

@implementation ETExpenseTypeTableViewController

#pragma mark - IBActions

- (IBAction)addNewItem:(id)sender
{
    UIAlertView* addAlertView = [UIAlertView alertViewInputWithTitle:@"New Category"
                                                            delegate:self
                                                   commitButtonTitle:@"Add"
                                                         defaultText:nil];
    addAlertView.tag = ETExpenseTypeAlertViewAdd;
    [addAlertView show];
}


#pragma mark - View Life Cycle

- (void)viewWillAppear:(BOOL)animated
{
    self.expenseTypes = [[[ETStore sharedStore] allExpenseTypes] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.expenseTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETExpenseType* expenseType = self.expenseTypes[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = expenseType.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteSelectedType:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETExpenseType* expenseType = self.expenseTypes[indexPath.row];
    UIAlertView* editAlertView = [UIAlertView alertViewInputWithTitle:@"Edit Category"
                                                             delegate:self
                                                    commitButtonTitle:@"Edit"
                                                          defaultText:expenseType.name];
    editAlertView.tag = ETExpenseTypeAlertViewEdit;
    [editAlertView show];
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField* textField = [alertView textFieldAtIndex:0];
        [self handleAlertViewText:textField.text type:alertView.tag];
    }
}

#pragma mark - Private Methods

- (void)handleAlertViewText:(NSString *)text type:(ETExpenseTypeAlertViewType)type
{
    if (type == ETExpenseTypeAlertViewAdd) {
        [self addNewType:text];
        [self.tableView addRow:[self.expenseTypes count]];
        return;
    }
    
    [self editSelectedType:text];
    [self.tableView reloadSelectedRow];
}

- (void)addNewType:(NSString *)newTypeName
{
    ETExpenseType* newType = [[ETStore sharedStore] createExpenseType:newTypeName];
    [self.expenseTypes addObject:newType];
}

- (void)editSelectedType:(NSString *)newName
{
    NSIndexPath* selectedIndexPath = [self.tableView indexPathForSelectedRow];
    ETExpenseType* expenseType = self.expenseTypes[selectedIndexPath.row];
    expenseType.name = newName;
}

- (void)deleteSelectedType:(NSIndexPath *)index
{
    ETExpenseType* expenseType = self.expenseTypes[index.row];
    [self.expenseTypes removeObjectIdenticalTo:expenseType];
    [[ETStore sharedStore] deleteExpenseType:expenseType];
}


@end
