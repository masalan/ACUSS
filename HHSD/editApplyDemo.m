//
//  editApplyDemo.m
//  HHSD
//
//  Created by alain serge on 4/21/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "editApplyDemo.h"
#import "SearchTableViewCell.h"
#import "DescriptionTableViewCell.h"
#import "BtnView.h"

#import "ZYQAssetPickerController.h"
#import "UIImage+fixOrientation.h"
#define ADD_IAMGE [UIImage imageNamed:@"add"]



@interface editApplyDemo ()<UITableViewDataSource,UITableViewDelegate,
UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,
UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate>
{
    BOOL isEdit;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZYQAssetPickerController *picker;
@property (nonatomic, strong) UITapGestureRecognizer *tapGes;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation editApplyDemo
@synthesize params;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"edit form";
    [self tableView];
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!_isMyFabu) {
        if (!isEdit) {
            params = [[NSMutableDictionary alloc] init];
            kSetDict(@"", @"studentName");
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

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 10;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
                                                                           titleColor:KCOLOR_RED
                                                                                 font:KICON_FONT_(18)
                                                                                title:@"\U0000e608"];
                                deleteBtn.tag = idx;
                                [deleteBtn addTarget:self
                                              action:@selector(deleteImage:)
                                    forControlEvents:UIControlEventTouchUpInside];
                                [img addSubview:deleteBtn];
                                
                                [img addTarget:self
                                        action:@selector(deleteImage:)
                              forControlEvents:UIControlEventTouchUpInside];
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
                                                                           titleColor:KCOLOR_RED
                                                                                 font:KICON_FONT_(18)
                                                                                title:@"\U0000e608"];
                                deleteBtn.tag = idx;
                                [deleteBtn addTarget:self
                                              action:@selector(deleteImage:)
                                    forControlEvents:UIControlEventTouchUpInside];
                                [img addSubview:deleteBtn];
                                
                                [img addTarget:self
                                        action:@selector(deleteImage:)
                              forControlEvents:UIControlEventTouchUpInside];
                            }
                        }
                    }];
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
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
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
                    
                case 1:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"MotherTongue";
                    cell.textField.placeholder = @"student Mother Tongue";
                    cell.textField.delegate = self;
                    cell.textField.tag = 200;
                    cell.textField.text = params[@"studentMotherTongue"];
                    return cell;
                }
                    break;
                    
                case 2:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"student Birthday";
                    cell.textField.placeholder = @"student Birthday";
                    cell.textField.delegate = self;
                    cell.textField.tag = 300;
                    cell.textField.text = params[@"studentBirthday"];
                    return cell;
                }
                    break;
                    
                case 3:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"student Phone";
                    cell.textField.placeholder = @"student Mobile Phone";
                    cell.textField.delegate = self;
                    cell.textField.tag = 400;
                    cell.textField.text = params[@"studentMobilePhone"];
                    return cell;
                }
                    break;
                    
                case 4:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"Actual Cycle";
                    cell.textField.placeholder = @"student Actual Cycle";
                    cell.textField.delegate = self;
                    cell.textField.tag = 500;
                    cell.textField.text = params[@"studentActualCycle"];
                    return cell;
                }
                    break;
                    
                    
                case 5:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"Actual Major";
                    cell.textField.placeholder = @"student Actual Major";
                    cell.textField.delegate = self;
                    cell.textField.tag = 600;
                    cell.textField.text = params[@"studentActualMajor"];
                    return cell;
                }
                    break;
                    
                case 6:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"School Apply";
                    cell.textField.placeholder = @"name School";
                    cell.textField.delegate = self;
                    cell.textField.tag = 700;
                    cell.textField.text = params[@"nameSchool"];
                    return cell;
                }
                    break;
                    
                case 7:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"Major Apply";
                    cell.textField.placeholder = @"Student fullName";
                    cell.textField.delegate = self;
                    cell.textField.tag = 800;
                    cell.textField.text = params[@"majorName"];
                    return cell;
                }
                    break;
                    
                case 8:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"cycle Apply";
                    cell.textField.placeholder = @"cycle Name";
                    cell.textField.delegate = self;
                    cell.textField.tag = 900;
                    cell.textField.text = params[@"cycleName"];
                    return cell;
                }
                    break;
                    
                case 9:
                {
                    NSString *cellIde = [NSString stringWithFormat:@"CustomCell%ld%ld",(long)indexPath.section,
                                         (long)indexPath.row];
                    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
                    if (!cell) {
                        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
                    }
                    cell.backgroundColor = KCOLOR_WHITE;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.titleLabel.text = @"tuition Major";
                    cell.textField.placeholder = @"tuition Major";
                    cell.textField.delegate = self;
                    cell.textField.tag = 10;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
            
            return 140;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 100;
    }
    else
        return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        BtnView *btnV = [[BtnView alloc] initWithTitle:@"update"];
        btnV.bottomBtn.enabled = YES;
        
        if ([params[@"studentName"] length]>0&&
            [params[@"nameSchool"] length]>0 )
        {
            btnV.bottomBtn.enabled = YES;
        }
        
        UIColor *color = btnV.bottomBtn.enabled ? [PublicMethod getNaviBarItemColor] : KCOLOR_RED;
        [btnV.bottomBtn setBackgroundColor:color];
        
        [btnV.bottomBtn bk_addEventHandler:^(id sender) {
            [self sendMessage];
        } forControlEvents:UIControlEventTouchUpInside];
        
        return btnV;
    }
    return nil;
}


#pragma mark - textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}





-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if((textView.text.length<= 500 && range.length==0)|| range.length>0) {
        return YES;
    }
    else {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 500)];
        // [self showMBHint:@"您输入的文字达到上限"];
        return NO;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hiddenKeyBoard];
    [self.tableView reloadData];
    return YES;
}


- (void)hiddenKeyBoard {
    
    
    CGFloat y = KNAVGATION_BAR_HEIGHT;
    self.view.frame = [self animation:y];
    [UIView commitAnimations];
    
    [self.view endEditing:YES];
    [self.tableView reloadData];
}

-(CGRect)animation: (float)frame {
    NSTimeInterval textAnimation = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:textAnimation];
    
    CGRect theframe = CGRectMake(0.0f, frame, SCREEN_WIDTH, self.view.frame.size.height);
    return theframe;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hiddenKeyBoard];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hiddenKeyBoard];
}

#pragma mark - init

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = KCOLOR_GRAY_eeeeee;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - getalldata
- (void)sendMessage
{
    [self hiddenKeyBoard];
    
    if (![PublicMethod validateMobile:params[@"mobile"]]) {
        // [self showMBHint:@"enter your phone "];
        return;
    }
    if (_imageArray.count == 1) {
        //[self showMBHint:@"add more picture"];
        return;
    }
    
    kSetDict(self.sess_id, @"sess_id");
    kSetDict(@"1", @"type");
    if (_isMyFabu) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:_imageArray];
        [array removeLastObject];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
        NSMutableString *json =[[NSMutableString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        kSetDict(json, @"photo");
    }
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    if (_isMyFabu) {//编辑
        [string appendString:@"Programs_cylce/update_form"];
    }
    else
    {
        [string appendString:@"Programs_cylce/update_form"];
    }
    
    if (_isMyFabu) {
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
            //
        }];
    }
    else
    {
        //imageData
        NSMutableArray *dataArray = [NSMutableArray array];
        if (_imageArray.count>1) {
            for (NSInteger i = 0; i<_imageArray.count-1; i++) {
                NSData* data = UIImageJPEGRepresentation(_imageArray[i],0.3);
                [dataArray addObject:data];
            }
        }
        
        [[NetWork shareInstance] netWorkWithUrl:string
                                         params:params dataArray:dataArray
                                       fileName:@"head_image" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                           if([[responseObject objectForKey:@"code"] isEqual:@200])
                                           {
                                               [ProgressHUD showSuccess:@"恭喜你,发布成功"];
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
}












#pragma mark - pickImage

-(void)addImageViewDidTappedAtAddImage
{
    [self hiddenKeyBoard];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"camera",@"Gallery", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        //Gallery
        [self cameraPickerButtonTapped];
    }
    else if (buttonIndex == 1)
    {
        //Camera
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
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;            // 拍照
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
            
            [self uploadIamge:array];  // only images sent here (down)
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



- (void)uploadIamge:(NSArray *)addArray
{
    NSMutableDictionary *imgParams = [NSMutableDictionary dictionary];
    [imgParams setObject:self.sess_id forKey:@"sess_id"];
    
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<addArray.count; i++) {
        if (![addArray[i] isKindOfClass:[NSString class]]) {
            NSData *data = UIImageJPEGRepresentation(addArray[i], 0.3);
            [dataArr addObject:data];
        }
    }
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"app/user/issue/upload_image"];
    
    
    
    [[NetWork shareInstance] netWorkWithUrl:string
                                     params:params dataArray:dataArr
                                   fileName:@"head_image" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       if([[responseObject objectForKey:@"code"] isEqual:@200])
                                       {
                                           [_imageArray removeLastObject];
                                           
                                           NSArray *array = [[NSMutableArray alloc] initWithArray:responseObject[@"data"][@"file"]];
                                           
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



/*
 
 {"image":["http:\/\/buchang.wedhoc.com\/twitter_upload\/f654e23037732a6a07875bd0bdc53761.jpg",
 "http:\/\/buchang.wedhoc.com\/twitter_upload\/a010fb2b5afc2e72a37bff00a188959a.jpg",
 "http:\/\/buchang.wedhoc.com\/twitter_upload\/51adb0ebaf241c36814a7c28fab94d6a.jpg",
 "http:\/\/buchang.wedhoc.com\/twitter_upload\/a857c5796aaaf5d61d154d2047c5f1cf.jpg",
 "http:\/\/buchang.wedhoc.com\/twitter_upload\/ac248d0a72ebd3c599c10caf6cac6325.jpg",
 "http:\/\/buchang.wedhoc.com\/twitter_upload\/bf5c44a0bf46d5d57028179323d8e1d7.jpg",
 "http:\/\/buchang.wedhoc.com\/twitter_upload\/0dee78a2d626242080cc68d6599635ba.jpg",
 "http:\/\/buchang.wedhoc.com\/twitter_upload\/a10add3ce5881efc875ce7e17702e9a8.jpg",
 "http:\/\/buchang.wedhoc.com\/twitter_upload\/426e68412f8d7f1d5452427cf3689983.jpg"]}
 
 
 
 
 **/



@end

