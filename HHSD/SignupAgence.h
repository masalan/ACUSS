//
//  SignupAgence.h
//  HHSD
//
//  Created by alain serge on 5/10/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "ImagePickerBar.h"

@protocol AddImagesAgency <NSObject>

-(void)addImageViewDidTappedAtAddImage:(BOOL)addImage;

@end

@class agenceSignupImages;

@interface SignupAgence : BaseViewController <UITextViewDelegate,AddImagesAgency>
@property (nonatomic, strong) School_Details *mainDetails;
@property (nonatomic, copy) NSString *schoolId;
@property (nonatomic, strong) School_Details *SID;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *sendButton,*labelMainUniversity,*serviceTypeButton,*selectProvince,*selectCities,*typeTextView,*attributeTextView;
@property (nonatomic,strong)UILabel *placeHoldLabel,*TitlePlaceHoldLabel,*addressPlaceHoldLabel,*copiesAgencyValid,*copiesAgencyValidOne,*copiesAgencyValidTwo,*myUniversityLabel;

@property (nonatomic,strong)UITextView *textView,*thirdTextView,*levelTextView,*effectiveTextView,*phoneAgency,*emailAgency,*nationalityAgency;
@property (nonatomic,strong)UILabel *serviceContentLabel,*titleView,*nameSchool,*cityName,*details,*level,*levelDetails,*type,*typeDetails,*attributeLabel,*attributeDetails,*serviceTypeLabel,*effectiveLabel,*typeLabelUniversity;
@property (nonatomic,strong)UITextView *moreView;

@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)agenceSignupImages *addImageView;
@property (nonatomic,strong)ImagePickerBar *imagePickerBar;
@property (nonatomic, copy) NSString *postBarTitle;
@property (nonatomic, strong) NSDictionary *actionDict;

@end


@interface agenceSignupImages : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)id <AddImagesAgency> addImageDelegateMeet;
-(id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray;
@end

@interface AddSignupImageCellSchool : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIButton *deleteButton;

-(void)drawCellWithImage:(UIImage *)image;
-(void)addDeleteButton:(BOOL)show;

@end
