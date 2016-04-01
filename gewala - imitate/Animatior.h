//
//  Animatior.h
//  gewala - imitate
//
//  Created by Yesi on 16/4/1.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Animatior : NSObject
- (void)addAnimationForView:(UIView *)view completion:(void(^)())completion;
@end
