//
//  ETExpenseTypeTableViewController.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseTypeTableViewController.h"
#import "ETExpenseType.h"

static NSString* const cellIdentifier = @"ExpenseTypeCell";

@interface ETExpenseTypeTableViewController ()

@property (nonatomic, strong) NSMutableArray* expenseTypes;

@end

@implementation ETExpenseTypeTableViewController

#pragma mark - IBActions

- (IBAction)addNewItem:(id)sender
{
    NSLog( @"ADD!" );
}


#pragma mark - View Life Cycle

- (void)viewWillAppear:(BOOL)animated
{
    self.expenseTypes = [[ETStore allExpenseTypes] mutableCopy];
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

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}

@end
