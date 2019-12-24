//
//  XJTempControl.m
//  XJMesh-iOS
//
//  Created by 王小胜 on 2019/12/23.
//  Copyright © 2019 王小胜. All rights reserved.
//

#import "XJTempControl.h"
#import "XJSliderView.h"
#import <RGUIKit/RGUIKit.h>
#import "Masonry.h"

@interface XJTempControl()<CommonSliderDelegate>
@property (nonatomic, strong) XJSliderView *tempSlider;
@property (nonatomic, strong) XJSliderView *lumSlider;
@end

@implementation XJTempControl
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
    self.lumSlider = [[XJSliderView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-30, 120)];
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
    
    [self.lumSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(120);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    NSArray *tempArr = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:136/255.0 blue:0/255.0 alpha:1.0].CGColor,
                        (__bridge id)[UIColor colorWithRed:255/255.0 green:243/255.0 blue:238/255.0 alpha:1.0].CGColor,
                        (__bridge id)[UIColor colorWithRed:186/255.0 green:204/255.0 blue:255/255.0 alpha:1.0].CGColor];
    NSArray *tempLocationArr = @[@0, @0.5, @1];
    self.tempSlider = [[XJSliderView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-30, 120)];
    self.tempSlider.colorArray = tempArr;
    self.tempSlider.locationArray = tempLocationArr;
    self.tempSlider.title = @"色温设置";
    self.tempSlider.unit = @"K";
    self.tempSlider.maximumValue = 7000;
    self.tempSlider.minimumValue = 1000;
    self.tempSlider.isShowValue = YES;
    self.tempSlider.type = Gradient;
    self.tempSlider.delegate = self;
    self.tempSlider.tag = 1;
    self.tempSlider.isRound = YES;
    self.tempSlider.backgroundColor = [UIColor rg_colorWithRGBHex:0xFFFFFF];
    [self addSubview:self.tempSlider];
    
    [self.tempSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self);
        make.height.mas_equalTo(120);
    }];
}

- (void)setPowerState:(BOOL)powerState {
    _powerState = powerState;
    self.lumSlider.isGrayState = !powerState;
    self.tempSlider.isGrayState = !powerState;
}

#pragma mark -- CommonSliderDelegate
- (void)sliderValue:(int)value tag:(NSInteger)tag {
    if (tag == 0) {
        NSLog(@"亮度:%d", value);
    }
    if (tag == 1) {
        NSLog(@"色温:%d", value);
    }
}

- (void)sliderValueColor:(UIColor *)color tag:(NSInteger)tag {
    if (tag == 1) {
        
    }
}

- (void)sliderColorPhaseEnded:(UIColor *)color tag:(NSInteger)tag {
    if (tag == 1) {
        NSLog(@"色温停下时颜色");
    }
}
@end
