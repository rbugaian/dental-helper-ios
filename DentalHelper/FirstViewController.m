//
//  FirstViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 20/04/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "FirstViewController.h"
#import "ScheduleViewController.h"
#import "CalendarViewController.h"

@interface FirstViewController ()

@property CalendarViewController *calenderViewController;
@property ScheduleViewController *scheduleViewController;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.calenderContainerView setAlpha:0.0f];
    [self.scheduleContainerView setAlpha:1.0f];
    
    [self initChildViewControllers];
}

- (void) initChildViewControllers {
    CalendarViewController *calendarViewController = self.childViewControllers[0];
    calendarViewController.rootViewController = self;
    _calenderViewController = calendarViewController;
    
    ScheduleViewController *scheduleViewController = self.childViewControllers[1];
    scheduleViewController.rootViewController = self;
    _scheduleViewController = scheduleViewController;
}

- (IBAction)onCalenderSwitchClicked:(id)sender {
    //Interchanging between calender and schedule views
    if (self.calenderContainerView.alpha == 0.0f) {
        [self.calenderContainerView setAlpha:1.0f];
        [self.scheduleContainerView setAlpha:0.0f];
        [self.calenderSwitchNavButton setImage:[UIImage imageNamed:@"schedule_icon"]];
        
    } else {
        [self.calenderContainerView setAlpha:0.0f];
        [self.scheduleContainerView setAlpha:1.0f];
        [self.calenderSwitchNavButton setImage:[UIImage imageNamed:@"calendar_icon"]];
    }
}

- (void)didSelectDay:(NSDate *)selectedDay {
    [_scheduleViewController showScheduleForDay:selectedDay];
}

@end
