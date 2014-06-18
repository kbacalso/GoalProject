//
//  NSManagedObjectContext+Util.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "NSManagedObjectContext+Util.h"

@implementation NSManagedObjectContext (Util)

- (NSArray *)executeFetchRequest:(NSFetchRequest *)fetchRequest
{
    NSError* error = nil;
    NSArray* fetchResult = [self executeFetchRequest:fetchRequest error:&error];
    if (fetchResult == nil) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", error.localizedDescription];
    }
    return fetchResult;
}

- (NSArray *)executeFetchRequest:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors
{
    return [self executeFetchRequest:entityName sortDescriptors:sortDescriptors predicate:nil];
}

- (NSArray *)executeFetchRequest:(NSString *)entityName
                 sortDescriptors:(NSArray *)sortDescriptors
                       predicate:(NSPredicate *)predicate
{
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    request.sortDescriptors = sortDescriptors;
    request.predicate = predicate;
    return [self executeFetchRequest:request];
}

@end
