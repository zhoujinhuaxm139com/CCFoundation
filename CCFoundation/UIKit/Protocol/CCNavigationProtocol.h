//
//  CCNavigationProtocol.h
//  CCFoundation
//
//  Created by zjh on 2021/7/21.
//  Copyright © 2021 zjh. All rights reserved.
//

#ifndef CCNavigationProtocol_h
#define CCNavigationProtocol_h
#import <UIKit/UIKit.h>
@protocol CCNavgationBarAppearnce <NSObject>
@property (nonatomic, assign) BOOL CCHiddenNavgationBar;
@property (nonatomic, assign) BOOL CCSideslip;
@property (nonatomic, strong) UIColor * _Nullable CCBarTintColor;
@property (nonatomic, strong) UIColor * _Nullable CCTintColor;
@end
@protocol CCNavgationAnimation <NSObject>
-(nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForOperationPush;
-(nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForOperationPop;
@end

#endif /* CCNavigationProtocol_h */
