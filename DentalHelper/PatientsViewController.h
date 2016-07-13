//
//  PatientsViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 27/06/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewAppointmentViewController.h"

@interface PatientsViewController : UITableViewController

@property (strong, nonatomic) NewAppointmentViewController *createAppointmentViewController;
@property  BOOL selectionModeOn;

@end
