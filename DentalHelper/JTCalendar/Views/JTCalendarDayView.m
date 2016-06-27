//
//  JTCalendarDayView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarDayView.h"

#import "JTCalendarManager.h"

@implementation JTCalendarDayView {
    UIColor *previousCircleViewBackgroundColor;
    UIColor *previousCircleViewTextColor;
    BOOL wasCircleViewHidden;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    self.clipsToBounds = YES;
    
    _circleRatio = .9;
    _dotRatio = 1. / 9.;
    
    {
        _circleView = [UIView new];
        [self addSubview:_circleView];
        
        _circleView.backgroundColor = [UIColor colorWithRed:0x33/256. green:0xB3/256. blue:0xEC/256. alpha:.5];
        _circleView.hidden = YES;

        _circleView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _circleView.layer.shouldRasterize = YES;
    }
    
    {
        _dotView = [UIView new];
        [self addSubview:_dotView];
        
        _dotView.backgroundColor = [UIColor redColor];
        _dotView.hidden = YES;

        _dotView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _dotView.layer.shouldRasterize = YES;
    }
    
    {
        _textLabel = [UILabel new];
        [self addSubview:_textLabel];
        
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    
    {
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouch)];
        
        self.userInteractionEnabled = YES;
        //[self addGestureRecognizer:gesture];
    }
}

- (void)layoutSubviews
{
    _textLabel.frame = self.bounds;
    
    CGFloat sizeCircle = MIN(self.frame.size.width, self.frame.size.height);
    CGFloat sizeDot = sizeCircle;
    
    sizeCircle = sizeCircle * _circleRatio;
    sizeDot = sizeDot * _dotRatio;
    
    sizeCircle = roundf(sizeCircle);
    sizeDot = roundf(sizeDot);
    
    _circleView.frame = CGRectMake(0, 0, sizeCircle, sizeCircle);
    _circleView.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
    _circleView.layer.cornerRadius = sizeCircle / 2.;
    
    _dotView.frame = CGRectMake(0, 0, sizeDot, sizeDot);
    _dotView.center = CGPointMake(self.frame.size.width / 2., (self.frame.size.height / 2.) +sizeDot * 2.5);
    _dotView.layer.cornerRadius = sizeDot / 2.;
}

- (void)setDate:(NSDate *)date
{
    NSAssert(date != nil, @"date cannot be nil");
    NSAssert(_manager != nil, @"manager cannot be nil");
    
    self->_date = date;
    [self reload];
}

- (void)reload
{
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter){
        dateFormatter = [_manager.dateHelper createDateFormatter];
        [dateFormatter setDateFormat:@"dd"];
    }
    
    _textLabel.text = [dateFormatter stringFromDate:_date];
        
    [_manager.delegateManager prepareDayView:self];
}

//- (void)didTouch
//{
//    [_manager.delegateManager didTouchDayView:self];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //NSLog(@"Touches bagan");
    previousCircleViewBackgroundColor = self.circleView.backgroundColor;
    previousCircleViewTextColor = self.textLabel.textColor;
    wasCircleViewHidden = self.circleView.hidden;
    
    self.circleView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:0.9f];
    self.circleView.hidden = NO;
    
    self.textLabel.textColor = [UIColor blackColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //NSLog(@"Touches ended");
    self.circleView.backgroundColor = previousCircleViewBackgroundColor;
    self.circleView.hidden = wasCircleViewHidden;
    
    self.textLabel.textColor = previousCircleViewTextColor;
    
    [_manager.delegateManager didTouchDayView:self];
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //NSLog(@"Touches cancelled");
    
    self.circleView.backgroundColor = previousCircleViewBackgroundColor;
    self.circleView.hidden = wasCircleViewHidden;
    
    self.textLabel.textColor = previousCircleViewTextColor;
}

@end
