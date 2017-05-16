//
//  editApplyForm.m
//  HHSD
//
//  Created by alain serge on 4/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "editApplyForm.h"
#import "SearchTableViewCell.h"
#import "DescriptionTableViewCell.h"
#import "BtnView.h"

#import "ZYQAssetPickerController.h"
#import "UIImage+fixOrientation.h"
#define ADD_IAMGE [UIImage imageNamed:@"add"]

#define D 40

@interface editApplyForm ()<UITableViewDataSource,UITableViewDelegate,
UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,
UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate>
{
    BOOL isEdit;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZYQAssetPickerController *picker;
@property (nonatomic, strong) UITapGestureRecognizer *tapGes;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, retain) UIButton *loginUser,*validBtn;
@end

@implementation editApplyForm
@synthesize params;


- (UIScrollView *)backScrollView
{
    if(!_backScrollView)
    {
        _backScrollView = [UIScrollView createScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
                                                  backgroundColor:KCOLOR_WHITE
                                                      contentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+20)];
        if (iPhone4) {
            _backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+300);
        }
        _backScrollView.scrollEnabled = YES;
        _backScrollView.delegate = self;
        
        [self.view addSubview:_backScrollView];
    }
    return _backScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self validBtn];
    self.title = @"edit form";
    [self tableView];
    [self initUI];


    UIButton *rightBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 80, 30)
                                         backgroundColor:KCOLOR_Clear
                                              titleColor:[PublicMethod getNaviBarItemColor]
                                                    font:KICON_FONT_(15)
                                                   title:@"\U0000e619"];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self
                 action:@selector(editApplyForm)
       forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithCustomView:rightBtn];
    
}

- (void)initUI
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.header = header;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_isMyFabu) {
        if (!isEdit) {
            params = [[NSMutableDictionary alloc] init];
            _imageArray = [NSMutableArray arrayWithObjects:ADD_IAMGE, nil];
        }
    }
    else
    {
        if (!isEdit) {
            _imageArray = [NSMutableArray arrayWithArray:params[@"photo"]];
            [_imageArray addObject:ADD_IAMGE];
        }
    }
    
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddenKeyBoard];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hiddenKeyBoard];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 7;
            break;
            
        case 1:
            return 4;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    static NSString *cellIden = @"PhotoCell";
                    
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    for (UIButton *imgV in [cell.contentView subviews]) {
                        [imgV removeFromSuperview];
                    }
                    
                    [_imageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        CGFloat spec = (SCREEN_WIDTH-75*3)/4;
                        if (idx<3) {
                            UIImage *image = [[UIImage alloc] init];
                            if ([obj isKindOfClass:[NSString class]]) {
                                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                                [NSURL URLWithString:
                                                                 [NSString stringWithFormat:@"%@",obj]]]];
                            }
                            else
                            {
                                image = obj;
                            }
                            UIButton *img = [UIButton createButtonwithFrame:
                                             CGRectMake(spec*(idx+1)+75*idx, 14, 75, 75)
                                                            backgroundColor:KCOLOR_Clear
                                                                      image:image];
                            img.tag = idx;
                            [cell.contentView addSubview:img];
                            
                            if (idx == _imageArray.count-1) {
                                [img addTarget:self
                                        action:@selector(addImageViewDidTappedAtAddImage)
                              forControlEvents:UIControlEventTouchUpInside];
                            }
                            else
                            {
                                UIButton *deleteBtn = [UIButton createButtonwithFrame:CGRectMake(img.width-20, 0, 20, 20)
                                                                      backgroundColor:KCOLOR_Clear
                                                                           titleColor:KCOLOR_GREEN
                                                                                 font:KICON_FONT_(18)
                                                                                title:@"\U0000e680"];
                                deleteBtn.tag = idx;
                                
                                [img addSubview:deleteBtn];
                                
                                
                            }
                        }
                        else if (idx <6)
                        {
                            UIImage *image = [[UIImage alloc] init];
                            if ([obj isKindOfClass:[NSString class]]) {
                                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                                [NSURL URLWithString:
                                                                 [NSString stringWithFormat:@"%@",obj]]]];
                            }
                            else
                            {
                                image = obj;
                            }
                            UIButton *img = [UIButton createButtonwithFrame:
                                             CGRectMake(spec*(idx-3+1)+75*(idx-3), 14*2+75, 75, 75)
                                                            backgroundColor:KCOLOR_Clear
                                                                      image:image];
                            img.tag = idx;
                            [cell.contentView addSubview:img];
                            if (idx == _imageArray.count-1) {
                                [img addTarget:self
                                        action:@selector(addImageViewDidTappedAtAddImage)
                              forControlEvents:UIControlEventTouchUpInside];
                            }
                            else
                            {
                                UIButton *deleteBtn = [UIButton createButtonwithFrame:CGRectMake(img.width-20, 0, 20, 20)
                                                                      backgroundColor:KCOLOR_Clear
                                                                           titleColor:KCOLOR_GREEN
                                                                                 font:KICON_FONT_(18)
                                                                                title:@"\U0000e680"];
                                deleteBtn.tag = idx;
                                [img addSubview:deleteBtn];
                            }
                        }
                    }];
                    return cell;
                }
                    break;
                    
                case 1:
                {
                    
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"student Name";
                    cell.textField.placeholder = @"Student fullName";
                    cell.textField.delegate = self;
                    cell.textField.tag = 100;
                    cell.textField.text = params[@"studentName"];
                    
                    return cell;
                }
                    break;
                    
                case 2:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"student Birthday";
                    cell.textField.placeholder = @"student Birthday";
                    cell.textField.delegate = self;
                    cell.textField.tag = 101;
                    cell.textField.text = params[@"studentBirthday"];
                    
                    return cell;
                }
                    break;
                    
                case 3:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"MotherTongue";
                    cell.textField.placeholder = @"student Mother Tongue";
                    cell.textField.delegate = self;
                    cell.textField.tag = 102;
                    cell.textField.text = params[@"studentMotherTongue"];
                    
                    return cell;
                }
                    break;
                    
                case 4:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"student Phone";
                    cell.textField.placeholder = @"student Mobile Phone";
                    cell.textField.delegate = self;
                    cell.textField.tag = 103;
                    cell.textField.text = params[@"studentMobilePhone"];
                    
                    return cell;
                }
                    break;
                    
                case 5:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"Actual Cycle";
                    cell.textField.placeholder = @"student Actual Cycle";
                    cell.textField.delegate = self;
                    cell.textField.tag = 104;
                    cell.textField.text = params[@"studentActualCycle"];
                    
                    return cell;
                }
                    break;
                    
                    
                case 6:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"Actual Major";
                    cell.textField.placeholder = @"student Actual Major";
                    cell.textField.delegate = self;
                    cell.textField.tag = 105;
                    cell.textField.text = params[@"studentActualMajor"];
                    
                    return cell;
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"School Apply";
                    cell.textField.placeholder = @"name School";
                    cell.textField.delegate = self;
                    cell.textField.text = params[@"nameSchool"];
                    cell.textField.tag = 200;

                    return cell;
                }
                    break;
                    
                case 1:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"Major Apply";
                    cell.textField.placeholder = @"Major Apply";
                    cell.textField.delegate = self;
                    cell.textField.tag = 201;
                    cell.textField.text = params[@"majorName"];
                    
                    return cell;
                }
                    break;
                    
                case 2:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"cycle Apply";
                    cell.textField.placeholder = @"cycle Name";
                    cell.textField.delegate = self;
                    cell.textField.tag = 202;
                    cell.textField.text = params[@"cycleName"];
                    
                    return cell;
                }
                    break;
                    
                case 3:
                {
                    NSString *cellIden = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                          (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:cellIden];
                    }
                    
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"tuition Major";
                    cell.textField.placeholder = @"tuition Major";
                    cell.textField.delegate = self;
                    cell.textField.tag = 203;
                    cell.textField.text = params[@"tuitionMajor"];
                    
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                if (_imageArray.count >3) {
                    return 103*2;
                }
                else
                    return 103;
            }
            else if (indexPath.row == 1)
                return 50;
            else
                return 50;
        }
            break;
            
        case 1:
            return 50;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100;
    }
    else
        return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
  
    
    return nil;
}

- (void)racInit
{
    
}




#pragma mark - init
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT -64)
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - textfield delegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hiddenKeyBoard];
    [self.tableView reloadData];
    return YES;
}

- (void)hiddenKeyBoard
{
    
    
    CGFloat y = KNAVGATION_BAR_HEIGHT;
    self.view.frame = [self animation:y];
    [UIView commitAnimations];
    
    [self.view endEditing:YES];
    [self.tableView reloadData];
}

-(CGRect)animation: (float) frame
{
    NSTimeInterval textAnimation = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:textAnimation];
    
    CGRect theframe = CGRectMake(0.0f, frame, SCREEN_WIDTH, self.view.frame.size.height);
    
    return theframe;
}



#pragma mark - pickImage

-(void)addImageViewDidTappedAtAddImage
{
    [self hiddenKeyBoard];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isEdit = YES;
    
    if (buttonIndex == 0) {
        //Camera
        [self cameraPickerButtonTapped];
    }
    else if (buttonIndex == 1)
    {
        //Gallery
        [self pickImage];
    }
}

- (void)deleteImage:(UIButton *)sender
{
    if (sender.tag<_imageArray.count) {
        [_imageArray removeObjectAtIndex:sender.tag];
    }
    
    [self.tableView reloadData];
}
#pragma mark - cameraPickerButtonTapped
-(void)cameraPickerButtonTapped
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //判断相机权限
        if([PublicMethod judgeCanUseCamera]){
            return;
        }
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.navigationBar.barTintColor = [UIColor whiteColor];
        [controller.navigationBar setTranslucent:NO];
        controller.delegate = self;
        controller.allowsEditing = NO;//设置不可编辑
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;            // Camera
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
            if (_isMyFabu) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                [array addObject:result];
                if ([array count]>6) {
                    [array removeObjectsInRange:NSMakeRange(6, [array count]-6)];
                }
                
                [self uploadIamge:array];
            }
            else
            {
                [_imageArray insertObject:result atIndex:[_imageArray count]-1];
                if ([_imageArray count]>6) {
                    [_imageArray removeObjectsInRange:NSMakeRange(6, [_imageArray count]-6)];
                    [_imageArray addObject:ADD_IAMGE];
                }
                
                [self.tableView reloadData];
            }
        });
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}

-(void)pickImage
{
    _picker = [[ZYQAssetPickerController alloc] init];
    [_picker.navigationBar setBarTintColor:KTHEME_COLOR];
    [_picker.navigationBar setTranslucent:NO];
    _picker.navigationBar.tintColor = KCOLOR_WHITE;
    _picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:KCOLOR_WHITE,NSFontAttributeName:KSYSTEM_FONT_BOLD_(18)};
    
    _picker.maximumNumberOfSelection = 6;
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
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<_imageArray.count-1; i++) {
        [array addObject:_imageArray[i]];
    }
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset=assets[i];
        UIImage *img = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage
                                           scale:asset.defaultRepresentation.scale
                                     orientation:UIImageOrientationUp];
        if (_isMyFabu) {
            [array addObject:img];
        }
        else
        {
            [_imageArray insertObject:img atIndex:[_imageArray count]-1];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_isMyFabu) {
            if ([array count]>6) {
                [array removeObjectsInRange:NSMakeRange(6, [array  count]-6)];
                [array removeObjectsInArray:_imageArray];
            }
            
            [self uploadIamge:array];
        }
        else
        {
            if ([_imageArray count]>6) {
                [_imageArray removeObjectsInRange:NSMakeRange(6, [_imageArray count]-6)];
                [_imageArray addObject:ADD_IAMGE];
            }
            
            [self.tableView reloadData];
        }
    });
}



-(void)backgroundTap
{
    [self.view endEditing:YES];
}
// kSetDict(params[@"id"], @"id");
#pragma mark - getalldata
- (void)editApplyForm
{
    kSetDict(self.sess_id, @"sess_id");
    kSetDict(params[@"id"], @"id");
    
    
    NSLog(@"ID_Post ------------------->%@",params[@"id"]);
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/delete_apply_form"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       if([[responseObject objectForKey:@"code"] isEqual:@200])
                                       {
                                           [ProgressHUD showSuccess:@"Done !"];
                                           [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_SECHANDSuccessed
                                                                                               object:nil];
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }
                                       else
                                       {
                                           [ProgressHUD showError:responseObject[@"message"]];
                                       }
                                   } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                                   }];
}

- (void)uploadIamge:(NSArray *)addArray
{
    NSMutableDictionary *imgParams = [NSMutableDictionary dictionary];
    [imgParams setObject:self.sess_id forKey:@"sess_id"];
    kSetDict(params[@"id"], @"id");
    
   // NSLog(@"ID_Post ------------------->%@",params[@"id"]);

    
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<addArray.count; i++) {
        if (![addArray[i] isKindOfClass:[NSString class]]) {
            NSData *data = UIImageJPEGRepresentation(addArray[i], 0.3);
            [dataArr addObject:data];
        }
    }
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/add_user_documents"];
    
    
    
    [[NetWork shareInstance] netWorkWithUrl:string
                                     params:params dataArray:dataArr
                                   fileName:@"photo" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
           if([[responseObject objectForKey:@"code"] isEqual:@200])
           {
               [_imageArray removeLastObject];
               
               NSArray *array = [[NSMutableArray alloc] initWithArray:responseObject[@"data"][@"photo"]];
               
               [_imageArray addObjectsFromArray:array];
               
               [_imageArray addObject:ADD_IAMGE];
               
               [self.tableView reloadData];
           }
           else
           {
               
           }
       } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
           
       }];
}




@end
