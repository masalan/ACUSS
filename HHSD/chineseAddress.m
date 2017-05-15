//
//  chineseAddress.m
//  HHSD
//
//  Created by alain serge on 3/25/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "chineseAddress.h"
#import "CNCityPickerView.h"
#import "CNCityPickerView.h"

@interface chineseAddress ()

@end

@implementation chineseAddress

- (void)viewDidLoad {
    [super viewDidLoad];

    
        // 使用代码的方式添加也行
        CGRect pickerViewFrame = CGRectMake(0,80, self.view.bounds.size.width, 180);
    
        // 1、创建
        CNCityPickerView *pickerView = [CNCityPickerView createPickerViewWithFrame:pickerViewFrame valueChangedCallback:^(NSString *province, NSString *city, NSString *area) {
    
            __displayLabel.text = [NSString stringWithFormat:@"%@  %@  %@", province, city, area];
    
        }];
    
        // 2、可选设置的属性
        pickerView.textAttributes = @{NSForegroundColorAttributeName : [UIColor redColor],
                                      NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0f]
                                      };
        pickerView.rowHeight = 30.0f;
    
        // 3、添加到指定视图
        [self.view addSubview:pickerView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
