//
//  ETExpenseType.h
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ETExpenseItem;

@interface ETExpenseType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *expenseItem;

+ (NSArray *)loadDefaultExpenseTypes:(NSManagedObjectContext *)context;
+ (NSArray *)expenseTypes:(NSManagedObjectContext *)context;
+ (instancetype)randomType:(NSManagedObjectContext *)context;

@end

@interface ETExpenseType (CoreDataGeneratedAccessors)

- (void)addExpenseItemObject:(ETExpenseItem *)value;
- (void)removeExpenseItemObject:(ETExpenseItem *)value;
- (void)addExpenseItem:(NSSet *)values;
- (void)removeExpenseItem:(NSSet *)values;

@end
