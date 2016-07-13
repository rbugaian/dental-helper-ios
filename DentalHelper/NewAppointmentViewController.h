//
//  NewAppointmentViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 25/05/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAppointmentViewController : UITableViewController

@property IBOutlet UITextField *startDateField;
@property IBOutlet UITextField *endDateField;

- (IBAction)onDonePressed:(id)sender;

@end
