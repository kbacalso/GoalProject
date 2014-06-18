//
//  ETExpenseTableViewCell.h
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/16/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETExpenseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *expenseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenseTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenseAmountLabel;

+ (NSString *)reuseIdentifier;

@end
