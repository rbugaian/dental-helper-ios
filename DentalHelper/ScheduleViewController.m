//
//  ScheduleViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 28/04/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "ScheduleViewController.h"
#import "CalendarViewController.h"
#import <Realm/Realm.h>

#import "Appointment.h"
#import "Utils.h"

@interface ScheduleViewController()

@property NSMutableArray *appointentViews;

@end

@implementation ScheduleViewController {
}

CGFloat rowHeight = 60.0f;
CGFloat navbarMargin = 84.0f;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 24.0f * rowHeight + rowHeight + navbarMargin)];
    
    [self.scrollView setAlwaysBounceVertical:YES];
    
    [self generateScheduleGrid];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectDay:) name:@"day_selected" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    _appointentViews = [NSMutableArray array];
    
    [self reloadScheduleForDate:[Utils getLocalDate]];
    
    [self.scrollView setContentOffset:CGPointMake(0.0f, [self getOffsetByTime:[NSDate date]]) animated:NO];
}

- (void)reloadScheduleForDate:(NSDate *)date {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self generateScheduleGrid];
    RLMResults *allAppointments = [Appointment allObjects];
    
    NSMutableArray *appointmetsArray = [NSMutableArray array];
    for (int i = 0; i < allAppointments.count; i++) {
        Appointment *appointment = [allAppointments objectAtIndex:i];
        if ([[NSCalendar currentCalendar] isDate:appointment.startDate inSameDayAsDate:date]) {
            [appointmetsArray addObject:appointment];
        }
    }
    
    [self addAppointmentsToTimeline:appointmetsArray];
    
}

- (void) addAppointmentsToTimeline:(NSArray *)appointments {
    for (Appointment *appointment in appointments) {
        UIView *appointmentView = [self createAppointmentView:appointment];


        [self.scrollView addSubview:appointmentView];
        [self.appointentViews addObject:appointment];
    }
}

- (UIView *) createAppointmentView:(Appointment *)appointment {
    NSDate *startDate = appointment.startDate;
    NSDate *endDate = appointment.endDate;
    
    double interval = [endDate timeIntervalSinceDate:startDate];
    NSLog(@"Interval %f", interval);
    
    NSDate *dayStart = [[NSCalendar currentCalendar] startOfDayForDate:startDate];
    CGFloat intervalSinceDayStart = [startDate timeIntervalSinceDate:dayStart];
    
    NSLog(@"Start date: %@ Start of the day: %@ Seconds since day start: %f", startDate, dayStart, [startDate timeIntervalSinceDate:dayStart]);
    
    CGFloat y = intervalSinceDayStart / rowHeight;
    CGFloat height = interval / rowHeight;
    CGFloat x = 60.0f;
    CGFloat width = self.scrollView.contentSize.width - x;
    
    CGRect frame = CGRectMake(x, y + navbarMargin, width, height);
    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    [view setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:101.0f/255.0f blue:171.0f/255.0f alpha:0.4f]];
    
    UIColor *lineColor = [UIColor colorWithRed:50.0f/255.0f green:101.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
    UIView *verticalLine = [[UIView alloc]initWithFrame: CGRectMake(0, 0, 1.0f, view.frame.size.height)];
    [verticalLine setBackgroundColor:lineColor];
    [view addSubview:verticalLine];
    
    NSString *headerText = @"Test header text";
    
    UIColor *textColor = [UIColor colorWithRed:2.0f/255.0f green:3.0f/255.0f blue:72.0f/255.0f alpha:1.0f];
    
    //Preparing Header Label for event view
    UIFont *headerFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.0f, 4.0f, view.frame.size.width, 16.0f)];
    [headerLabel setText:headerText];
    [headerLabel setTextColor:textColor];
    [headerLabel setFont:headerFont];

   
    NSString *footerText = @"Text footer text lorem ipsum blra sdjfsdf sdhfbsdf sdfh Text footer text lorem ipsum blra sdjfsdf sdhfbsdf sdfh Text footer text lorem ipsum blra sdjfsdf sdhfbsdf sdfh" ;
    
    //Preparing Footer Label for event view
    UIFont *footerLabelFont = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerLabel.frame.origin.x, headerLabel.frame.origin.y + headerLabel.frame.size.height + 2.0f, view.frame.size.width, headerLabel.frame.size.height)];
    [footerLabel setTextColor:textColor];
    [footerLabel setFont:footerLabelFont];
    [footerLabel setText:footerText];
    [footerLabel setNumberOfLines:1];
    footerLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [footerLabel setTextAlignment: NSTextAlignmentLeft];
    
    
    //Do not add header and footer if their sum heigt and offsets are bigger than root view
    if (!((headerLabel.frame.size.height +
           footerLabel.frame.size.height + 4.0f + 2.0f) >=
          view.frame.size.height)) {
        [view addSubview:headerLabel];
        [view addSubview:footerLabel];
    }
    
    return view;
}

- (CGFloat)getOffsetByTime:(NSDate *)currentTime {
    
    NSDate *dayStart = [[NSCalendar currentCalendar] startOfDayForDate:currentTime];
    CGFloat intervalSinceDayStart = [currentTime timeIntervalSinceDate:dayStart];
    
    CGFloat y = intervalSinceDayStart / rowHeight;
    return y;
}


- (void) generateScheduleGrid {
    
    for (int i = 0; i < 24; i++) {
        
        NSString *timeTxt = [NSString stringWithFormat:@"%d:00", i];
        
        if (i < 10) {
            timeTxt = [NSString stringWithFormat:@"0%@", timeTxt];
        }
        
        CGSize textSize = [timeTxt sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]}];
        
        UILabel *timeTxtLabel = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, (float)i * rowHeight - (textSize.height / 2.0f) + navbarMargin, textSize.width + 16.0f, textSize.height)];
        [timeTxtLabel setText:timeTxt];
        
        [timeTxtLabel setTextColor:[UIColor lightGrayColor]];
        
        [timeTxtLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self.scrollView addSubview:timeTxtLabel];
        
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(timeTxtLabel.frame.origin.x + timeTxtLabel.frame.size.width + 4.0f , (float)i * rowHeight + navbarMargin, self.view.frame.size.width, 1.0f)];
        
        [separatorView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        [self.scrollView addSubview:separatorView];
    }
}

- (void)didSelectDay:(NSNotification *)notification {
}

-(void)showScheduleForDay:(NSDate *)date {
    NSLog(@"Did select date: %@", date);
    
    [self reloadScheduleForDate:date];
}


@end
