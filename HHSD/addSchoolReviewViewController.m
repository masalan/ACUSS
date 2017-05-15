//
//  addSchoolReviewViewController.m
//  HHSD
//
//  Created by alain serge on 4/6/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "addSchoolReviewViewController.h"

#import "MBProgressHUD.h"
#import "ZYQAssetPickerController.h"
#import "EULARules.h"
#import "UIImage+fixOrientation.h"


#define KTHEME_GREEN_LIGHT   [UIColor colorWithHex:@"#4d75d5"]
#define PLACE_HOLDER NSLocalizedString(@"L_PLACE_HOLDER",comment:"Meeting")
#define PLACE_TITLE_HOLDER NSLocalizedString(@"L_PLACE_TITLE_HOLDER",comment:"Meeting")
#define PLACE_ADDRESS_HOLDER NSLocalizedString(@"L_PLACE_ADDRESS_HOLDER",comment:"Meeting")

#define Image_Size 50
#define ADD_IMAGE_DEFALUT_IMAGE [UIImage imageNamed:@"add"]

@interface addSchoolReviewViewController() <ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)ZYQAssetPickerController *picker;
@property (nonatomic, strong) School_Details *schoolDetail;


@end

@implementation addSchoolReviewViewController
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        //_tweetType = CommonTweet;
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"add review";
    self.view.backgroundColor = KTHEME_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:KCOLOR_WHITE}];
    /*------------------------------------------------------------------------------------------------------------------------*/
    
    
    
    _sendButton = [UIButton createButtonwithFrame:CGRectMake(0, 0, KHEIGHT_40, KHEIGHT_40)
                                  backgroundColor:KCOLOR_CLEAR
                                       titleColor:KCOLOR_WHITE
                                             font:KSYSTEM_FONT_BOLD_(13)
                                            title:@"add"];
    [_sendButton addTarget:self action:@selector(onSendButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:_sendButton]];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-KNAVGATIONBAR_HEIGHT)];
    _scrollView.contentSize = CGSizeMake(KSCREEN_WIDTH, _scrollView.frame.size.height+1);
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_scrollView];
    
    
    /*------------------------------------------------------------------------------------------------------------------------*/
    
   //Title

    
    _titleView = [UILabel createLabelWithFrame:CGRectMake(KMARGIN_10, KMARGIN_10, KSCREEN_WIDTH-KMARGIN_20, KHEIGHT_50)
                                    backgroundColor:KTHEME_COLOR
                                          textColor:KCOLOR_WHITE
                                               font:KSYSTEM_FONT_13
                                      textalignment:NSTextAlignmentCenter
                                               text:@""];
     _titleView.layer.borderColor = [KCOLOR_WHITE colorWithAlphaComponent:0.5].CGColor;
     _titleView.layer.borderWidth = 1;
     _titleView.numberOfLines = 3;
    
     [_scrollView addSubview:_titleView];
    
    // moreView
    _moreView = [[UITextView alloc]initWithFrame:CGRectMake(KMARGIN_10, _titleView.bottom+5, KSCREEN_WIDTH-KMARGIN_20, KHEIGHT_40)];
    _moreView.backgroundColor = KCOLOR_WHITE;
    _moreView.font = KSYSTEM_FONT_15;
    _moreView.layer.borderColor = [KTHEME_COLOR colorWithAlphaComponent:0.5].CGColor;
    _moreView.layer.borderWidth = 1;
    _moreView.delegate = self;
    // [_scrollView addSubview:_moreView];
    
    //Description
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(KMARGIN_10, _titleView.bottom+KHEIGHT_50, KSCREEN_WIDTH-KMARGIN_20, KHEIGHT_100)];
    _textView.backgroundColor = KCOLOR_WHITE;
    _textView.font = KSYSTEM_FONT_15;
    _textView.layer.borderColor = [KTHEME_COLOR colorWithAlphaComponent:0.5].CGColor;
    
    _textView.layer.borderWidth = 1;
    _textView.delegate = self;
      [_scrollView addSubview:_textView];
    
    
    
    
    
    
    /*------------------------------------------------------------------------------------------------------------------------*/
    _imageArray = [NSMutableArray arrayWithObjects:ADD_IMAGE_DEFALUT_IMAGE, nil];
    /*------------------------------------------------------------------------------------------------------------------------*/
    
    _addImageView = [[ClubMainAddImageViewMeet alloc]initWithFrame:CGRectMake(KMARGIN_10,_textView.bottom+KMARGIN_10, KSCREEN_WIDTH-KMARGIN_20, 170)
                                                    withImageArray:_imageArray];
    _addImageView.addImageDelegateMeet = self;
    [_scrollView addSubview:_addImageView];
    
    // Image en dessous
    /*------------------------------------------------------------------------------------------------------------------------*/
    
    _imagePickerBar = [[ImagePickerBar alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-KNAVGATIONBAR_HEIGHT-KHEIGHT_40, KSCREEN_WIDTH, KHEIGHT_40)];
    [_imagePickerBar.imagePickerButton addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    [_imagePickerBar.cameraPickerButton addTarget:self action:@selector(cameraPickerButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imagePickerBar];
    /*------------------------------------------------------------------------------------------------------------------------*/
    
    [_titleView becomeFirstResponder];
    //[EULARules checkEULARules];
    [self getAllData];

}


#pragma mark - otification
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - notification
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [_imagePickerBar setFrame:CGRectMake(0, KSCREEN_HEIGHT-keyboardRect.size.height-KHEIGHT_40-KNAVGATIONBAR_HEIGHT, KSCREEN_WIDTH, KHEIGHT_40)];
                     }
                     completion:^(BOOL finished) {}];
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_imagePickerBar setFrame:CGRectMake(0, KSCREEN_HEIGHT-KNAVGATIONBAR_HEIGHT-KHEIGHT_40, KSCREEN_WIDTH, KHEIGHT_40)];
                     }
                     completion:^(BOOL finished) {}];
}




-(void)onSendButtonTapped
{
    
    DLog(@"sava comment");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =  @"Please wait...";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
     kSetDict(self.textView.text, @"contents");   // description
     kSetDict(self.titleView.text, @"title");  // school name
     kSetDict(self.SID, @"s_id");  // School ID

    
    kSetDict(self.sess_id, @"sess_id");
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Students/add_review_school"];
    
    //imageData
    NSMutableArray *dataArray = [NSMutableArray array];
    
    if ([_imageArray count]>1) {
        for (NSInteger i = 0; i<[_imageArray count]-1; i++) {
            NSData* data = UIImageJPEGRepresentation(_imageArray[i],0.3);
            [dataArray addObject:data];
        }
    }
    [[NetWork shareInstance] netWorkWithUrl:string
                                     params:params dataArray:dataArray
                                   fileName:@"image" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       if([[responseObject objectForKey:@"code"] isEqual:@200])
                                       {
                                           
                                           
                                           [hud hideAnimated:YES afterDelay:0.3];
                                           [self MBShowSuccess:@"Succes"];
                                           [self.navigationController popViewControllerAnimated:YES];
                                           
                                       }
                                       else
                                       {
                                           [self MBShowError:responseObject[@"message"]];
                                           [hud hideAnimated:YES afterDelay:1.0];
                                           
                                       }
                                   } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                                       // code
                                        [hud hideAnimated:YES afterDelay:0.3];
                                   }];
    
    
    
}


-(void)leave
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView;
{
    _placeHoldLabel.hidden = [textView.text length];
    _TitlePlaceHoldLabel.hidden = [textView.text length];
    _addressPlaceHoldLabel.hidden = [textView.text length];
    
}

#pragma mark - pickImage

-(void)addImageViewDidTappedAtAddImage:(BOOL)addImage
{
    if (addImage) {
        [self pickImage];
    }
}

#pragma mark - cameraPickerButtonTapped
-(void)cameraPickerButtonTapped
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.navigationBar.barTintColor = [UIColor whiteColor];
        [controller.navigationBar setTranslucent:NO];
        controller.delegate = self;
        controller.allowsEditing = NO;//设置不可编辑
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;            // Take a photo
        [self.navigationController presentViewController:controller
                                                animated:YES
                                              completion:^(void){}];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            image = [image fixOrientation];
            NSData *data = UIImageJPEGRepresentation(image , 0.5);
            UIImage *result = [UIImage imageWithData:data];
            [_imageArray insertObject:result atIndex:0];
            if ([_imageArray count]>10) {
                [_imageArray removeObjectsInRange:NSMakeRange(9, [_imageArray count]-10)];
            }
            _addImageView.imageArray = _imageArray ;
            [_addImageView.collectionView reloadData];
        });
    }];
}

-(void)pickImage
{
    _picker = [[ZYQAssetPickerController alloc] init];
    [_picker.navigationBar setBarTintColor:KTHEME_COLOR];
    [_picker.navigationBar setTranslucent:NO];
    _picker.navigationBar.tintColor = KCOLOR_WHITE;
    _picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:KCOLOR_WHITE,NSFontAttributeName:KSYSTEM_FONT_BOLD_(18)};
    
    _picker.maximumNumberOfSelection = 9;
    _picker.assetsFilter = [ALAssetsFilter allPhotos];
    _picker.showEmptyGroups=YES;
    _picker.delegate=self;
    _picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    [self presentViewController:_picker animated:YES completion:NULL];
}


#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset=assets[i];
        UIImage *img = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage
                                           scale:asset.defaultRepresentation.scale
                                     orientation:UIImageOrientationUp];
        [_imageArray insertObject:img atIndex:[_imageArray count]-1];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_imageArray count]>10) {
            [_imageArray removeObjectsInRange:NSMakeRange(9, [_imageArray count]-10)];
        }
        _addImageView.imageArray = _imageArray;
        [_addImageView.collectionView reloadData];
    });
}



-(void)backgroundTap
{
    [self.view endEditing:YES];
}













#pragma mark
#pragma mark ----- getAllData -----

// School details
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    kSetDict(self.SID, @"id");  // School ID
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/detail"];//server
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.schoolDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _schoolDetail = [School_Details objectWithKeyValues:responseObject[@"data"]];
            
            if (_schoolDetail.nameSchool) {
                _titleView.text = _schoolDetail.nameSchool;
            }else{
                _titleView.text = @"";
            }
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}


@end

@implementation ClubMainAddImageViewMeet

-(id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = [NSMutableArray arrayWithArray:imageArray];
        
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout createCollectionViewFlowLayoutWithScrollDirection:UICollectionViewScrollDirectionVertical
                                                                                                                      minimumY:KMARGIN_10
                                                                                                                      minimumX:KMARGIN_10];
        _collectionView = [UICollectionView createCollectionViewWithFrame:self.bounds
                                                     collectionViewLayout:flowLayout
                                                          backgroundColor:KTHEME_COLOR
                                                                 delegate:self
                                                               dataSource:self];
        [self.collectionView registerClass:[AddImageCellNews class] forCellWithReuseIdentifier:@"AddCell"];
        [self addSubview:_collectionView];
    }
    return self;
}
#pragma mark - collectionView delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_imageArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddImageCellNews *cell = [[AddImageCellNews alloc]init];
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AddCell" forIndexPath:indexPath];
    [cell drawCellWithImage:_imageArray[indexPath.row]];
    if (indexPath.row != [_imageArray count]-1) {
        [cell addDeleteButton:YES];
        cell.deleteButton.tag = indexPath.row;
        [cell.deleteButton addTarget:self action:@selector(onDeleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell addDeleteButton:NO];
    }
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, KMARGIN_10);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(Image_Size,Image_Size);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self endEditing:YES];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [_imageArray count]-1) {
        if (_addImageDelegateMeet && [_addImageDelegateMeet respondsToSelector:@selector(addImageViewDidTappedAtAddImage:)]) {
            [_addImageDelegateMeet  addImageViewDidTappedAtAddImage:YES];
        }
    }
}
-(void)onDeleteButtonTapped:(UIButton *)sender
{
    [_imageArray removeObjectAtIndex:sender.tag];
    [_collectionView reloadData];
}
-(void)reloadView
{
    [_collectionView reloadData];
}









@end


@implementation AddImageCellNews

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

// cadre des images
-(void)drawCellWithImage:(UIImage *)image
{
    if (!_imageView) {
        _imageView = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, kBOUNDS_WIDTH, KBOUNDS_HEIGHT)
                                           backgroundColor:KCOLOR_CLEAR
                                                     image:image];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
    }else{
        _imageView.image = image;
    }
}

// button delete sur la photo
-(void)addDeleteButton:(BOOL)show
{
    if (show) {
        _deleteButton = [UIButton createButtonwithFrame:CGRectMake(0, 0, KHEIGHT_(20), KHEIGHT_(20))
                                        backgroundColor:KCOLOR_CLEAR
                                                  image:[UIImage imageNamed:@"delete"]];
        [self addSubview:_deleteButton];
    }else{
        [_deleteButton removeFromSuperview];
    }
    
}



@end


