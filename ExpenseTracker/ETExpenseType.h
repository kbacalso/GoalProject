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
@property (nonatomic, retain) ETExpenseItem *expenseItem;

+ (NSArray *)defaultExpenseTypes;
+ (instancetype)randomType:(NSManagedObjectContext *)context;

@end
