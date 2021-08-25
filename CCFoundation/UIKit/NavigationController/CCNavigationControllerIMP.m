//
//  CCNavigationControllerIMP.m
//  CCFoundation
//
//  Created by zjh on 2021/7/21.
//  Copyright © 2021 zjh. All rights reserved.
//

#import "CCNavigationControllerIMP.h"
@interface CCNavigationControllerIMP()

@end

@implementation CCNavigationControllerIMP

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    id<CCNavgationBarAppearnce> obj = (id<CCNavgationBarAppearnce>)viewController;
    if ([obj respondsToSelector:@selector(CCHiddenNavgationBar)]) {
        [navigationController setNavigationBarHidden:obj.CCHiddenNavgationBar animated:animated];
    }
    if ([obj respondsToSelector:@selector(CCBarTintColor)]) {
        [navigationController.navigationBar setBarTintColor:obj.CCBarTintColor];
    }
    if ([obj respondsToSelector:@selector(CCBarTintColor)]) {
        [navigationController.navigationBar setTintColor:obj.CCTintColor];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    id<CCNavgationBarAppearnce> obj = (id<CCNavgationBarAppearnce>)viewController;
    if ([obj respondsToSelector:@selector(CCSideslip)]) {
        navigationController.interactivePopGestureRecognizer.enabled = obj.CCSideslip;
    }
}

-(nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        id<CCNavgationAnimation> obj = (id<CCNavgationAnimation>)fromVC;
        if ([obj respondsToSelector:@selector(animationControllerForOperationPush)]) {
            return [obj animationControllerForOperationPush];
        }
    }
    else if(operation == UINavigationControllerOperationPop){
        id<CCNavgationAnimation> obj = (id<CCNavgationAnimation>)toVC;
        if ([obj respondsToSelector:@selector(animationControllerForOperationPop)]) {
            return [obj animationControllerForOperationPop];
        }
    }
    return nil;
}

@end
