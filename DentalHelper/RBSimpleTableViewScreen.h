//
//  RBSimpleTableViewScreen.h
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBScreen.h"
#import "RBItem.h"

@interface RBSimpleTableViewScreen : RBScreen

@property (strong, nonatomic) NSArray *items;

+ (RBSimpleTableViewScreen *) screenWithDict:(NSDictionary *)dict;

- (NSInteger)sectionsCount;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (RBItem *)itemForIndexPath:(NSIndexPath *)indexPath;

- (void)registerDequeIdentifiersForTableView:(UITableView *)tableView;

@end
