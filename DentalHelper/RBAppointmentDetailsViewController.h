//
//  XYZAppointmentDetailsViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 28/07/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointment.h"

@interface RBAppointmentDetailsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *patientName;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (strong, nonatomic) Appointment *appointment;

@end
