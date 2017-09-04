//
//  CustomPush.m
//  CirclePush
//
//  Created by 王力 on 2017/9/4.
//  Copyright © 2017年 Eddy. All rights reserved.
//

#import "CustomPush.h"
#import "ViewController.h"

@implementation CustomPush

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //环境
    UIView *contextView = transitionContext.containerView;
    //toVC
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //fromVC
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //btn
    UIButton *pushBtn = fromVC.button;
    //添加 toView
    [contextView addSubview:toVC.view];
    
    //圆形路径初初始化
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:pushBtn.frame];
    //端点
    CGPoint extremePoint = CGPointMake(pushBtn.center.x, pushBtn.center.y - toVC.view.bounds.size.height);
    //角度
    CGFloat radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y));
    //变化之后的 frame
    CGRect frame = CGRectMake(pushBtn.frame.origin.x - radius, pushBtn.frame.origin.y - radius, pushBtn.frame.size.width - (-2 * radius), pushBtn.frame.size.height - (-2 * radius));
    
    //尾端
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    //形状
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    [CATransaction begin];
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [CATransaction setCompletionBlock:^{
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    }];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    [CATransaction commit];
}


@end
