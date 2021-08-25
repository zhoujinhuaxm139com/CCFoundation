//
//  CCNavigationControllerIMP.m
//  CCFoundation
//
//  Created by zjh on 2021/7/21.
//  Copyright © 2021 zjh. All rights reserved.
//

#import "CCNavigationController.h"
#import "CCNavigationControllerIMP.h"
@interface CCNavigationController()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) CCNavigationControllerIMP *navigationControllerIMP;
@end

@implementation CCNavigationController
+ (void)initialize
{
    if(@available(iOS 11.0, *)){
        [[UITableView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    if(@available(iOS 11.0, *)){
        navBar.prefersLargeTitles = NO;
        [navBar setLargeTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25],NSForegroundColorAttributeName:UIColor.whiteColor}];
    }
    [navBar setTranslucent:NO];
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
-(id)init{
    if (self = [super init]){
        [self setUp];
    }
    return self;
}
-(void)setUp{
    self.navigationControllerIMP = [[CCNavigationControllerIMP alloc] init];
    self.delegate = (id<UINavigationControllerDelegate>)self.navigationControllerIMP;
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
        UIBarButtonItem *leftBackItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_black"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        viewController.navigationItem.leftBarButtonItems = @[leftBackItem];
        viewController.hidesBottomBarWhenPushed = YES;
            // 自动隐藏TabBar
    }
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
@end
