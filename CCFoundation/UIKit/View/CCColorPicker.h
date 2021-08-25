//
//  CCColorPicker.h
//  CCUIKit
//
//  Created by zjh on 2021/8/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    CCColorPickerTypeCircle,
    CCColorPickerTypeRing
}CCColorPickerType;
@interface CCColorPicker : UIControl
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) CGFloat ringWidth;//CCColorPickerTypeCircle  无用
-(id)initWithType:(CCColorPickerType)type;
@end

NS_ASSUME_NONNULL_END
