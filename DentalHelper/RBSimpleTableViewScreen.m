//
//  RBSimpleTableViewScreen.m
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBSimpleTableViewScreen.h"
#import "RBSimpleTableViewController.h"
#import "RBScreen.h"
#import "RBItem.h"

@interface RBSimpleTableViewScreen()

@property (strong, nonatomic) NSMutableDictionary *sectionsDict;

@end

@implementation RBSimpleTableViewScreen : RBScreen

- (instancetype)init {
    RBSimpleTableViewScreen *screen = [super init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RBSimpleTableViewController" bundle:nil];
    RBSimpleTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RBSimpleTableViewController"];
    vc.screen = screen;
    screen.viewController = vc;
    
    screen.sectionsDict = [NSMutableDictionary dictionary];
    
    return screen;
}

+ (RBSimpleTableViewScreen *) screenWithDict:(NSDictionary *)dict {
    RBSimpleTableViewScreen *screen = [[RBSimpleTableViewScreen alloc] init];
    
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *jsonItems = dict[@"items"];
    for (int i = 0; i < jsonItems.count; i++) {
        NSDictionary *jsonItem = [jsonItems objectAtIndex:i];
        RBItem *item = [RBItem itemWithDict:jsonItem];
        [items addObject:item];
    }
    
    screen.items = [items mutableCopy];
    
    return screen;
}

- (NSInteger)sectionsCount {
    [_sectionsDict removeAllObjects];
    for (RBItem *item in self.items) {
        if (item.section != nil && item.section.length != 0) {
            if (![_sectionsDict objectForKey:item.section]) {
                NSMutableArray *itemsArray = [NSMutableArray array];
                [itemsArray addObject:item];
                [_sectionsDict setObject:[itemsArray mutableCopy] forKey:item.section];
                
            } else {
                NSMutableArray *itemsForSection = [NSMutableArray arrayWithArray: [_sectionsDict objectForKey:item.section]];
                [itemsForSection addObject:item];
                [_sectionsDict setObject:[itemsForSection mutableCopy] forKey:item.section];
            }
        } else {
            if (![_sectionsDict objectForKey:@"_"]) {

                NSMutableArray *itemsArray = [NSMutableArray array];

                [itemsArray addObject:item];
                [_sectionsDict setObject:itemsArray forKey:@"_"];
                
            } else {
                NSMutableArray *itemsForSection = [NSMutableArray arrayWithArray: [_sectionsDict objectForKey:@"_"]];
                [itemsForSection addObject:item];
                [_sectionsDict setObject:[itemsForSection mutableCopy] forKey:@"_"];
            }
        }
    }
    
    if (_sectionsDict.allKeys.count == 0) {
        return 1;
    } else {
        return _sectionsDict.allKeys.count;
    }
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    
    NSString *sectionKey = [_sectionsDict.allKeys objectAtIndex:section];
    return [[_sectionsDict objectForKey:sectionKey] count];
}

- (RBItem *)itemForIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionKey = [_sectionsDict.allKeys objectAtIndex:indexPath.section];
    
    NSArray *rowsForSection = [_sectionsDict objectForKey:sectionKey];
    RBItem *singleItem = [rowsForSection objectAtIndex:indexPath.row];

    return singleItem;
}

- (void)registerDequeIdentifiersForTableView:(UITableView *)tableView {
    for (RBItem *item in self.items) {
        [tableView registerNib:[UINib nibWithNibName:item.nibName bundle:nil] forCellReuseIdentifier:item.dequeIdentifier];
    }
}

@end
