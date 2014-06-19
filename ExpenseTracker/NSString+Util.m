//
//  NSString+Util.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/19/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (NSDate *)dateWithFormat:(NSString *)format
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    return [dateFormatter dateFromString:self];
}

@end
