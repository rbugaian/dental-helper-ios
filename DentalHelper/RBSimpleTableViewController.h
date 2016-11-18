//
//  RBRootViewController.h
//  DentalHelper
//
//  Created by Roman Bugaian on 14/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBSimpleTableViewScreen.h"

@interface RBSimpleTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) RBSimpleTableViewScreen *screen;

@end
