//
//  YesiNavigationDelegate.m
//  gewala - imitate
//
//  Created by Yesi on 16/3/31.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "YesiNavigationDelegate.h"
#import "YesiTransitionAnimator.h"
#import "Animatior.h"
@interface YesiNavigationDelegate()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;
@end
@implementation YesiNavigationDelegate
// Add gesture
- (void)awakeFromNib{
    [super awakeFromNib];
    UIPanGestureRecognizer *pan  = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.navigationController.view addGestureRecognizer:pan];
}
- (void)pan:(UIPanGestureRecognizer *)pan{
    switch (pan.state) {
             // 开始的时候判断是push 还是 pop
        case UIGestureRecognizerStateBegan:{
            //interactionController可以理解为动画控制器
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
            
            
        if (self.navigationController.childViewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:YES];
        }
        else{
                [self.navigationController.topViewController performSegueWithIdentifier:@"push" sender:nil];
         }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            // 根据手指的X判断动画的百分比
            CGPoint transition = [pan translationInView:self.navigationController.view];
            CGFloat rate = transition.x / (CGRectGetWidth(self.navigationController.view.bounds));
            //更新手动动画滑动比例
             [self.interactionController updateInteractiveTransition:rate];
            break;
        }
        case UIGestureRecognizerStateEnded:
            {
                // 移动速率  什么鬼
            if([pan velocityInView:self.navigationController.view].x > 0){
                [self.interactionController finishInteractiveTransition];
            }else{
                [self.interactionController cancelInteractiveTransition];

            }
            //千万手势结束的时候要吧动画控制器清楚掉否则会影响按钮点击的跳转
            self.interactionController = nil;
            break;
        }
        default:{
            [self.interactionController cancelInteractiveTransition];
            self.interactionController = nil;
            break;
        }
    } 
}

//animationControllerForOperation 返回一个动画器
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    // 我们需要创建一个实现动画效果的类，并使其返回(YesiTransitionAnimator)
    return (id)[YesiTransitionAnimator new];
}
//Called to allow the delegate to return an interactive animator object for use during view controller transitions.
//interactionControllerForAnimationController  统管动画的控制器（导航控制器）
//理解：返回导航控制器，他控制他下面的两个前后控制器来回push pop（TabBar也是一个道理）
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    return self.interactionController;
}
@end
