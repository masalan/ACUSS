//
//  addSchoolByAdmin.h
//  HHSD
//
//  Created by alain serge on 4/6/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//


#import "BaseViewController.h"
#import "ImagePickerBar.h"

@protocol AddImageViewDelegatedm <NSObject>

-(void)addImageViewDidTappedAtAddImage:(BOOL)addImage;

@end

@class clubAddSchoolImages;

@interface addSchoolByAdmin : BaseViewController <UITextViewDelegate,AddImageViewDelegatedm>
@property (nonatomic, strong) School_Details *mainDetails;
@property (nonatomic, copy) NSString *schoolId;
@property (nonatomic, strong) School_Details *SID;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *sendButton,*serviceTypeButton,*selectProvince,*selectCities,*typeTextView,*attributeTextView;
@property (nonatomic,strong)UILabel *placeHoldLabel;
@property (nonatomic,strong)UILabel *TitlePlaceHoldLabel;
@property (nonatomic,strong)UILabel *addressPlaceHoldLabel;

@property (nonatomic,strong)UITextView *textView,*thirdTextView,*levelTextView,*effectiveTextView;
@property (nonatomic,strong)UILabel *serviceContentLabel,*titleView,*nameSchool,*cityName,*details,*level,*levelDetails,*type,*typeDetails,*attributeLabel,*attributeDetails,*serviceTypeLabel,*effectiveLabel,*typeLabelUniversity;
@property (nonatomic,strong)UITextView *moreView;

@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)clubAddSchoolImages *addImageView;
@property (nonatomic,strong)ImagePickerBar *imagePickerBar;
@property (nonatomic, copy) NSString *postBarTitle;
@property (nonatomic, strong) NSDictionary *actionDict;

@end


@interface clubAddSchoolImages : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)id <AddImageViewDelegatedm> addImageDelegateMeet;
-(id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray;
@end

@interface AddImageCellSchool : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIButton *deleteButton;

-(void)drawCellWithImage:(UIImage *)image;
-(void)addDeleteButton:(BOOL)show;

@end
