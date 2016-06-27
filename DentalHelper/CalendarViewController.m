//
//  CalendarViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 24/05/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "CalendarViewController.h"
#import "JTCalendar/JTCalendar.h"
#import <Realm/Realm.h>
#import "Appointment.h"
#import "Utils.h"

@implementation CalendarViewController {
    NSMutableArray *appointmentsList;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;

    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
}

- (void)viewDidAppear:(BOOL)animated {
    appointmentsList = [NSMutableArray array];

    for (Appointment *appointment in [Appointment allObjects]) {
        [appointmentsList addObject:appointment];
    }
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView {
    if ([dayView isFromAnotherMonth]) {
        dayView.circleView.hidden = YES;
        dayView.textLabel.textColor = [UIColor grayColor];
    } else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]) {
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = self.view.tintColor;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    } else {
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {
    [_rootViewController onCalenderSwitchClicked:nil];
    [_rootViewController didSelectDay:[Utils getLocalDate:dayView.date]];
}


@end
