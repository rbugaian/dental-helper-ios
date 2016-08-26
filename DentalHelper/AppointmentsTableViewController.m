//
//  ProceduresTableViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 21/07/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "AppointmentsTableViewController.h"
#import "ProcedureTableViewCell.h"
#import <Realm/Realm.h>
#import "Appointment.h"
#import "Utils.h"
#import "RBAppointmentDetailsViewController.h"


@interface AppointmentsTableViewController ()

@property (nonatomic) RLMResults *procedures;
@property (nonatomic) Appointment *selectedAppointment;

@end


@implementation AppointmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"ProcedureTableViewCell" bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:@"ProcedureTableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _procedures = [Appointment allObjects];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _procedures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProcedureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcedureTableViewCell"];
    Appointment *appointment = [_procedures objectAtIndex:indexPath.row];
    cell.dateLabel.text = [Utils dateStringFromDateWithTime:appointment.startDate];
    cell.patientNameLabel.text = [NSString stringWithFormat:@"%@ %@", appointment.patient.firstName, appointment.patient.lastName];
    cell.procedureTitle.text = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedAppointment = [_procedures objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"AppointmentShowDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AppointmentShowDetails"]) {
        RBAppointmentDetailsViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.hidesBottomBarWhenPushed = YES;

        destinationViewController.appointment = _selectedAppointment;
    }
}

@end
