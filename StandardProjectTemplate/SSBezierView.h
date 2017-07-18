//
//  SSBezierView.h
//  StandardProjectTemplate
//
//  Created by CIZ on 2017/7/17.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSBezierView : UIView

@property (nonatomic, strong) UILabel      *startPoint;
@property (nonatomic, strong) UILabel      *endPoint;
@property (nonatomic, assign) CGPoint      startPosition;
@property (nonatomic, assign) CGPoint      endPosition;

@property (nonatomic, strong) UIBezierPath *animatePath;

@end
