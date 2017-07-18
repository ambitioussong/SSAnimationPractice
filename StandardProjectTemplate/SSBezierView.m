//
//  SSBezierView.m
//  StandardProjectTemplate
//
//  Created by CIZ on 2017/7/17.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import "SSBezierView.h"

#define DEGREES_TO_RADIANS(degrees)     ((M_PI * degrees) / 180)

@interface SSBezierView ()

@property (nonatomic, strong) UILabel *controlPoint;
@property (nonatomic, assign) CGPoint controlPosition;

@end

@implementation SSBezierView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureViews];
        
        [self configureBezierPath];
    }
    return self;
}

- (void)configureViews {
    self.startPosition = CGPointMake(240, 100);
    self.endPosition = CGPointMake(120, 220);
    self.controlPosition = CGPointMake(120, 140);
    
    [self addSubview:self.startPoint];
    self.startPoint.bounds = CGRectMake(0, 0, 20, 20);
    self.startPoint.center = self.startPosition;
    self.startPoint.backgroundColor = [UIColor redColor];
    self.startPoint.layer.masksToBounds = YES;
    self.startPoint.layer.cornerRadius = 10;
    
    [self addSubview:self.endPoint];
    self.endPoint.bounds = CGRectMake(0, 0, 20, 20);
    self.endPoint.center = self.endPosition;
    self.endPoint.backgroundColor = [UIColor redColor];
    self.endPoint.layer.masksToBounds = YES;
    self.endPoint.layer.cornerRadius = 10;
    
    [self addSubview:self.controlPoint];
    self.controlPoint.bounds = CGRectMake(0, 0, 6, 6);
    self.controlPoint.center = self.controlPosition;
    self.controlPoint.backgroundColor = [UIColor blueColor];
    self.controlPoint.layer.masksToBounds = YES;
    self.controlPoint.layer.cornerRadius = 3;
}

- (void)configureBezierPath {
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound;
    aPath.lineJoinStyle = kCGLineCapRound;
    
    //    // UIBezierPath绘制方法
    //    [aPath moveToPoint:CGPointMake(300, 80)];
    //    [aPath addLineToPoint:]
    //    [aPath addQuadCurveToPoint: controlPoint:
    //    [aPath addCurveToPoint: controlPoint1: controlPoint2:]
    
    [aPath addArcWithCenter:CGPointMake(180, 100)
                     radius:60
                 startAngle:DEGREES_TO_RADIANS(0)
                   endAngle:DEGREES_TO_RADIANS(180)
                  clockwise:NO];
    [aPath addQuadCurveToPoint:CGPointMake(180, 160) controlPoint:self.controlPosition];
    [aPath addQuadCurveToPoint:CGPointMake(240, 220) controlPoint:CGPointMake(240, 180)];
    [aPath addQuadCurveToPoint:CGPointMake(180, 280) controlPoint:CGPointMake(240, 280)];
    [aPath addQuadCurveToPoint:self.endPosition controlPoint:CGPointMake(120, 280)];
    
    self.animatePath = aPath;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor redColor] setFill];
    [[UIColor blackColor] setStroke];
    
    [self.animatePath stroke];
    
    UIBezierPath *controlPath = [UIBezierPath bezierPath];
    [controlPath moveToPoint:CGPointMake(120, 100)];
    [controlPath addLineToPoint:self.controlPosition];
    [controlPath addLineToPoint:CGPointMake(180, 160)];
    [controlPath stroke];
}

#pragma mark - Getter

- (UILabel *)startPoint {
    if (!_startPoint) {
        _startPoint = [[UILabel alloc] init];
        _startPoint.textAlignment = NSTextAlignmentCenter;
        _startPoint.text = @"o";
    }
    return _startPoint;
}

- (UILabel *)endPoint {
    if (!_endPoint) {
        _endPoint = [[UILabel alloc] init];
        _endPoint.textAlignment = NSTextAlignmentCenter;
        _endPoint.text = @"o'";
    }
    return _endPoint;
}

- (UILabel *)controlPoint {
    if (!_controlPoint) {
        _controlPoint = [[UILabel alloc] init];
        _controlPoint.textAlignment = NSTextAlignmentCenter;
        _controlPoint.text = @"C";
    }
    return _controlPoint;
}

@end
