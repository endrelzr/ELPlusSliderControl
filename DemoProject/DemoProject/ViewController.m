//
//  ViewController.m
//  DemoProject
//
//  Created by Endre Lazar on 15/03/15.
//  Copyright (c) 2015 endrelzr. All rights reserved.
//

#import "ViewController.h"
#import "ELPlusSliderControl.h"

@interface ViewController ()

@property (strong) ELPlusSliderControl* slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.slider = [[ELPlusSliderControl alloc ] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 40)];
    self.slider.plusEnabled = YES;
    self.slider.tintColor = [UIColor greenColor];
    self.slider.backgroundColor = [UIColor whiteColor];
    self.slider.cornerRadius = 20;
    self.slider.plusSelectedOpacity = 0.1;
    self.slider.segmentOneImage = [UIImage imageNamed:@"map_g"];
    self.slider.segmentOneImageSelected = [UIImage imageNamed:@"map_w"];
    self.slider.segmentTwoImage = [UIImage imageNamed:@"list_g"];
    self.slider.segmentTwoImageSelected = [UIImage imageNamed:@"list_w"];
    [self.slider addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:self.slider];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Toggle plus" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    
}

-(void) sliderEvent: (ELPlusSliderControl*) control{
    NSLog(@"Slider position: %f", self.slider.sliderPositionFraction );
}

-(void) buttonPressed{
    [self.slider setPlusEnabled:!self.slider.plusEnabled animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end