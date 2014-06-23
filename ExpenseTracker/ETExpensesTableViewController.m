//
//  ETExpensesTableViewController.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/16/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpensesTableViewController.h"
#import "ETExpenseDetailViewController.h"
#import "ETExpenseItem.h"
#import "ETExpenseType.h"
#import "ETExpenseTableViewCell.h"
#import "NSDate+Util.h"

typedef enum{
    ETExpenseSortTypeDay,
    ETExpenseSortTypeWeek,
    ETExpenseSortTypeMonth,
}ETExpenseSortType;

@interface ETExpensesTableViewController () <ETExpenseDetailViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray* expenses;
@property (nonatomic, retain) NSDictionary* filteredDictionary;
@property (nonatomic, assign) ETExpenseSortType selectedSortType;

@end

@implementation ETExpensesTableViewController

#pragma mark - IBActions
- (IBAction)sortingTypeChanged:(UISegmentedControl *)sender
{
    self.selectedSortType = sender.selectedSegmentIndex;
    self.filteredDictionary = [self filteredExpenses:self.selectedSortType];
    [self.tableView reloadData];
}


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedSortType = ETExpenseSortTypeDay;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.filteredDictionary allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSMutableArray *)[self.filteredDictionary objectForKey:[NSNumber numberWithInteger:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray* sectionArray = (NSArray *)[self.filteredDictionary objectForKey:[NSNumber numberWithInteger:section]];
    ETExpenseItem* expenseItem = sectionArray.firstObject;
    
    if ( self.selectedSortType == ETExpenseSortTypeWeek ) {
        return [NSString stringWithFormat:@"%@ %@ Week %@",
                [expenseItem.dateSpent stringWithFormat:@"yyyy"],
                [expenseItem.dateSpent stringWithFormat:@"MMM"],
                [expenseItem.dateSpent stringWithFormat:@"W"]];
    }
    
    if ( self.selectedSortType == ETExpenseSortTypeMonth ) {
        return [expenseItem.dateSpent stringWithFormat:@"yyyy MMM"];
    }
    
    return [expenseItem.dateSpent stringWithFormat:@"MMM dd, yyyy"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* sectionArray = (NSArray *)[self.filteredDictionary objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    ETExpenseItem* expenseItem = sectionArray[indexPath.row];
    
    ETExpenseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ETExpenseTableViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.expenseNameLabel.text = expenseItem.name;
    cell.expenseTypeLabel.text = expenseItem.type.name;
    cell.expenseAmountLabel.text = [expenseItem.amount stringValue];
    
    return cell;
}


#pragma mark - Private methods

- (void)reloadData
{
    self.expenses = [[[ETStore sharedStore] allExpenses] mutableCopy];
    self.filteredDictionary = [self filteredExpenses:self.selectedSortType];
    [self.tableView reloadData];
}

- (NSDictionary *)filterWithDateFormat:(NSString *)dateFormat
{
    NSMutableDictionary* filteredDictionary = [NSMutableDictionary dictionary];
    
    for( int section = 0, itemIndex = 0; itemIndex < [self.expenses count]; itemIndex++ ) {
        ETExpenseItem* item = self.expenses[itemIndex];
        NSNumber* currentSection = [NSNumber numberWithInt:section];
        
        NSMutableArray* itemArray = [filteredDictionary objectForKey:currentSection];
        
        // Checks if index path has no array yet
        if ( itemArray == nil ) {
            NSMutableArray* newArraySection = [NSMutableArray array];
            [newArraySection addObject:item];
            [filteredDictionary setObject:newArraySection forKey:currentSection];
            continue;
        }
        
        // If index path has array already, check if item belongs to array
        NSString* currentSectionTitle = [[(ETExpenseItem *)itemArray[0] dateSpent] stringWithFormat:dateFormat];
        NSString* itemDateString = [item.dateSpent stringWithFormat:dateFormat];
        
        if ( [itemDateString isEqualToString:currentSectionTitle] == NO ) {
            currentSection = [NSNumber numberWithInt:++section];
            NSMutableArray* newArraySection = [NSMutableArray array];
            [newArraySection addObject:item];
            [filteredDictionary setObject:newArraySection forKey:currentSection];
            continue;
        }
        
        [itemArray addObject:item];
    }
    
    return [NSDictionary dictionaryWithDictionary:filteredDictionary];
}

- (NSDictionary *)filteredExpenses:(ETExpenseSortType)sortType
{
    
    if ( sortType == ETExpenseSortTypeWeek ) {
        return [self filterWithDateFormat:@"yyyy MMM W"];
    }
    
    if ( sortType == ETExpenseSortTypeMonth ) {
        return [self filterWithDateFormat:@"MMM"];
    }
    return [self filterWithDateFormat:@"yyyy-MM-dd"];
}


#pragma mark - Detail View Controller Delagate

- (void)willDismissDetailViewController:(ETExpenseDetailViewController *)viewController
{
    ETExpenseItem* item = viewController.item;
    ETExpenseType* type = [[ETStore sharedStore] createExpenseType:viewController.categoryTextField.text];
    item.type = type;
    [[ETStore sharedStore] saveChanges];
}


#pragma mark - Segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath* selectedIndexPath = self.tableView.indexPathForSelectedRow;
    NSArray* sectionArray = (NSArray *)[self.filteredDictionary objectForKey:[NSNumber numberWithInteger:selectedIndexPath.section]];
    ETExpenseItem* expenseItem = sectionArray[selectedIndexPath.row];
    
    ETExpenseDetailViewController* detailViewController = [segue destinationViewController];
    detailViewController.item = expenseItem;
    detailViewController.delegate = self;
}


@end
