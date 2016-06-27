//
//  CalendarViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 24/05/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar/JTCalendar.h"
#import "FirstViewController.h"

@interface CalendarViewController : UIViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong, nonatomic) FirstViewController *rootViewController;



@end
