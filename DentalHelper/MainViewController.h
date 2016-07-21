//
//  FirstViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 20/04/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *calenderContainerView;
@property (weak, nonatomic) IBOutlet UIView *scheduleContainerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *calenderSwitchNavButton;

- (IBAction)onCalenderSwitchClicked:(id)sender;

- (void)didSelectDay:(NSDate *)selectedDay;

@end

