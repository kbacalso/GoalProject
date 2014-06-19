//
//  ETExpenseDetailViewController.h
//  ExpenseTracker
//
//  Created by Taki Bacalso on 6/19/14.
//  Copyright (c) 2014 KlabCyscorpions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETExpenseItem;
@protocol ETExpenseDetailViewControllerDelegate;

@interface ETExpenseDetailViewController : UIViewController

@property (nonatomic, retain) ETExpenseItem* item;
@property (nonatomic, weak) id<ETExpenseDetailViewControllerDelegate> delegate;

@end

@protocol ETExpenseDetailViewControllerDelegate <NSObject>

- (void)dismissDetailViewController:(ETExpenseDetailViewController *)viewController;

@end