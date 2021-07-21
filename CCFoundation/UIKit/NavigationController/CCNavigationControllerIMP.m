//
//  CCNavigationControllerIMP.m
//  CCFoundation
//
//  Created by zjh on 2021/7/21.
//  Copyright © 2021 zjh. All rights reserved.
//

#import "CCNavigationControllerIMP.h"
@interface CCNavigationControllerIMP()<UINavigationControllerDelegate>

@end

@implementation CCNavigationControllerIMP
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if (self.navigationController.childViewControllers.count) {
        // 如果不是TTBaseViewController类，统一设置导航UI
        UIBarButtonItem *leftBackItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_black"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        viewController.navigationItem.leftBarButtonItems = @[leftBackItem];
            // 自动隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 调用父类push实现方法,可以在对应ViewController再次覆盖leftBarButtonItem默认返回样式
    [self.navigationController pushViewController:viewController animated:animated];
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    id<CCNavgationBarAppearnce> obj = (id<CCNavgationBarAppearnce>)viewController;
    if ([obj respondsToSelector:@selector(hiddenCCNavgationBar)]) {
        [navigationController setNavigationBarHidden:obj.hiddenCCNavgationBar animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    id<CCNavgationBarAppearnce> obj = (id<CCNavgationBarAppearnce>)viewController;
    if ([obj respondsToSelector:@selector(sideslip)]) {
        navigationController.interactivePopGestureRecognizer.enabled = obj.sideslip;
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
#pragma mark - ---- Addition ----
- (void)backAction
{
    [self.navigationController.view endEditing:YES];//解决编辑状态黑影问题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
@end
