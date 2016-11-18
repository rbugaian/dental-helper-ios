//
//  PatientsNotesViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 12/07/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "PatientsNotesViewController.h"

@interface PatientsNotesViewController ()

@property BOOL editModeOn;

@end

@implementation PatientsNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _editModeOn = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
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
    
    [self.saveButton setTintColor:[UIColor redColor]];
    self.saveButton.title = @"Edit";
    self.saveButton.style = UIBarButtonItemStylePlain;
    self.notesTextView.editable = NO;

    if (self.addPatientViewController.patient != nil) {
        self.notesTextView.text = self.addPatientViewController.patient.notes;
    }
}

- (void)onSaveTap:(id)sender {
    if (_editModeOn) {
        [self.notesTextView resignFirstResponder];
        
        Patient *patient = self.addPatientViewController.patient;
        [[RLMRealm defaultRealm] beginWriteTransaction];
        
        patient.notes = self.notesTextView.text;
        
        [[RLMRealm defaultRealm] addOrUpdateObject:patient];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        _editModeOn = YES;
        self.saveButton.title = @"Save";
        self.saveButton.tintColor = self.view.tintColor;
        self.saveButton.style = UIBarButtonItemStyleDone;
        self.notesTextView.editable = YES;
        [self.notesTextView becomeFirstResponder];

    }
}


@end
