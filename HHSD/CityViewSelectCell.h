//
//  CityViewSelectCell.h
//  HHSD
//
//  Created by alain serge on 4/5/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewSelectCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
+ (CGFloat)getWidth;
+ (CGFloat)getHeight;
@end
