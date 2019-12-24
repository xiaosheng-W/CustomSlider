//
//  XJRGBControl.m
//  XJMesh-iOS
//
//  Created by 王小胜 on 2019/12/23.
//  Copyright © 2019 王小胜. All rights reserved.
//

#import "XJRGBControl.h"
#import "XJSliderView.h"
#import <RGUIKit/RGUIKit.h>
#import "Masonry.h"

@interface XJRGBControl()<CommonSliderDelegate>
@property (nonatomic, strong) XJSliderView *rgbSlider;
@property (nonatomic, strong) XJSliderView *saturationSlider;
@property (nonatomic, strong) XJSliderView *lumSlider;
@end

@implementation XJRGBControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSlider];
    }
    return self;
}

- (void)configSlider {
    NSArray *lumArr = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor,
                            (__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor];
    NSArray *lumlocationArr = @[@0, @1];
    self.lumSlider = [[XJSliderView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-30, 90)];
    self.lumSlider.title = @"亮度设置";
    self.lumSlider.maximumValue = 100;
    self.lumSlider.minimumValue = 1;
    self.lumSlider.isShowValue = YES;
    self.lumSlider.colorArray = lumArr;
    self.lumSlider.locationArray = lumlocationArr;
    self.lumSlider.delegate = self;
    self.lumSlider.tag = 0;
    self.lumSlider.type = Gradient;
    self.lumSlider.backgroundColor = [UIColor rg_colorWithRGBHex:0xFFFFFF];
    self.lumSlider.isRound = YES;
    [self addSubview:self.lumSlider];
    
    self.saturationSlider = [[XJSliderView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-30, 90)];
    self.saturationSlider.title = @"饱和度设置";
    self.saturationSlider.maximumValue = 100;
    self.saturationSlider.minimumValue = 1;
    self.saturationSlider.isShowValue = YES;
    self.saturationSlider.minimumTrackTintColor = [UIColor rg_colorWithRGBHex:0x077DFF];
    self.saturationSlider.maximumTrackTintColor = [UIColor rg_colorWithRGBHex:0xD6D8DB];
    self.saturationSlider.delegate = self;
    self.saturationSlider.tag = 1;
    self.saturationSlider.type = Nomal;
    self.saturationSlider.backgroundColor = [UIColor rg_colorWithRGBHex:0xFFFFFF];
    self.saturationSlider.isRound = YES;
    [self addSubview:self.saturationSlider];

    NSArray *arr = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:33/255.0 blue:33/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:255/255.0 green:33/255.0 blue:247/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:90/255.0 green:33/255.0 blue:255/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:7/255.0 green:125/255.0 blue:255/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:33/255.0 green:255/255.0 blue:242/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:33/255.0 green:255/255.0 blue:59/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:255/255.0 green:216/255.0 blue:33/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:255/255.0 green:127/255.0 blue:33/255.0 alpha:1.0].CGColor,
    (__bridge id)[UIColor colorWithRed:255/255.0 green:33/255.0 blue:33/255.0 alpha:1.0].CGColor];
    NSArray *locationArr = @[@0, @0.1, @0.3, @0.4, @0.5, @0.6, @0.8, @0.9, @1];
    self.rgbSlider = [[XJSliderView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-30, 90)];
    self.rgbSlider.title = @"彩色设置";
    self.rgbSlider.maximumValue = 100;
    self.rgbSlider.minimumValue = 1;
    self.rgbSlider.isShowValue = NO;
    self.rgbSlider.colorArray = arr;
    self.rgbSlider.locationArray = locationArr;
    self.rgbSlider.delegate = self;
    self.rgbSlider.tag = 2;
    self.rgbSlider.type = Gradient;
    self.rgbSlider.backgroundColor = [UIColor rg_colorWithRGBHex:0xFFFFFF];
    self.rgbSlider.isRound = YES;
    [self addSubview:self.rgbSlider];
    
    [self.lumSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-10);
        make.height.mas_equalTo(90);
    }];

    [self.saturationSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.lumSlider.mas_top).offset(-10);
        make.height.mas_equalTo(90);
    }];

    [self.rgbSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.saturationSlider.mas_top).offset(-10);
        make.height.mas_equalTo(90);
    }];
}

- (void)setPowerState:(BOOL)powerState {
    _powerState = powerState;
    self.rgbSlider.isGrayState = !powerState;
    self.lumSlider.isGrayState = !powerState;
    self.saturationSlider.isGrayState = !powerState;
}

#pragma mark --CommonSliderDelegate
- (void)sliderValue:(int)value tag:(NSInteger)tag {
    if (tag == 0) {
        NSLog(@"亮度:%d", value);
    }
    if (tag == 1) {
        NSLog(@"饱和度:%d", value);
    }
}

- (void)sliderValueColor:(UIColor *)color tag:(NSInteger)tag {
    if (tag == 2) {
        
    }
}

- (void)sliderColorPhaseEnded:(UIColor *)color tag:(NSInteger)tag {
    if (tag == 2) {
        
    }
}
@end
