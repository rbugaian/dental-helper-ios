//
//  RBScreenViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 17/11/2016.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBScreenViewController.h"

@implementation RBScreenViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:_screen.title];
    self.navigationController.navigationBar.topItem.title = @"Back";
}

@end
