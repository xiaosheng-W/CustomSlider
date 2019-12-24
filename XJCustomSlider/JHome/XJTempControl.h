//
//  XJTempControl.h
//  XJMesh-iOS
//
//  Created by 王小胜 on 2019/12/23.
//  Copyright © 2019 王小胜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XJLightView;
@interface XJTempControl : UIView
@property (nonatomic, strong) XJLightView *lightView;
@property (nonatomic, assign) BOOL powerState;
@end

NS_ASSUME_NONNULL_END
