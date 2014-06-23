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

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;

@end

@protocol ETExpenseDetailViewControllerDelegate <NSObject>

@optional
- (void)willDismissDetailViewController:(ETExpenseDetailViewController *)viewController;
- (void)didCancelDetailViewController:(ETExpenseDetailViewController *)viewController;
- (void)didFinishDetailViewController:(ETExpenseDetailViewController *)viewController;
- (void)dismissDetailViewController:(ETExpenseDetailViewController *)viewController;

@end