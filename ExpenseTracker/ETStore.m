//
//  ETExpenseStore.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "ETStore.h"
#import "ETExpenseItem.h"


@interface ETStore ()

@property (nonatomic, strong) NSManagedObjectContext*   context;
@property (nonatomic, strong) NSManagedObjectModel*     model;
@property (nonatomic, strong) NSMutableArray*           expenses;


@end

@implementation ETStore

#pragma mark - Object Life Cycle

+ (instancetype)sharedStore
{
    static ETStore* sharedStore = nil;
    
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedStore = [[ETStore alloc] initPrivate];
    });
    
    return sharedStore;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    if ( self ) {
        [self establishStoreConnection];
        [self loadExpenses];
    }
    
    return self;
}


#pragma mark - Store Methods

- (void)establishStoreConnection
{
    NSString *path = [self itemArchivePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    
    NSError *error = nil;
    if ( [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error] == nil ) {
        [NSException raise:@"Open Failure"
                    format:@"%@", [error localizedDescription]];
    }
    
    _context = [[NSManagedObjectContext alloc] init];
    _context.persistentStoreCoordinator = persistentStoreCoordinator;
    
    NSLog( @"Store Connection Established..." );
}

- (void)loadExpenses
{
    if (self.expenses == nil) {
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"ETExpenseItem" inManagedObjectContext:_context];
        NSSortDescriptor* sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"dateSpent" ascending:NO];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        request.entity = entity;
        request.sortDescriptors = @[sortDescriptors];
        
        NSError* error = nil;
        NSArray* fetchResult = [_context executeFetchRequest:request error:&error];
        if (fetchResult == nil) {
            [NSException raise:@"Fetct failed" format:@"Reason: %@", error.localizedDescription];
        }
        
        self.expenses = [NSMutableArray arrayWithArray:fetchResult];
        
        if ([self.expenses count] == 0) {
            self.expenses = [NSMutableArray arrayWithArray:[self randomExpenses]];
        }
    }
    NSLog( @"%d Expenses Loaded...", [self.expenses count] );
}

#pragma mark - Helper Methods

- (NSString*)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (NSArray *)randomExpenses
{
    int max = 50;
    
    NSMutableArray* expenses = [NSMutableArray arrayWithCapacity:max];
    for (int i = 0; i < max; i++) {
        [expenses addObject:[ETExpenseItem randomExpense:_context]];
    }
    
    return [NSArray arrayWithArray:expenses];
}

@end
