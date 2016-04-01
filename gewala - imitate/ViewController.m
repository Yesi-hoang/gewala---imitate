//
//  ViewController.m
//  gewala - imitate
//
//  Created by Yesi on 16/3/31.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "Animatior.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pushImageV;
@property (weak, nonatomic) IBOutlet UIImageView *popImageV;

/** push or pop */
//@property (nonatomic, assign) BOOL isPush;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.pushButton.layer.cornerRadius = 5;
    self.pushButton.layer.masksToBounds = YES;
    self.pushImageV.layer.shadowColor = [UIColor grayColor].CGColor;
    self.pushImageV.layer.shadowOffset = CGSizeMake(0.1, 0.1);
    self.pushImageV.layer.shadowOpacity = 1;
    
    self.popButton.layer.cornerRadius = 5;
    self.popButton.layer.masksToBounds = YES;
    self.popImageV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.popImageV.layer.shadowOffset = CGSizeMake(0.7, 0.7);
    self.popImageV.layer.shadowOpacity = 1;
    
}
- (IBAction)pushClick:(id)sender {
     Animatior *animator = [Animatior new];
    __weak __typeof(self)weakSelf = self;

    [animator addAnimationForView:self.pushImageV completion:^{
        [weakSelf performSegueWithIdentifier:@"push" sender:nil];
    
    }];
}

- (IBAction)poClick:(id)sender {
    Animatior *animator = [Animatior new];
    __weak __typeof(self)weakSelf = self;
    
    [animator addAnimationForView:self.popImageV completion:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    }];
}

// 传入一个imageView 让它做先放大再缩小的动画 使用分类



@end
