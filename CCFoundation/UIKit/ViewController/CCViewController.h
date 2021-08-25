//
//  CCViewController.h
//  CCFoundation
//
//  Created by zjh on 2021/7/21.
//  Copyright © 2021 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCNavigationProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCViewController : UIViewController<CCNavgationBarAppearnce>
@property (nonatomic, assign) BOOL CCHiddenNavgationBar;
@property (nonatomic, assign) BOOL CCSideslip;
@property (nonatomic, strong) UIColor *CCBarTintColor;
@property (nonatomic, strong) UIColor *CCTintColor;
@end

NS_ASSUME_NONNULL_END
