//
//  ProceduresViewControllerTests.m
//  DentalHelper
//
//  Created by Roman Bugaian on 25/07/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppointmentsTableViewController.h"
#import <Realm/Realm.h>
#import "Appointment.h"

@interface ProceduresViewControllerTests : XCTestCase

@property (nonatomic) AppointmentsTableViewController *vcToTest;

@end


@interface AppointmentsTableViewController (Test)

@property (nonatomic) RLMResults *procedures;

@end

@implementation ProceduresViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vcToTest = [[AppointmentsTableViewController alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testProceduresLoading {
    [_vcToTest viewWillAppear:YES];
    
    RLMResults *appointments = [Appointment allObjects];
    XCTAssertEqual(appointments.count, [_vcToTest.tableView numberOfRowsInSection:0]);
}


@end
