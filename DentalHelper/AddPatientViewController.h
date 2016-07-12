//
//  AddPatientViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 27/06/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPatientViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateField;
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UIToolbar *nextButtonToolbar;

- (IBAction)onBirthDateNextTap:(id)sender;
- (IBAction)onSaveTap:(id)sender;

@end
