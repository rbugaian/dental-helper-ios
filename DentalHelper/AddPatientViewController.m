//
//  AddPatientViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 27/06/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "AddPatientViewController.h"
#import "Patient.h"
#import <Realm/Realm.h>

@interface AddPatientViewController ()

@property NSMutableArray *allergies;
@property NSMutableArray *lastVisits;

@end

@implementation AddPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTextFields];
    
}

- (void)initTextFields {
    self.firstNameField.delegate = self;
    self.lastNameField.delegate = self;
    self.birthDateField.delegate = self;
    self.mobilePhoneField.delegate = self;
    self.telephoneField.delegate = self;
    self.emailField.delegate = self;
    
    self.birthDateField.inputView = [self createDatePickerInstance];
    
    self.birthDateField.inputAccessoryView = self.nextButtonToolbar;
    self.mobilePhoneField.inputAccessoryView = self.nextButtonToolbar;
    self.telephoneField.inputAccessoryView = self.nextButtonToolbar;
}

- (void)onBirthDateNextTap:(id)sender {
    if ([self.birthDateField isFirstResponder]) {
        [self.mobilePhoneField becomeFirstResponder];
    } else if ([self.mobilePhoneField isFirstResponder]) {
        [self.telephoneField becomeFirstResponder];
    } else if ([self.telephoneField isFirstResponder]) {
        [self.emailField becomeFirstResponder];
    }}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.firstNameField) {
        [self.lastNameField becomeFirstResponder];
    }
    
    if (textField == self.lastNameField) {
        [self.birthDateField becomeFirstResponder];
    }
    
    if (textField == self.birthDateField) {
        [self.mobilePhoneField becomeFirstResponder];
    }
    
    if (textField == self.mobilePhoneField) {
        [self.telephoneField becomeFirstResponder];
    }
    
    if (textField == self.telephoneField) {
        [self.emailField becomeFirstResponder];
    }
    
    if (textField == self.emailField) {
        [self.emailField resignFirstResponder];
    }

    return YES;
}

- (UIDatePicker *)createDatePickerInstance {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.backgroundColor = [UIColor whiteColor];
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    [datePicker addTarget:self action:@selector(birthDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    return datePicker;
}

- (void)birthDatePickerValueChanged:(UIDatePicker *)datePicker {
    
}

- (void)onSaveTap:(id)sender {
    Patient *newPatient = [[Patient alloc] init];
    [newPatient setFirstName:self.firstNameField.text];
    [newPatient setLastName:self.lastNameField.text];
    
    UIDatePicker *birthDatePicker = (UIDatePicker *)self.birthDateField.inputView;
    [newPatient setBirthDate:birthDatePicker.date];
    
    [newPatient setMobileNumber:self.mobilePhoneField.text];
    [newPatient setTelephoneNumber:self.telephoneField.text];
    [newPatient setEmailAddress:self.emailField.text];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:newPatient];
    }];
    
    [self.tableView becomeFirstResponder];
}


@end
