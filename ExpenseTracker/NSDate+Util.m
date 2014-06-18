//
//  NSDate+Random.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "NSDate+Util.h"

enum ETMonths {
    ETJanuary = 1,
    ETFebruary,
    ETMarch,
    ETApril,
    ETMay,
    ETJune,
    ETJuly,
    ETAugust,
    ETSeptember,
    ETOctober,
    ETNovember,
    ETDecember,
};

@implementation NSDate (Util)

+ (BOOL)isLeapYear:(NSInteger)year
{
    if ( (year % 4) > 0 )
        return NO;
    
    if ( (year % 100) > 0 )
        return YES;
    
    if ( (year % 400) == 0 )
        return YES;
    
    return NO;
}

+ (NSInteger)randomMonth
{
    return (NSInteger)(arc4random() % 12) + 1;
}

+ (NSInteger)randomDay:(NSInteger)month year:(NSInteger)year
{
    NSInteger upperBound;
    switch ( month ) {
        case ETFebruary:
            upperBound = ([self isLeapYear:year])? 29 : 28;
            break;
            
        case ETApril:
        case ETJune:
        case ETSeptember:
        case ETNovember:
            upperBound = 30;
            break;
        
        default:
            upperBound = 31;
    }
    
    return (NSInteger)(arc4random() % upperBound) + 1;
}

+ (NSDate *)randomDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-M-d hh:mm:ss"];
 
    NSInteger year = 2014;
    NSInteger month = 6;
    NSInteger day = [self randomDay:month year:year];
    
    NSDate* randomDate = [formatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 08:30:00", year, month, day]];
    return randomDate;
}

- (NSString*)stringWithFormat:(NSString *)dateFormat
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:self];
}

@end
