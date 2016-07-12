//
//  PatientsNotesViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 12/07/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "PatientsNotesViewController.h"

@interface PatientsNotesViewController ()

@end

@implementation PatientsNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.addPatientViewController.patient != nil) {
        self.notesTextView.text = self.addPatientViewController.patient.notes;
    }
}

- (void)onSaveTap:(id)sender {
    self.addPatientViewController.patientsNotes = self.notesTextView.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
