//
//  NSDate+Random.h
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/14/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Util)

+ (BOOL)isLeapYear:(NSInteger)year;
+ (NSInteger)randomMonth;
+ (NSInteger)randomDay:(NSInteger)month year:(NSInteger)year;
+ (NSDate *)randomDate;
- (NSString*)stringWithFormat:(NSString *)dateFormat;

@end
