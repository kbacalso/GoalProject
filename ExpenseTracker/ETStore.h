//
//  ETExpenseStore.h
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETExpenseType;

@interface ETStore : NSObject

+ (instancetype)sharedStore;

- (BOOL)saveChanges;

- (NSArray *)allExpenseTypes;
- (ETExpenseType *)createExpenseType:(NSString *)name;
- (BOOL)deleteExpenseType:(ETExpenseType *)expenseType;

- (NSArray *)allExpenses;

@end
