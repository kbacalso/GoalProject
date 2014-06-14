//
//  ETExpenseType.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseType.h"
#import "ETExpenseItem.h"


@implementation ETExpenseType

@dynamic name;
@dynamic expenseItem;

+ (NSArray *)defaultExpenseTypes
{
    return @[ @"Transpo",
              @"Snacks",
              @"Eating Out",
              @"Services",
              @"Toiletries",
              @"Medicine",
              @"Gifts",
              @"Leisure",
              @"Clothes",
              @"Bills",
              ];
}

+ (instancetype)randomType:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ETExpenseType" inManagedObjectContext:context];
    ETExpenseType *type = [[ETExpenseType alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    type.name = [self defaultExpenseTypes][arc4random() % [[self defaultExpenseTypes] count]];
    return type;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name: %@", self.name];
}

@end
