//
//  ViewController.m
//  KSWaveAnimation
//
//  Created by 康帅 on 17/2/21.
//  Copyright © 2017年 Bujiaxinxi. All rights reserved.
//

#import "ViewController.h"
#import "KSWaveAnimationV.h"
@interface ViewController ()
@property(nonatomic,strong)KSWaveAnimationV *waveAnimationV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.waveAnimationV=({
        KSWaveAnimationV *view=[[KSWaveAnimationV alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
        view;
    });
    [self.view addSubview:self.waveAnimationV];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
