//
//  XJSliderView.h
//  XJMesh-iOS
//
//  Created by 王小胜 on 2019/12/19.
//  Copyright © 2019 王小胜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum :NSUInteger {
    Nomal,
    Gradient,
} SliderType;

@protocol CommonSliderDelegate <NSObject>
- (void)sliderValue:(int)value tag:(NSInteger)tag;
- (void)sliderValueColor:(UIColor *)color tag:(NSInteger)tag;
- (void)sliderColorPhaseEnded:(UIColor *)color tag:(NSInteger)tag;
@optional
//自定义值(1000-10000)之后slider原始值通过这个方法返回
- (void)originalSliderValue:(int)value tag:(NSInteger)tag;
@end

@interface XJSliderView : UIView
@property (nonatomic, weak) id<CommonSliderDelegate>delegate;
@property (nonatomic, assign) int minimumValue;
@property (nonatomic, assign) int maximumValue;
@property (nonatomic, assign) SliderType type;//渐变滑杆:Gradient 双色滑杆:Nomal
@property (nonatomic, assign) BOOL isShowValue;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *locationArray;
@property (nonatomic, strong) UIColor *minimumTrackTintColor;
@property (nonatomic, strong) UIColor *maximumTrackTintColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) int currentValue;
@property (nonatomic, assign) BOOL isRound;
@property (nonatomic, assign) BOOL isGrayState;
@end

NS_ASSUME_NONNULL_END
