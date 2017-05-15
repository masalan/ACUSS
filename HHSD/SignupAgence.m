//
//  SignupAgence.m
//  HHSD
//
//  Created by alain serge on 5/10/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SignupAgence.h"


#import "MBProgressHUD.h"
#import "ZYQAssetPickerController.h"
#import "EULARules.h"
#import "UIImage+fixOrientation.h"
#import "MyDatePicker.h"
#import "SZTextView.h"
#import "UITextView+Placeholder.h"


#define KTHEME_GREEN_LIGHT   [UIColor colorWithHex:@"#4d75d5"]
#define PLACE_HOLDER NSLocalizedString(@"L_PLACE_HOLDER",comment:"Meeting")
#define PLACE_TITLE_HOLDER NSLocalizedString(@"L_PLACE_TITLE_HOLDER",comment:"Meeting")
#define PLACE_ADDRESS_HOLDER NSLocalizedString(@"L_PLACE_ADDRESS_HOLDER",comment:"Meeting")
#define StartX 10
#define KborderWidth 1.5
#define Image_Size 50
#define ADD_IMAGE_DEFALUT_IMAGE [UIImage imageNamed:@"6000"]
#define SW2 SCREEN_WIDTH/2
#define SH2 SCREEN_HEIGHT/2

@interface SignupAgence() <UITextViewDelegate,MyPickerDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)ZYQAssetPickerController *picker;
@property (nonatomic, strong) School_Details *schoolDetail;
@property (nonatomic, strong) propertyService_topCategory_List *propertyService_topCategory_List;
@property (nonatomic, strong) propertyService_secondCategory_List *propertyService_secondCategory_List;
@property (nonatomic, strong) Type_Universities_List *type_university_List;
@property (nonatomic, strong) Attribute_Universities_List *attribute_university_List;


@property (nonatomic,strong)UITextView *nameAgency;

@property (nonatomic, strong) MyPicker *pickers;
@property (nonatomic, copy) NSString *topType_cateid;
@property (nonatomic, copy) NSString *secondType_cateid;
@property (nonatomic, copy) NSString *Type_cateid;
@property (nonatomic, copy) NSString *attribute_cateid;


@property (nonatomic, assign) CGFloat keyboardRect_height;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;


@end

@implementation SignupAgence
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _topType_cateid = @"";
        _secondType_cateid = @"";
        _Type_cateid = @"";
        _attribute_cateid = @"";
        
    }
    return self;
}

//ScrollView action
- (TPKeyboardAvoidingScrollView *)backScrollView
{
    if(!_backScrollView)
    {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:_backScrollView];
    }
    return _backScrollView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Profil agence";
    self.view.backgroundColor = KTHEME_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:KCOLOR_WHITE}];
    [self backScrollView];
    /*------------------------------------------------------------------------------------------------------------------------*/
    
    _sendButton = [UIButton createButtonwithFrame:CGRectMake(0, 0, KHEIGHT_40, KHEIGHT_40)
                                  backgroundColor:KCOLOR_CLEAR
                                       titleColor:KCOLOR_WHITE
                                             font:KSYSTEM_FONT_BOLD_(13)
                                            title:@"valid"];
    [_sendButton addTarget:self action:@selector(AddSchoolServer) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:_sendButton]];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-KNAVGATIONBAR_HEIGHT)];
    
    _scrollView.contentSize = CGSizeMake(KSCREEN_WIDTH, _scrollView.frame.size.height+SH2+100);
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.view addSubview:_scrollView];
    
    
    /*------------------------------------------------------------------------------------------------------------------------*/

    //Name Agency
    _nameAgency = [[UITextView alloc]initWithFrame:CGRectMake(KMARGIN_10,KMARGIN_5,KSCREEN_WIDTH-KMARGIN_25, KHEIGHT_40)];
    _nameAgency.backgroundColor = KCOLOR_WHITE;
    _nameAgency.font = KSYSTEM_FONT_18;
    _nameAgency.layer.borderColor = [KTHEME_COLOR colorWithAlphaComponent:0.5].CGColor;
    _nameAgency.layer.borderWidth = 1;
    _nameAgency.delegate = self;
    _nameAgency.placeholder = @"Your name agence ...";
    _nameAgency.placeholderColor = [UIColor lightGrayColor];
    _nameAgency.clearsOnInsertion =YES;
    [_scrollView addSubview:_nameAgency];
    
 
    
    //phone Agency
    _phoneAgency = [[UITextView alloc]initWithFrame:CGRectMake(KMARGIN_10,_nameAgency.bottom+5,KSCREEN_WIDTH-KMARGIN_25, KHEIGHT_40)];
    _phoneAgency.backgroundColor = KCOLOR_WHITE;
    _phoneAgency.font = KSYSTEM_FONT_18;
    _phoneAgency.layer.borderColor = [KTHEME_COLOR colorWithAlphaComponent:0.5].CGColor;
    _phoneAgency.layer.borderWidth = 1;
    _phoneAgency.delegate = self;
    _phoneAgency.placeholder = @"Your Phone agence ...";
    _phoneAgency.placeholderColor = [UIColor lightGrayColor];
    [_scrollView addSubview:_phoneAgency];
    
    
    //emailAgency
    _emailAgency = [[UITextView alloc]initWithFrame:CGRectMake(KMARGIN_10,_phoneAgency.bottom+5,KSCREEN_WIDTH-KMARGIN_25, KHEIGHT_40)];
    _emailAgency.backgroundColor = KCOLOR_WHITE;
    _emailAgency.font = KSYSTEM_FONT_18;
    _emailAgency.layer.borderColor = [KTHEME_COLOR colorWithAlphaComponent:0.5].CGColor;
    _emailAgency.layer.borderWidth = 1;
    _emailAgency.delegate = self;
    _emailAgency.placeholder = @"Your Email agence ...";
    _emailAgency.placeholderColor = [UIColor lightGrayColor];
    [_scrollView addSubview:_emailAgency];
    
    // label Main University
    _myUniversityLabel = [UILabel createLabelWithFrame:CGRectMake(0,_emailAgency.bottom+5,SCREEN_WIDTH, KHEIGHT_40)
                                   backgroundColor:KTHEME_COLOR
                                         textColor:KCOLOR_WHITE
                                              font:KICON_FONT_(15)
                                     textalignment:NSTextAlignmentCenter
                                              text:@"My main Univesity for schoolaship"];
    [_scrollView addSubview:_myUniversityLabel];

   
    
    
    if(!_labelMainUniversity)
    {
        _labelMainUniversity = [[UIButton alloc] initWithFrame:CGRectMake(KMARGIN_10, _myUniversityLabel.bottom+5,KSCREEN_WIDTH-KMARGIN_25, KHEIGHT_40)];
        _labelMainUniversity.layer.borderColor = KTHEME_COLOR.CGColor;
        _labelMainUniversity.layer.borderWidth = KborderWidth;
        _labelMainUniversity.backgroundColor =KCOLOR_WHITE;
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_labelMainUniversity.size.width  - 20, 12, 15, 15)
                                       backgroundColor:KCOLOR_CLEAR
                                             textColor:KCOLOR_Line_Color
                                                  font:KICON_FONT_(15)
                                         textalignment:NSTextAlignmentCenter
                                                  text:@"\U0000e684"];
        label.centerY = _labelMainUniversity.size.height/2;
        [_labelMainUniversity addSubview:label];
        
        _serviceTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KMARGIN_10, 10, _labelMainUniversity.size.width - 40, 30)];
        _serviceTypeLabel.text = @"Select Univesity for schoolaship";
        _serviceTypeLabel.textColor = KCOLOR_Line_Color;
        _serviceTypeLabel.font = kAutoFont_(12);
        _serviceTypeLabel.textAlignment =NSTextAlignmentCenter;
        _serviceTypeLabel.centerY = _labelMainUniversity.size.height/2;
        
        [_labelMainUniversity addTarget:self action:@selector(selectProvinceClick) forControlEvents:UIControlEventTouchUpInside];
        [_labelMainUniversity addSubview:_serviceTypeLabel];
        [_scrollView addSubview:_labelMainUniversity];
    }
    
    
   // copies Agency Valid
    _copiesAgencyValid = [UILabel createLabelWithFrame:CGRectMake(KMARGIN_10,_labelMainUniversity.bottom+10,KSCREEN_WIDTH-KMARGIN_25, KHEIGHT_40)
                                         backgroundColor:KTHEME_COLOR
                                               textColor:KCOLOR_WHITE
                                                    font:KICON_FONT_(12)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@"You will need to scan two documents in order to verify your identity. Don't crop, rotate, touch up, adjust colors, or alter the images in any way"];
    _copiesAgencyValid.numberOfLines = 3;
    [_scrollView addSubview:_copiesAgencyValid];
    
    
    _copiesAgencyValidOne = [UILabel createLabelWithFrame:CGRectMake(KMARGIN_20,_copiesAgencyValid.bottom+5,KSCREEN_WIDTH-KMARGIN_25, KHEIGHT_20)
                                       backgroundColor:KTHEME_COLOR
                                             textColor:KCOLOR_WHITE
                                                  font:KICON_FONT_(10)
                                         textalignment:NSTextAlignmentLeft
                                                  text:@"\U0000e60b Your current, valid government-issued photo ID"];
    [_scrollView addSubview:_copiesAgencyValidOne];
    
    _copiesAgencyValidTwo = [UILabel createLabelWithFrame:CGRectMake(KMARGIN_20,_copiesAgencyValidOne.bottom+2,KSCREEN_WIDTH-KMARGIN_25, KHEIGHT_30)
                                       backgroundColor:KTHEME_COLOR
                                             textColor:KCOLOR_WHITE
                                                  font:KICON_FONT_(10)
                                         textalignment:NSTextAlignmentLeft
                                                  text:@"\U0000e60b A recent billing statement: Your name and address must be visible."];
    _copiesAgencyValidTwo.numberOfLines = 3;
    [_scrollView addSubview:_copiesAgencyValidTwo];

    
    //Description
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(KMARGIN_10, _copiesAgencyValidTwo.bottom+KHEIGHT_20, KSCREEN_WIDTH-KMARGIN_20, KHEIGHT_80)];
    _textView.backgroundColor = KCOLOR_WHITE;
    _textView.font = KSYSTEM_FONT_13;
    _textView.layer.borderColor = [KTHEME_COLOR colorWithAlphaComponent:0.5].CGColor;
    
    _textView.layer.borderWidth = 1;
    _textView.delegate = self;
    _textView.placeholder = @"Your Description agence ...";
    _textView.placeholderColor = [UIColor lightGrayColor];
    [_scrollView addSubview:_textView];
    
    
    
    
    
    
    /*------------------------------------------------------------------------------------------------------------------------*/
    _imageArray = [NSMutableArray arrayWithObjects:ADD_IMAGE_DEFALUT_IMAGE, nil];
    /*------------------------------------------------------------------------------------------------------------------------*/
    
    _addImageView = [[agenceSignupImages alloc]initWithFrame:CGRectMake(KMARGIN_10,_textView.bottom+KMARGIN_10, KSCREEN_WIDTH-KMARGIN_20, 170)
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
    
    [_nameSchool becomeFirstResponder];
    //[EULARules checkEULARules];
    
}










-(CGRect)animation: (float) frame
{
    NSTimeInterval textAnimation = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:textAnimation];
    
    CGRect theframe = CGRectMake(0.0f, frame, SCREEN_WIDTH, self.view.frame.size.height);
    
    return theframe;
}
#pragma mark - notification


- (void)HiddenKeyboard
{
    CGFloat y = KNAVGATION_BAR_HEIGHT;
    self.view.frame = [self animation:y];
    [UIView commitAnimations];
    [_thirdTextView resignFirstResponder];
    [_typeTextView resignFirstResponder];
    [_levelTextView resignFirstResponder];
}

// Get Program cycle by School
- (void)selectProvinceClick
{
    [self HiddenKeyboard];
    DLog(@"Province");
    if([self.nameSchool isFirstResponder])
    {
        [self.view endEditing:YES];
        return ;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Schools/universities"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if(!_propertyService_topCategory_List)
            {
                _propertyService_topCategory_List = [propertyService_topCategory_List objectWithKeyValues:responseObject];
                
            }else
            {
                _propertyService_topCategory_List = nil;
                _propertyService_topCategory_List = [propertyService_topCategory_List objectWithKeyValues:responseObject];
            }
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            [_propertyService_topCategory_List.data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                propertyService_topCategory *tmp = obj;
                [tmpArray addObject:tmp.nameSchool];
            }];
            if(!_picker)
            {
                _pickers = [[MyPicker alloc] init];
                _pickers.delegate = self;
            }
            _pickers.pickerTag = 0;
            [_pickers showWithTitle:@"University select " nameArray:tmpArray];
            
        }
        else
        {
            [ProgressHUD showError:responseObject[@"message"]];
        }
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}



#pragma mark pcikerDelegate
-(void)myPicker:(MyPicker *)picker didPickRow:(NSInteger)row
{
}

- (void)myPicker:(MyPicker *)picker willPickRow:(NSInteger)row
{
    if(picker.pickerTag == 0)
    {
        propertyService_topCategory *tmp = _propertyService_topCategory_List.data[row];
        _serviceTypeLabel.text = tmp.nameSchool;
        _serviceTypeLabel.textColor = KCOLOR_BLUE;
        _topType_cateid = tmp.id;  // take id
        [picker close];
        
    }
    
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




-(void)AddSchoolServer
{
    if (_imageArray.count == 1) {
        [self MBShowError:@"add Your documents files"];
        return;
    }
    
    DLog(@"sava comment");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =  @"Please wait...";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.sess_id , @"sess_id");
    kSetDict(self.serviceTypeLabel.text, @"ag_nameSchool");
    kSetDict(self.topType_cateid, @"ag_s_id");
    kSetDict(self.nameAgency.text, @"ag_nameAgency");
    kSetDict(self.phoneAgency.text, @"ag_phoneAgency");
    kSetDict(self.emailAgency.text, @"ag_emailAgency");
    kSetDict(self.textView.text, @"ag_textView");
    
    NSLog(@"sess_id------>%@",self.sess_id );
    

    
    //thirdTextView
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"manager/add_agence"];

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
                                   fileName:@"photo" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
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
    _nameSchool.hidden = [textView.text length];
    _level.hidden = [textView.text length];
    _type.hidden = [textView.text length];
    
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




@end

@implementation agenceSignupImages

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
        [self.collectionView registerClass:[AddSignupImageCellSchool class] forCellWithReuseIdentifier:@"AddCell"];
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
    AddSignupImageCellSchool *cell = [[AddSignupImageCellSchool alloc]init];
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


@implementation AddSignupImageCellSchool

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


