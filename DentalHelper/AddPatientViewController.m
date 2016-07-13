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
#import "Utils.h"
#import "PatientsNotesViewController.h"

@interface AddPatientViewController ()

@property NSMutableArray *allergies;
@property NSMutableArray *lastVisits;

@property NSDate *selectedDate;

@end

@implementation AddPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTextFields];
}

- (void)initTextFields {
    if (self.editModeOn) {
        self.rightBarButton.title = @"Save";
        self.rightBarButton.tintColor = self.view.tintColor;
        
        self.firstNameField.enabled = YES;
        self.lastNameField.enabled = YES;
        self.birthDateField.enabled = YES;
        self.mobilePhoneField.enabled = YES;
        self.telephoneField.enabled = YES;
        self.emailField.enabled = YES;
        
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
        
        self.notesTextView.text = nil;
        self.tableView.tableFooterView = nil;
        
    } else if (self.patient != nil) {
        self.rightBarButton.title = @"Edit";
        self.rightBarButton.tintColor = [UIColor redColor];
        
        self.firstNameField.text = self.patient.firstName;
        self.lastNameField.text = self.patient.lastName;
        self.birthDateField.text = [Utils dateStringFromDate:self.patient.birthDate];
        self.mobilePhoneField.text = self.patient.mobileNumber;
        self.telephoneField.text = self.patient.telephoneNumber;
        self.emailField.text = self.patient.emailAddress;
        
        self.firstNameField.enabled = NO;
        self.lastNameField.enabled = NO;
        self.birthDateField.enabled = NO;
        self.mobilePhoneField.enabled = NO;
        self.telephoneField.enabled = NO;
        self.emailField.enabled = NO;
        
        self.notesTextView.text = self.patient.notes;
        [self.notesTextView sizeToFit]; //added
        [self.notesTextView layoutIfNeeded]; //added
        
        [self.tableView sizeToFit];
        [self.tableView layoutIfNeeded];
        
        self.tableView.tableFooterView = self.notesTextView;

        
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.editModeOn) {
        return 3;
    } else {
        return 2;
    }
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
    [self.birthDateField setText:[Utils dateStringFromDate:datePicker.date]];
    self.selectedDate = datePicker.date;
}

- (BOOL)saveNewPatient {
    Patient *newPatient = [[Patient alloc] init];
    [newPatient setFirstName:self.firstNameField.text];
    [newPatient setLastName:self.lastNameField.text];
    
    [newPatient setBirthDate:_selectedDate];
    
    [newPatient setMobileNumber:self.mobilePhoneField.text];
    [newPatient setTelephoneNumber:self.telephoneField.text];
    [newPatient setEmailAddress:self.emailField.text];
    [newPatient setNotes:self.patientsNotes];
    
    if (newPatient.lastName.length != 0 &&
        newPatient.firstName.length != 0 &&
        newPatient.birthDate &&
        newPatient.mobileNumber.length != 0 &&
        newPatient.emailAddress.length != 0) {
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm addObject:newPatient];
        }];
        
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)saveExistingPatient {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    
    if (self.firstNameField.text.length != 0) {
        self.patient.firstName = self.firstNameField.text;
    }
    
    if (self.lastNameField.text.length != 0) {
        self.patient.lastName = self.lastNameField.text;
    }
    
    if (self.selectedDate != nil) {
        self.patient.birthDate = _selectedDate;
    }
    
    if (self.mobilePhoneField.text.length != 0) {
        self.patient.mobileNumber = self.mobilePhoneField.text;
    }
    
    if (self.telephoneField.text.length != 0) {
        self.patient.telephoneNumber = self.telephoneField.text;
    }
    
    if (self.emailField.text.length != 0) {
        self.patient.emailAddress = self.emailField.text;
    }
    
    if (self.patientsNotes.length != 0) {
        self.patient.notes = self.patientsNotes;
    }
    
    [[RLMRealm defaultRealm] addOrUpdateObject:self.patient];
    [[RLMRealm defaultRealm] commitWriteTransaction];
    
    return YES;
}

- (void)onSaveTap:(id)sender {
    if (self.editModeOn && self.patient != nil) {
        BOOL didUpdatePatient = [self saveExistingPatient];
        if (didUpdatePatient) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.editModeOn && self.patient == nil) {
        BOOL didSavePatient = [self saveNewPatient];
        if (didSavePatient) {
            [self.tableView becomeFirstResponder];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showFieldMissingAlert];
        }
    } else if(!self.editModeOn && self.patient != nil) {
        self.editModeOn = YES;
        [self initTextFields];
    }
}

- (void)showFieldMissingAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"One or more fields missing. Please fill them." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addNoteSegue"]) {
        PatientsNotesViewController *notesViewController = segue.destinationViewController;
        notesViewController.addPatientViewController = self;
    }
}


@end
