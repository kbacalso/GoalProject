//
//  ETExpenseItem.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseItem.h"


@implementation ETExpenseItem

@dynamic dateSpent;
@dynamic name;
@dynamic amount;

+ (NSString *)randomExpenseName
{
    NSArray *randomExpenseNameList = @[ @"Brownies",
                                        @"Globe Bus",
                                        @"Bos Coffee",
                                        @"Nuvali Bus",
                                        @"Chkn Bacolod",
                                        @"McDo",
                                        @"Santis Chocolate",
                                        @"Dinner",
                                        @"Laundry",
                                        @"Cleaning Service",
                                        ];
    
    NSInteger randomIndex = arc4random() % [randomExpenseNameList count];
    return randomExpenseNameList[randomIndex];
}

+ (instancetype)randomExpense:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ETExpenseItem" inManagedObjectContext:context];
    ETExpenseItem *item = [[ETExpenseItem alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    item.dateSpent = [NSDate randomDate];
    item.name = [self randomExpenseName];
    item.amount = [NSNumber numberWithInt:arc4random() % 1000 + 1];
    
    return item;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name: %@\rdateSpent: %@\ramount: %.2f", self.name, self.dateSpent, [self.amount floatValue]];
}


@end
