//
//  ViewController.m
//  XJCustomSlider
//
//  Created by 王小胜 on 2019/12/24.
//  Copyright © 2019 王小胜. All rights reserved.
//

#import "ViewController.h"
#import "XJSliderView.h"
#import <RGUIKit/RGUIKit.h>

@interface ViewController ()<CommonSliderDelegate>
@property (nonatomic, strong) XJSliderView *rgbSlider;
@property (nonatomic, strong) XJSliderView *normaglSlider;
@property (nonatomic, strong) XJSliderView *gradientSlider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    NSArray *lumArr = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor,
                            (__bridge id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor];
    NSArray *lumlocationArr = @[@0, @1];
    self.rgbSlider = [[XJSliderView alloc]initWithFrame:CGRectMake(15, 100, self.view.bounds.size.width-30, 90)];
    self.rgbSlider.title = @"渐变滑杆";
    self.rgbSlider.maximumValue = 100;
    self.rgbSlider.minimumValue = 1;
    self.rgbSlider.isShowValue = YES;
    self.rgbSlider.colorArray = lumArr;
    self.rgbSlider.locationArray = lumlocationArr;
    self.rgbSlider.delegate = self;
    self.rgbSlider.tag = 0;
    self.rgbSlider.type = Gradient;
    self.rgbSlider.backgroundColor = [UIColor rg_colorWithRGBHex:0xFFFFFF];
    self.rgbSlider.isRound = YES;
    [self.view addSubview:self.rgbSlider];
    
    self.normaglSlider = [[XJSliderView alloc]initWithFrame:CGRectMake(15, 220, self.view.bounds.size.width-30, 90)];
    self.normaglSlider.title = @"普通滑杆";
    self.normaglSlider.maximumValue = 100;
    self.normaglSlider.minimumValue = 1;
    self.normaglSlider.isShowValue = YES;
    self.normaglSlider.minimumTrackTintColor = [UIColor rg_colorWithRGBHex:0x077DFF];
    self.normaglSlider.maximumTrackTintColor = [UIColor rg_colorWithRGBHex:0xD6D8DB];
    self.normaglSlider.delegate = self;
    self.normaglSlider.tag = 1;
    self.normaglSlider.type = Nomal;
    self.normaglSlider.backgroundColor = [UIColor rg_colorWithRGBHex:0xFFFFFF];
    self.normaglSlider.isRound = YES;
    [self.view addSubview:self.normaglSlider];

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
    self.gradientSlider = [[XJSliderView alloc]initWithFrame:CGRectMake(15, 340, self.view.bounds.size.width-30, 90)];
    self.gradientSlider.title = @"RGB滑杆";
    self.gradientSlider.maximumValue = 100;
    self.gradientSlider.minimumValue = 1;
    self.gradientSlider.isShowValue = NO;
    self.gradientSlider.colorArray = arr;
    self.gradientSlider.locationArray = locationArr;
    self.gradientSlider.delegate = self;
    self.gradientSlider.tag = 2;
    self.gradientSlider.type = Gradient;
    self.gradientSlider.backgroundColor = [UIColor rg_colorWithRGBHex:0xFFFFFF];
    self.gradientSlider.isRound = YES;
    [self.view addSubview:self.gradientSlider];
}

#pragma mark -- CommonSliderDelegate

- (void)sliderValue:(int)value tag:(NSInteger)tag {
    
}
- (void)sliderValueColor:(UIColor *)color tag:(NSInteger)tag {
    
}
- (void)sliderColorPhaseEnded:(UIColor *)color tag:(NSInteger)tag {
    
}

@end
