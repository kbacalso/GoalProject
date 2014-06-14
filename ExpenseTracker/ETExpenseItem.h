//
//  ETExpenseItem.h
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ETExpenseItem : NSManagedObject

@property (nonatomic, retain) NSDate * dateSpent;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * amount;

+ (instancetype)randomExpense:(NSManagedObjectContext *)context;

@end
