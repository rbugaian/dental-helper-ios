//
//  ScheduleViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 28/04/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface ScheduleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) MainViewController *rootViewController;

-(void)showScheduleForDay:(NSDate *)date;

@end
