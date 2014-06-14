//
//  NSManagedObjectContext+Util.h
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Util)

- (NSArray *)executeFetchRequest:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors;

@end
