//
//  RBMultichoiseScreen.h
//  DentalHelper
//
//  Created by Roman Bugaian on 17/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBScreen.h"
#import "RBChoiseItem.h"

@interface RBMultichoiseScreen : RBScreen

@property (strong, nonatomic) NSArray *items;

+ (RBMultichoiseScreen *) screenWithDict:(NSDictionary *)dict;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (RBChoiseItem *)itemForIndexPath:(NSIndexPath *)indexPath;
- (void)registerDequeIdentifiersForTableView:(UITableView *)tableView;

@end
