//
//  NewAppointmentViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 25/05/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface NewAppointmentViewController : UITableViewController

@property IBOutlet UILabel *patientFullNameLabel;
@property IBOutlet UITextField *startDateField;
@property IBOutlet UITextField *endDateField;

@property (strong, nonatomic) Patient *selectedPatient;

- (IBAction)onDonePressed:(id)sender;

@end
