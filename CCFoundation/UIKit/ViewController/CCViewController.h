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
@property (nonatomic, assign) BOOL hiddenCCNavgationBar;
@property (nonatomic, assign) BOOL sideslip;
@end

NS_ASSUME_NONNULL_END
