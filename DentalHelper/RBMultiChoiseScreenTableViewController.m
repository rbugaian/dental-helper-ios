//
//  RBMultiChoiseScreenTableViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 17/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBMultiChoiseScreenTableViewController.h"
#import "RBChoiseItem.h"

@interface RBMultiChoiseScreenTableViewController ()

@end

@implementation RBMultiChoiseScreenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_screen registerDequeIdentifiersForTableView:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [_screen numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_screen numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RBChoiseItem *item = [_screen itemForIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.dequeIdentifier forIndexPath:indexPath];
    
    [item processTableViewCell:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RBChoiseItem *item = [_screen itemForIndexPath:indexPath];
    item.isSelected = !item.isSelected;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


@end
