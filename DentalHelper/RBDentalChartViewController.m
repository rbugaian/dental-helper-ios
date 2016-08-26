//
//  RBDentalChartViewController.m
//  DentalHelper
//
//  Created by Roman Bugaian on 01/08/16.
//  Copyright © 2016 Roman Bugaian. All rights reserved.
//

#import "RBDentalChartViewController.h"
#import "RBTopToothView.h"
#import "RBBottomToothView.h"

@interface RBDentalChartViewController ()

@property UIView *chartHolderView;

@property CGFloat toothViewWidth;
@property CGFloat toothViewHeight;

@end

@implementation RBDentalChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _toothViewWidth = 74.0f;
    _toothViewHeight = 180.0f;
    
    [self drawTeeth];
    
    self.chartScrollView.delegate = self;
    self.chartScrollView.minimumZoomScale = 0.28f;
    
    [_chartScrollView setZoomScale:0.28f animated:NO];
}

- (void)viewDidLayoutSubviews {
    CGFloat y = (self.view.frame.size.height - _chartHolderView.frame.size.height) / 2.0f;
    CGFloat x = (self.view.frame.size.width - _chartHolderView.frame.size.width) / 2.0f;
    
    [_chartScrollView setContentInset:UIEdgeInsetsMake(y, x, y, x)];
}


- (void) drawTeeth {
    CGFloat chartsHolderViewWidth = 16.0f * _toothViewWidth + (17.0f * 8.0f);
    CGFloat chartsHolderViewHeight = _toothViewHeight * 2.0f;
    
    [self.chartScrollView setContentSize:CGSizeMake(chartsHolderViewWidth, self.view.frame.size.height)];
    
    _chartHolderView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, chartsHolderViewWidth, 350.0f)];
    
    [self.chartScrollView addSubview:_chartHolderView];
    
    _chartHolderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_chartHolderView addConstraint:[NSLayoutConstraint constraintWithItem:_chartHolderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:chartsHolderViewWidth]];
    
    [_chartHolderView addConstraint:[NSLayoutConstraint constraintWithItem:_chartHolderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:chartsHolderViewHeight]];
    
    [_chartScrollView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:_chartHolderView
                                         attribute:NSLayoutAttributeLeading
                                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                                         toItem:_chartScrollView
                                         attribute:NSLayoutAttributeLeading
                                         multiplier:1.0f
                                         constant:0.0f]];
    
    [_chartScrollView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:_chartHolderView
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:_chartScrollView
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:0.0f]];
    
//    [_chartHolderView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self drawTopRow];
    [self drawBottomRow];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _chartHolderView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"Ended zooming: Size: %@ Scale: %f", view, scale);
    
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat viewWidth = view.frame.size.width;
    CGFloat viewHeight = view.frame.size.height;
    
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    
    if(viewWidth < screenWidth) {
        x = (screenWidth - viewWidth) / 2;
    }
    if(viewHeight < screenHeight) {
        y = (screenHeight - viewHeight) / 2;
    }

    [UIView animateWithDuration:0.2 animations:^{
        self.chartScrollView.contentInset = UIEdgeInsetsMake(y, x, y, x);
    }];
}

- (void) drawTopRow {
    RBTopToothView *initialTopToothView = [self loadTopToothView];
    
    [self.chartHolderView addSubview:initialTopToothView];

    [self.chartHolderView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:initialTopToothView
                                         attribute:NSLayoutAttributeLeading
                                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                                         toItem:self.chartHolderView
                                         attribute:NSLayoutAttributeLeading
                                         multiplier:1.0f
                                         constant:8.0f]];

    [self.chartHolderView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:initialTopToothView
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.chartHolderView
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:8.0f]];
   
    NSArray *teethNumbers = @[@"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",];

    initialTopToothView.toothNumber.text = teethNumbers.firstObject;

    for (int i = 1; i < 16; i++) {
        RBTopToothView *view = [self loadTopToothView];
//        [view.layer setCornerRadius:12.0f];
//        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.chartHolderView addSubview:view];
        
        NSLayoutConstraint *view2Contstraint = [NSLayoutConstraint
                                                constraintWithItem:view
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                toItem:initialTopToothView
                                                attribute:NSLayoutAttributeRight
                                                multiplier:1.0
                                                constant:8.0f];
        [self.chartHolderView addConstraint:view2Contstraint];
        
        NSLayoutConstraint *topAlignmentConstr = [NSLayoutConstraint
                                                  constraintWithItem:view
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:initialTopToothView
                                                  attribute:NSLayoutAttributeTop
                                                  multiplier:1.0
                                                  constant:0.0f];
        [self.chartHolderView addConstraint:topAlignmentConstr];
        
        view.toothNumber.text = [teethNumbers objectAtIndex:i];
        
        initialTopToothView = view;
    }
}

- (RBTopToothView *)loadTopToothView {
    RBTopToothView *view = [[NSBundle mainBundle] loadNibNamed:@"RBTopToothView" owner:self options:nil].firstObject;
    [view.layer setCornerRadius:14.0f];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    view.toothTopView.image = [view.toothTopView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    view.toothRootView.image = [view.toothRootView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    view.tintColor = [UIColor whiteColor];
    
    view.toothNumber.textColor = [UIColor whiteColor];
    
    return view;
}

- (RBBottomToothView *)loadBottomToothView {
    RBBottomToothView *view = [[NSBundle mainBundle] loadNibNamed:@"RBBottomToothView" owner:self options:nil].firstObject;
    [view.layer setCornerRadius:14.0f];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    view.toothTopView.image = [view.toothTopView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    view.toothRootView.image = [view.toothRootView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    view.tintColor = [UIColor whiteColor];
    
    view.toothNumber.textColor = [UIColor whiteColor];
    
    return view;
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"Ratated: %ld", (long)fromInterfaceOrientation);
    
//    [_chartScrollView zoomToRect:_chartHolderView.frame animated:YES];
    
//    [_chartScrollView setZoomScale:0.29f animated:YES];
}


- (void)drawBottomRow {
    RBBottomToothView *initialTopToothView = [self loadBottomToothView];
    
    [self.chartHolderView addSubview:initialTopToothView];
    
    [self.chartHolderView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:initialTopToothView
                                         attribute:NSLayoutAttributeLeft
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.chartHolderView
                                         attribute:NSLayoutAttributeLeft
                                         multiplier:1.0f
                                         constant:8.0f]];
    
    [self.chartHolderView addConstraint:[NSLayoutConstraint
                                         constraintWithItem:initialTopToothView
                                         attribute:NSLayoutAttributeBottom
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.chartHolderView
                                         attribute:NSLayoutAttributeBottom
                                         multiplier:1.0f
                                         constant:-8.0f]];
    
    NSArray *teethNumbers = @[@"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",];

    initialTopToothView.toothNumber.text = teethNumbers.firstObject;

    for (int i = 1; i < 16; i++) {
        RBBottomToothView *view = [self loadBottomToothView];
        
        [self.chartHolderView addSubview:view];
        
        NSLayoutConstraint *view2Contstraint = [NSLayoutConstraint
                                                constraintWithItem:view
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                toItem:initialTopToothView
                                                attribute:NSLayoutAttributeRight
                                                multiplier:1.0
                                                constant:8.0f];
        [self.chartHolderView addConstraint:view2Contstraint];
        
        NSLayoutConstraint *topAlignmentConstr = [NSLayoutConstraint
                                                  constraintWithItem:view
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:initialTopToothView
                                                  attribute:NSLayoutAttributeTop
                                                  multiplier:1.0
                                                  constant:0.0f];
        [self.chartHolderView addConstraint:topAlignmentConstr];
        
        view.toothNumber.text = [teethNumbers objectAtIndex:i];
        
        initialTopToothView = view;
    }
}



@end
