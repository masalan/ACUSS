//
//  ViewByCityController.h
//  HHSD
//
//  Created by alain serge on 5/9/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"
#import "SWTableViewCell.h"


@interface AllCitiesListCell : SWTableViewCell
@property (nonatomic, strong) UIImageView *logoImageView,*maintenance;
@property (nonatomic, strong) UILabel *cityTypeIcone,*cityTypeLabel,*cityTypeName,*climateTypeIcone,*climateTypeLabel,*climateTypeName,*livingTypeIcone,*livingTypeLabel,*livingTypeName,*lineOne,*lineTwo,*lineTree;
@property (nonatomic, strong) UILabel *SchoolName,*totalStudent,*province,*cityName,*details;
@property (nonatomic, strong) Cities_data *mainMode;

- (void)setInfoWith:(Cities_data *)cities_data;


@end


@interface ViewByCityController : BaseViewController

@end
