//
//  AddPatientViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 27/06/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "AddPatientViewController.h"

@interface AddPatientViewController ()

@property NSMutableArray *allergies;
@property NSMutableArray *lastVisits;

@end

@implementation AddPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allergies = [NSMutableArray arrayWithArray:@[@"Ledokoin", @"Anestesia", @"Novokain"]];
    _lastVisits = [NSMutableArray arrayWithArray:@[
                                                   @{@"procedure": @"Tooth Pulling", @"date":@"15.06.2016"},
                                                   @{@"procedure": @"Whitening", @"date":@"16.06.2016"},
                                                   @{@"procedure": @"Repair", @"date":@"17.06.2016"}
                                                   ]
                   ];
    
    
    // Do any additional setup after loading the view.
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    switch (section) {
//        case 0:
//            return 3;
//            break;
//            
//        case 1:
//            return _allergies.count;
//            break;
//            
//        case 2:
//            return _lastVisits.count;
//            break;
//    }
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.section) {
//        case 0:
//            return [self preparePersonalCellForIndexPath:indexPath];
//            break;
//            
//        case 1:
//            return [self prepareAllergiesCellForIndexPath:indexPath];
//            break;
//            
//        case 2:
//            return [self prepareLastVisitsCellForIndexPath:indexPath];
//            break;
//            
//        default:
//            return nil;
//            break;
//    }
//}

//- (UITableViewCell *)preparePersonalCellForIndexPath:(NSIndexPath *)indexPath {
//    
//    switch (indexPath.row) {
//        case 0:
//            return [self.tableView dequeueReusableCellWithIdentifier:@"FirstNameCell"];
//            break;
//            
//        case 1:
//            return [self.tableView dequeueReusableCellWithIdentifier:@"LastNameCell"];
//            break;
//            
//        case 2:
//            return [self.tableView dequeueReusableCellWithIdentifier:@"BirthDateCell"];
//            break;
//            
//        default:
//            return nil;
//            break;
//    }
//}
//
//- (UITableViewCell *)prepareAllergiesCellForIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AllergyCell"];
//    
//    cell.textLabel.text = [_allergies objectAtIndex:indexPath.row];
//    return cell;
//}
//
//- (UITableViewCell *)prepareLastVisitsCellForIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"LastVisitCell"];
//    cell.textLabel.text = [[_lastVisits objectAtIndex:indexPath.row] objectForKey:@"procedure"];
//    cell.detailTextLabel.text = [[_lastVisits objectAtIndex:indexPath.row] objectForKey:@"date"];
//    
//    return cell;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
