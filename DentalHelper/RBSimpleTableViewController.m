//
//  RBRootViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBSimpleTableViewController.h"
#import "RBScreenManager.h"

@interface RBSimpleTableViewController ()

@property (strong, nonatomic) RBScreen *rootScreen;

@end

@implementation RBSimpleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:_screen.title];
    self.navigationController.navigationBar.topItem.title = @"Back";

    [self.screen registerDequeIdentifiersForTableView:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.screen sectionsCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.screen numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBItem *item = [_screen itemForIndexPath:indexPath];

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.dequeIdentifier forIndexPath:indexPath];
    [item processTableViewCell:cell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RBItem *item = [_screen itemForIndexPath:indexPath];
    [item didSelectInViewController: self];
}



@end
