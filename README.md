# ELPlusSliderControl

Runkeeper style segmented control with slider for two segments and an optional plus segment, written in ObjC and compatible with iOS7+

##Installation

Currently you can install it only manually by copying these two files to your project: ELPlusSliderControl.h and ELPlusSliderControl.m

### Usage

 In order to use ELPlusSliderControl, you can instantiate it programmatically. Once you have an instance, you can use the control properties to configure it.

Example:

```
    self.slider = [[ELPlusSliderControl alloc ] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 40)];
    self.slider.plusEnabled = YES;
    self.slider.cornerRadius = 20;
    self.slider.selectedPlusOpacity = 0.2;
    self.slider.segmentOneImage = [UIImage imageNamed:@"map_w"];
    self.slider.segmentOneImageSelected = [UIImage imageNamed:@"map_g"];
    self.slider.segmentTwoImage = [UIImage imageNamed:@"list_w"];
    self.slider.segmentTwoImageSelected = [UIImage imageNamed:@"list_g"];
    self.slider.segmentOneText = @"S1";
    self.slider.segmentTwoText = @"S2";
    self.slider.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:202.0/255.0 blue:98.0/255.0 alpha:1.0];
    self.slider.selectedBackgroundColor = [UIColor whiteColor];
    self.slider.textColor = [UIColor whiteColor];
    self.slider.selectedTextColor = [UIColor colorWithRed:145.0/255.0 green:202.0/255.0 blue:98.0/255.0 alpha:1.0];
    [self.slider addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.slider];


```

## Screenshots

![preview](https://raw.githubusercontent.com/endrelzr/ELPlusSliderControl/master/screenshots/ELPlusSliderControl_1.png)
![preview](https://raw.githubusercontent.com/endrelzr/ELPlusSliderControl/master/screenshots/ELPlusSliderControl_2.png)
![preview](https://raw.githubusercontent.com/endrelzr/ELPlusSliderControl/master/screenshots/ELPlusSliderControl_3.png)

## Contact

Endre Lázár

- https://github.com/endrelzr
- hello@endrelazar.com

## License

ELPlusSliderControl is available under the MIT license.

Copyright © 2015 Endre Lázár.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
