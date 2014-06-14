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

+ (NSArray *)loadDefaultExpenseTypes:(NSManagedObjectContext *)context
{
    NSArray* defaultTypes = @[ @"Transpo",
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
 
    NSMutableArray* types = [[NSMutableArray alloc] initWithCapacity:[defaultTypes count]];
    for (NSString* typeName in defaultTypes) {
        ETExpenseType* type = [NSEntityDescription insertNewObjectForEntityForName:@"ETExpenseType" inManagedObjectContext:context];
        type.name = typeName;
        [types addObject:type];
    }
    
    return [NSArray arrayWithArray:types];
}

+ (NSArray *)expenseTypes:(NSManagedObjectContext *)context
{
    NSSortDescriptor* sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [context executeFetchRequest:@"ETExpenseType" sortDescriptors:@[sortDescriptors]];
}

+ (instancetype)randomType:(NSManagedObjectContext *)context
{
    NSArray* expenseTypes = [self expenseTypes:context];
    return expenseTypes[arc4random() % [expenseTypes count]];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name: %@", self.name];
}

@end
