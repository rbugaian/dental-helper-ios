//
//  PatientsNotesViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 12/07/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPatientViewController.h"

@interface PatientsNotesViewController : UIViewController

@property (weak, nonatomic) AddPatientViewController *addPatientViewController;

@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (IBAction)onSaveTap:(id)sender;

@end
