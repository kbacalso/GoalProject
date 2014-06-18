//
//  ETExpenseTableViewCell.m
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/16/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import "ETExpenseTableViewCell.h"

@implementation ETExpenseTableViewCell

static NSString* const kExpenseCellIdentifier = @"ExpenseCell";

+ (NSString *)reuseIdentifier
{
    return kExpenseCellIdentifier;
}

@end
