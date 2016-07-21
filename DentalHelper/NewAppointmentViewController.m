//
//  NewAppointmentViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 25/05/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "NewAppointmentViewController.h"
#import "Appointment.h"
#import "PatientsViewController.h"

@implementation NewAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initStartDatePicker];
    [self initEndDatePicker];
    [self initTextFieldsNextButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_selectedPatient != nil) {
        _patientFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", _selectedPatient.firstName, _selectedPatient.lastName];
    }
}

- (void)initTextFieldsNextButtons {
    self.startDateField.inputAccessoryView = self.nextButtonToolbar;
    self.endDateField.inputAccessoryView = self.nextButtonToolbar;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SelectPatientSegue"]) {
        PatientsViewController *viewController = segue.destinationViewController;
        viewController.selectionModeOn = YES;
        viewController.createAppointmentViewController = self;
    }
}

- (IBAction)nextButtonClicked:(id)sender {
    if (self.startDateField.isFirstResponder) {
        self.nextButton.title = @"Done";
        [self.endDateField becomeFirstResponder];
    } else if (self.endDateField.isFirstResponder) {
        self.nextButton.title = @"Next";
        [self.endDateField resignFirstResponder];
    }
}
@end
