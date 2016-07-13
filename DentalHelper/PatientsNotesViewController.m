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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];

    // Do any additional setup after loading the view.
}

- (void)keyboardWasShown:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.notesTextView.frame = CGRectMake(0, self.notesTextView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - keyboardSize.height - self.navigationController.navigationBar.frame.size.height - 20.0f);
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    self.notesTextView.frame = CGRectMake(0, self.notesTextView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.addPatientViewController.patient != nil) {
        self.notesTextView.text = self.addPatientViewController.patient.notes;
    }
}

- (void)onSaveTap:(id)sender {
    [self.notesTextView resignFirstResponder];
    
    self.addPatientViewController.patientsNotes = self.notesTextView.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
