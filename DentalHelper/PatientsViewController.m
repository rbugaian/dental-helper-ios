//
//  PatientsViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 27/06/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "PatientsViewController.h"
#import "Patient.h"
#import "AddPatientViewController.h"

@interface PatientsViewController ()

@property RLMResults *patients;
@property Patient *selectedPatient;

@end

@implementation PatientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _patients = [Patient allObjects];
    
     self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _patients.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Patient *patient = [_patients objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    cell.detailTextLabel.text = patient.mobileNumber;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedPatient = [_patients objectAtIndex:indexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *warningController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Are you sure to delete current patient from memory?" preferredStyle:UIAlertControllerStyleAlert];
        [warningController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.tableView setEditing:NO animated:YES];
        }]];
        
        [warningController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            Patient *deletingPatient = [_patients objectAtIndex:indexPath.row];
            [[RLMRealm defaultRealm] beginWriteTransaction];
            [[RLMRealm defaultRealm] deleteObject:deletingPatient];
            [[RLMRealm defaultRealm] commitWriteTransaction];

           [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }]];
        
        [self.navigationController presentViewController:warningController animated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddPatientSegue"]) {
        AddPatientViewController *viewController = segue.destinationViewController;
        viewController.editModeOn = YES;
        viewController.patient = nil;
    } else if ([segue.identifier isEqualToString:@"ShowDetailsSegue"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
        _selectedPatient = [_patients objectAtIndex:selectedIndexPath.row];
        AddPatientViewController *viewController  = segue.destinationViewController;
        viewController.editModeOn = NO;
        viewController.patient = _selectedPatient;
        viewController.navigationItem.title = @"Patient";
    }
}

@end
