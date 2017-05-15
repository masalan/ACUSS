//
//  addSchoolReviewViewController.h
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

@class ClubMainAddImageViewMeet;

@interface addSchoolReviewViewController : BaseViewController <UITextViewDelegate,AddImageViewDelegatedm>
@property (nonatomic, strong) School_Details *mainDetails;
@property (nonatomic, copy) NSString *schoolId;
@property (nonatomic, strong) School_Details *SID;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *sendButton;
@property (nonatomic,strong)UILabel *placeHoldLabel;
@property (nonatomic,strong)UILabel *TitlePlaceHoldLabel;
@property (nonatomic,strong)UILabel *addressPlaceHoldLabel;

@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UILabel *titleView;
@property (nonatomic,strong)UITextView *moreView;

@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)ClubMainAddImageViewMeet *addImageView;
@property (nonatomic,strong)ImagePickerBar *imagePickerBar;
@property (nonatomic, copy) NSString *postBarTitle;
@property (nonatomic, strong) NSDictionary *actionDict;

@end


@interface ClubMainAddImageViewMeet : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)id <AddImageViewDelegatedm> addImageDelegateMeet;
-(id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray;
@end

@interface AddImageCellNews : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIButton *deleteButton;

-(void)drawCellWithImage:(UIImage *)image;
-(void)addDeleteButton:(BOOL)show;

@end
