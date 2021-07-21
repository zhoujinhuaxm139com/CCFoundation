//
//  CCNavigationController.m
//  CCFoundation
//
//  Created by zjh on 2021/7/21.
//  Copyright © 2021 zjh. All rights reserved.
//

#import "CCNavigationController.h"
#import "CCNavigationControllerIMP.h"
#import "CCTargetProxy.h"
@interface CCNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) CCNavigationControllerIMP *navigationControllerIMP;
@end

@implementation CCNavigationController
-(id)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    self.navigationControllerIMP = [[CCNavigationControllerIMP alloc] init];
    self.navigationControllerIMP.navigationController = self;
    self.delegate = (id<UINavigationControllerDelegate>)[[CCTargetProxy alloc] initWithTarget:self.navigationControllerIMP];//如果导航栏其他地方被设置代理会导致该类功能失效
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
}


#pragma mark - ---- StatusBar ----
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.topViewController.prefersStatusBarHidden;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
