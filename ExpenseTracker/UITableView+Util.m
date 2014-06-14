//
//  UITableView+Util.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "UITableView+Util.h"

@implementation UITableView (Util)

- (void)addRow:(NSInteger)newItemTotal
{
    NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:newItemTotal-1 inSection:0];
    [self insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)reloadSelectedRow
{
    NSIndexPath* selectedIndexPath = [self indexPathForSelectedRow];
    [self reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
