//
//  YesiTransitionAnimator.m
//  gewala - imitate
//
//  Created by Yesi on 16/3/31.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YesiTransitionAnimator.h"
@interface YesiTransitionAnimator()<UIViewControllerAnimatedTransitioning>

/** transitionContext */
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end
@implementation YesiTransitionAnimator


//UIViewControllerAnimatedTransitioning的协议方法
// 设置时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
// 设置动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 保存上下文和来去控制器 跳转按钮
    // 转场动画的上下文
    self.transitionContext = transitionContext;
    //上下文的内容容器
    UIView *containerView = [transitionContext containerView];
    // 转场的前后控制器
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    // 前控制器的跳转按钮
//    UIButton *fromButton = fromVC.pushButton;
//    UIButton *toButton = toVC.popButton;
//    直接使用30
    // 添加跳转控制器
    [containerView addSubview:toVC.view];
    
    // 2. 绘制路径
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    //蒙版初始路径fromButton.frame
    UIBezierPath *circlePathMaskInitial = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(screenW - 60, 30, 30, 30)];

    CGPoint extremePoint = CGPointMake(screenW - 60 + 15, 30 - screenH);
    
    // 半径
    CGFloat radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y));
    // 最终路径
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(screenW - 60, 30, 30, 30), -radius, -radius)];
    
    // 根据路径 抠出椭圆来
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    // 做过度动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(circlePathMaskInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(circleMaskPathFinal.CGPath);
    
    maskLayerAnimation.duration = [self transitionDuration:self.transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

//是实现动画结束后的操作，这里动画结束后需要做取消动画和将fromViewController释放掉的操作。
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    BOOL isStop = ![self.transitionContext transitionWasCancelled];
    [self.transitionContext completeTransition:isStop];

    ViewController *fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.view.layer.mask = nil;
    
}
@end
