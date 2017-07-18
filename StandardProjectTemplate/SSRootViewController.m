//
//  SSRootViewController.m
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import "SSRootViewController.h"
#import <Masonry.h>
#import "UIView+PinToast.h"
#import "SSBezierView.h"

@interface SSRootViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIButton      *actButton;
@property (nonatomic, strong) SSBezierView  *pathView;
@property (nonatomic, strong) UILabel       *animatePoint;

@end

@implementation SSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configureViews];
}

- (void)configureViews {
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.pathView];
    [self.pathView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.actButton];
    self.actButton.backgroundColor = [UIColor redColor];
    [self.actButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.view insertSubview:self.animatePoint belowSubview:self.pathView];
    self.animatePoint.frame = self.pathView.startPoint.frame;
    self.animatePoint.backgroundColor = [UIColor redColor];
    self.animatePoint.layer.masksToBounds = YES;
    self.animatePoint.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)onActButton {
//  // 方案1：直接画CGPath
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPoint startPosition = CGPointMake(CGRectGetMidX(self.startPoint.frame), CGRectGetMidY(self.startPoint.frame));
//    CGPoint endPosition = CGPointMake(CGRectGetMidX(self.endPoint.frame), CGRectGetMidY(self.endPoint.frame));
    
    // 起点
//    CGPathMoveToPoint(path, NULL, startPosition.x, startPosition.y);
    // 下面5行添加5条直线的路径到path中
//    CGPathAddLineToPoint(path, NULL, midA.x, midA.y);
//    CGPathAddLineToPoint(path, NULL, midB.x, midB.y);
//    CGPathAddLineToPoint(path, NULL, midC.x, midC.y);
//    CGPathAddLineToPoint(path, NULL, endPosition.x, endPosition.y);
    // 下面四行添加四条曲线路径到path
//    CGPathAddCurveToPoint(path, NULL, 30, 80, 40, 90, midA.x, midA.y);
//    CGPathAddCurveToPoint(path, NULL, 60, 260, 80, 300, midB.x, midB.y);
//    CGPathAddCurveToPoint(path, NULL, 130, 400, 160, 450, midC.x, midC.y);
//    CGPathAddCurveToPoint(path, NULL, 250, 520, 280, 580, endPosition.x, endPosition.y);
//    CGPathAddQuadCurveToPoint(path, NULL, 100, 580, endPosition.x, endPosition.y);
    
    // 方案2：赋值事先规划好的UIBezierPath
    // UIBezierPath类拥有自己底层的CGPathRef，好的用法是先拷贝后再使用，而不直接去使用它
    CGPathRef animatePath = CGPathCreateCopy(self.pathView.animatePath.CGPath);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:self];
    [animation setPath:animatePath];
    [animation setDuration:2.0];
    [animation setCalculationMode:kCAAnimationLinear];
//    // Path或Value有几段，keyTimes一般就应该有几段，且keyTimes需要配合calculationMode使用
//    [animation setKeyTimes:@[@0, @0.4, @0.45, @0.5, @0.55, @0.6, @1.0]];
    [animation setAutoreverses:NO];
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];
    
    CGPathRelease(animatePath);
    
    [self.animatePoint.layer addAnimation:animation forKey:NULL];
//    // 动画结束后位置同步更新
//    self.animatePoint.layer.position = endPosition;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"落子坐标：%@", NSStringFromCGRect(self.animatePoint.frame));
}

#pragma mark - Getter

- (SSBezierView *)pathView {
    if (!_pathView) {
        _pathView = [[SSBezierView alloc] init];
        _pathView.backgroundColor = [UIColor clearColor];
    }
    return _pathView;
}

- (UIButton *)actButton {
    if (!_actButton) {
        _actButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actButton setTitle:@"Start" forState:UIControlStateNormal];
        [_actButton addTarget:self action:@selector(onActButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actButton;
}

- (UILabel *)animatePoint {
    if (!_animatePoint) {
        _animatePoint = [[UILabel alloc] init];
    }
    return _animatePoint;
}

@end
