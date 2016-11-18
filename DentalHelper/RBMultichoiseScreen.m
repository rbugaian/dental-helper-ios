//
//  RBMultichoiseScreen.m
//  DentalHelper
//
//  Created by Roman Bugaian on 17/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBMultichoiseScreen.h"
#import "RBMultiChoiseScreenTableViewController.h"
#import "RBChoiseItem.h"

@implementation RBMultichoiseScreen

- (instancetype)init {
    RBMultichoiseScreen *screen = [super init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RBMultiChoiseScreenViewController" bundle:nil];
    RBMultiChoiseScreenTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RBMultiChoiseScreenViewController"];
    vc.screen = screen;
    screen.viewController = vc;
    return screen;
}

+ (RBMultichoiseScreen *) screenWithDict:(NSDictionary *)dict {
    RBMultichoiseScreen *screen = [[RBMultichoiseScreen alloc] init];
    
    NSMutableArray *items = [NSMutableArray array];
    
    for (NSString *itemString in dict[@"items"]) {
        [items addObject:[RBChoiseItem itemWithTitle:itemString]];
    }
    screen.items = [items mutableCopy];
    
    return screen;
}

-(NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (RBChoiseItem *)itemForIndexPath:(NSIndexPath *)indexPath {
     return [_items objectAtIndex:indexPath.row];
}

- (void)registerDequeIdentifiersForTableView:(UITableView *)tableView {
    for (RBItem *item in self.items) {
        [tableView registerNib:[UINib nibWithNibName:item.nibName bundle:nil] forCellReuseIdentifier:item.dequeIdentifier];
    }
}


@end
