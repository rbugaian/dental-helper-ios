//
//  NewAppointmentViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 25/05/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "NewAppointmentViewController.h"
#import "Appointment.h"

@implementation NewAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initStartDatePicker];
    [self initEndDatePicker];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (UIDatePicker *)createDatePickerInstance {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.backgroundColor = [UIColor whiteColor];
    
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    
    return datePicker;
}

- (void)initStartDatePicker {
    UIDatePicker *datePicker = [self createDatePickerInstance];
    [datePicker setDate:[NSDate date]];
    
    [self onStartDatePickerChanged:datePicker];
    
    [datePicker addTarget:self action:@selector(onStartDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.startDateField setInputView:datePicker];
}

- (void)initEndDatePicker {
    UIDatePicker *datePicker = [self createDatePickerInstance];
    
    NSDate *offsetDate = [NSDate dateWithTimeInterval:3600 sinceDate:[NSDate date]];
    [datePicker setDate:offsetDate];
    
    [self onEndDatePickerChanged:datePicker];
    
    [datePicker addTarget:self action:@selector(onEndDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.endDateField setInputView:datePicker];
}

- (void) onStartDatePickerChanged:(UIDatePicker *)datePicker {
    NSString *dateString  = [NSDateFormatter localizedStringFromDate:[datePicker date]
                                                                       dateStyle:NSDateFormatterMediumStyle
                                                                       timeStyle:NSDateFormatterShortStyle];
    [self.startDateField setText:dateString];
    
    UIDatePicker *endDatePicker = (UIDatePicker *)[self.endDateField inputView];
    [endDatePicker setMinimumDate:[datePicker date]];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = 1;
    dateComponents.second = -1;
    
    NSDate *startOfTheDay = [[NSCalendar currentCalendar] startOfDayForDate:datePicker.date];
    
    NSDate *endOfTheDay = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:startOfTheDay options:NSCalendarMatchStrictly];
    
    [endDatePicker setMaximumDate:endOfTheDay];
}

- (void) onEndDatePickerChanged:(UIDatePicker *)datePicker {
    NSString *dateString  = [NSDateFormatter localizedStringFromDate:[datePicker date]
                                                           dateStyle:NSDateFormatterMediumStyle
                                                           timeStyle:NSDateFormatterShortStyle];
    [self.endDateField setText:dateString];
    
    
}

- (IBAction)onDonePressed:(id)sender {
    UIDatePicker *startDatePicker = (UIDatePicker *)[self.startDateField inputView];
    UIDatePicker *endDatePicker = (UIDatePicker *)[self.endDateField inputView];
    
    Appointment *newAppointment = [[Appointment alloc] init];
    [newAppointment setStartDate:startDatePicker.date];
    [newAppointment setEndDate:endDatePicker.date];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:newAppointment];
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dismissKeyboard {
    [self.startDateField resignFirstResponder];
    [self.endDateField resignFirstResponder];
}

@end
