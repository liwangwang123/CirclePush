//
//  NavigationControllerDelegate.m
//  CirclePush
//
//  Created by 王力 on 2017/9/4.
//  Copyright © 2017年 Eddy. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "CustomPush.h"

@implementation NavigationControllerDelegate

#pragma mark -- UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    return [[CustomPush alloc] init];
    
}

@end
