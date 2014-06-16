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
- (NSArray *)allExpenseTypes;
- (ETExpenseType *)createExpenseType:(NSString *)name;
- (void)deleteExpenseType:(ETExpenseType *)expenseType;
- (BOOL)saveChanges;

@end
