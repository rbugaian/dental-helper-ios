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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadAppointments];
}

- (void) loadAppointments {
    appointmentsList = [NSMutableArray array];
    
    for (Appointment *appointment in [Appointment allObjects]) {
        [appointmentsList addObject:appointment];
        NSLog(@"XYZ Appointment start: %@ end: %@", appointment.startDate, appointment.endDate);
    }
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView {
    if (appointmentsList == nil) {
        [self loadAppointments];
    }
    
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
    
    for (Appointment *appointment in appointmentsList) {
        if ([_calendarManager.dateHelper date:dayView.date isTheSameDayThan:appointment.startDate]) {
            dayView.dotView.hidden = NO;
            break;
        } else {
            dayView.dotView.hidden = YES;
        }
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {
    [_rootViewController onCalenderSwitchClicked:nil];
    [_rootViewController didSelectDay:[Utils getLocalDate:dayView.date]];
}


@end
