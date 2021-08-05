//
//  CCNavigationController.m
//  CCFoundation
//
//  Created by zjh on 2021/7/21.
//  Copyright © 2021 zjh. All rights reserved.
//

#import "CCNavigationController.h"
#import "CCNavigationControllerIMP.h"
@interface CCNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) CCNavigationControllerIMP *navigationControllerIMP;
@end

@implementation CCNavigationController
+ (void)initialize
{
    // 方式二：当导航控制包含当前类时才需要设置,只会设置一次，因为是通过appearance皮肤全局配置
    if(@available(iOS 11.0, *)){
        [[UITableView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    //设置状态栏类型
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    //设置导航栏背景色
//
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    if(@available(iOS 11.0, *)){
        navBar.prefersLargeTitles = NO;
        [navBar setLargeTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25],NSForegroundColorAttributeName:UIColor.whiteColor}];
        //[navBar setBackgroundColor:CCwhiteColor];
    }
    [navBar setBarStyle:UIBarStyleBlack];
    [navBar setHidden:NO];
    [navBar setBarTintColor:UIColor.whiteColor];
    [navBar setTintColor:UIColor.blackColor];
    [navBar setTranslucent:NO];
//    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
    
    // 设置导航标题字体
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium],NSForegroundColorAttributeName:UIColor.blackColor}];
    // 设置导航菜单项
    UIBarButtonItem *barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.whiteColor} forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.whiteColor} forState:UIControlStateDisabled];
}
-(id)initWithRootViewController:(UIViewController *)rootViewController{
    if (self =[super initWithRootViewController:rootViewController]) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    self.navigationControllerIMP = [[CCNavigationControllerIMP alloc] init];
    self.delegate = (id<UINavigationControllerDelegate>)self.navigationControllerIMP;//(id<UINavigationControllerDelegate>)[[CCTargetProxy alloc] initWithTarget:self.navigationControllerIMP];//如果导航栏其他地方被设置代理会导致该类功能失效
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        // 如果不是TTBaseViewController类，统一设置导航UI
        UIBarButtonItem *leftBackItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_black"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        viewController.navigationItem.leftBarButtonItems = @[leftBackItem];
            // 自动隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
        id<CCNavgationBarAppearnce> obj = (id<CCNavgationBarAppearnce>)viewController;
        if ([obj respondsToSelector:@selector(hiddenCCNavgationBar)]) {
            [self setNavigationBarHidden:obj.hiddenCCNavgationBar animated:NO];
        }
    }
    // 调用父类push实现方法,可以在对应ViewController再次覆盖leftBarButtonItem默认返回样式
    [super pushViewController:viewController animated:animated];
}
#pragma mark - ---- Addition ----
- (void)backAction
{
    [self.view endEditing:YES];//解决编辑状态黑影问题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self popViewControllerAnimated:YES];
    });
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
