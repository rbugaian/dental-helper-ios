//
//  ProceduresViewControllerUITests.m
//  DentalHelper
//
//  Created by Roman Bugaian on 25/07/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppointmentsTableViewController.h"
//#import "Utils.h"

@interface ProceduresViewControllerUITests : XCTestCase

//@property (nonatomic) ProceduresTableViewController *proceduresViewController;

@end

//@interface ProceduresTableViewController(Test)
//
////@property (nonatomic) RLMResults *procedures;
//
//@end

@implementation ProceduresViewControllerUITests

- (void)setUp {
    [super setUp];
    
    [[[XCUIApplication alloc] init] launch];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAppointmentCreation {
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationFaceUp;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.navigationBars[@"Schedule"].buttons[@"Add"] tap];
    [app.tables.staticTexts[@"Select Patient"] tap];
    
    XCUIElementQuery *patientCells = app.tables.cells;
    if (patientCells.count > 0) {
        [[patientCells elementBoundByIndex:0] tap];
        
        NSString *starDateString = [[[[app.tables childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeTextField].element value];
        
        [app.navigationBars[@"New Appointment"].buttons[@"Done"] tap];
        
        XCUIApplication *app = [[XCUIApplication alloc] init];
        [app.tabBars.buttons[@"Procedures"] tap];
//        [[app.tables.cells containingType:XCUIElementTypeStaticText identifier:@"25 Jul 2016 16:50"].staticTexts[@"John\U043e\U0440\U0438\U0438\U0438\U0438 Smith"] tap];
        
        
    } else {
        [app.navigationBars[@"Patients"].buttons[@"+"] tap];
    }
    
}

//- (void)testExample {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//}
//
//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
