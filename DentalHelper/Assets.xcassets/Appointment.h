//
//  Appointment.h
//  DentalHelper
//
//  Created by Roman Bugaian on 25/05/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Patient.h"

@interface Appointment : RLMObject

@property NSDate *startDate;
@property NSDate *endDate;
@property Patient *patient;

@end
