//
//  XYZAppointmentDetailsViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 28/07/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBAppointmentDetailsViewController.h"
#import "Utils.h"

@interface RBAppointmentDetailsViewController ()

@end

@implementation RBAppointmentDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    // Do any additional setup after loading the view.
}

- (void)initViews {
    _date.text = [Utils dateStringFromDateWithTime:_appointment.startDate];
    _patientName.text = [NSString stringWithFormat:@"%@ %@", _appointment.patient.firstName, _appointment.patient.lastName];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        NSLog(@"Selected");
        [self performSegueWithIdentifier:@"ShowProcedureChart" sender:self];
    }
}

@end
