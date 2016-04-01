
//
//  Animatior.m
//  gewala - imitate
//
//  Created by Yesi on 16/4/1.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "Animatior.h"
@interface Animatior()
/** block */
@property (nonatomic, copy) void(^completion)();
@end
@implementation Animatior
- (void)addAnimationForView:(UIView *)view completion:(void(^)())completion{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.toValue = @1.3;
    animation.repeatCount = 1;
    animation.duration = 0.2;
    animation.autoreverses = YES;
    //    监听动画
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:@"scale"];
    self.completion = completion;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.completion();
}

@end
