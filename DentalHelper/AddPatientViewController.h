//
//  AddPatientViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 27/06/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface AddPatientViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateField;
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;

@property BOOL editModeOn;

@property Patient *patient;

@property (weak, nonatomic) IBOutlet UIToolbar *nextButtonToolbar;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (strong, nonatomic) NSString *patientsNotes;

- (IBAction)onBirthDateNextTap:(id)sender;
- (IBAction)onSaveTap:(id)sender;

@end
