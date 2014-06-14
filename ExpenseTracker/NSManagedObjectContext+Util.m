//
//  NSManagedObjectContext+Util.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "NSManagedObjectContext+Util.h"

@implementation NSManagedObjectContext (Util)

- (NSArray *)executeFetchRequest:(NSString *)entityName sortDescriptors:(NSArray *)sortDescriptors
{
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    request.sortDescriptors = sortDescriptors;
    
    NSError* error = nil;
    NSArray* fetchResult = [self executeFetchRequest:request error:&error];
    if (fetchResult == nil) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", error.localizedDescription];
    }
    return fetchResult;
}

@end
