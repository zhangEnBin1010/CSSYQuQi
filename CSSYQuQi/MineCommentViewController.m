//
//  MineCommentViewController.m
//
//
//  Created by cssy-apple on 15/11/17.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "MineCommentViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#define defaultStr @"点评一下吧..."
#define defaultPublish @"请输入你的话题内容..."
#define imageCount 6


@interface MineCommentViewController ()<MBProgressHUDDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    MBProgressHUD *HUD;
}

//输入框
@property (nonatomic, strong) UITextView *myTextView;
//提示字数
@property (nonatomic, strong) UILabel *countLabel;
//添加图片按钮
@property (nonatomic, strong) UIButton *addImageButton;
//图片数组
@property (nonatomic, strong) NSMutableArray *imageAry;
//显示图片的数组
@property (nonatomic, strong) NSMutableArray *imageViewAry;
//用来保存上传过图片后 返回的图片地址
@property (nonatomic, strong) NSMutableArray *imgurls;
//图片宽度
@property (nonatomic, assign) CGFloat imageW;
//用来标记上传图片的张数
@property (nonatomic, assign) NSInteger index;
@end


@implementation MineCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZEBColor(242, 242, 242);
    [self createBackButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:0 target:self action:@selector(pubilshClick)];
    self.navigationItem.rightBarButtonItem.tintColor = ZEBColor(26, 166, 255);
    
}

- (void)addButtonForAddImage {
    self.imageW = (screenWidth()-80)/3;
    self.index = 0;
    //解决了textView光标起始位置不从第一行开始的问题，这个是ios7开始  由于导航栏引起的
    //self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.extendedLayoutIncludesOpaqueBars = NO;
    
    [self.view addSubview:self.myTextView];
    [self.view addSubview:self.countLabel];
    
    if (![_fromUI isEqualToString:@"评论"]) {
        //添加按钮
        self.addImageButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.countLabel.frame), _imageW, _imageW)];
        [self.view addSubview:self.addImageButton];
        self.addImageButton.backgroundColor = [UIColor lightGrayColor];
        //[self.addImageButton setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        [self.addImageButton setTitle:@"+" forState:UIControlStateNormal];
        [self.addImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.addImageButton.titleLabel.font = FontSystem(35);
        [self.addImageButton addTarget:self action:@selector(addImageClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)createBackButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 20);
    
    [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_button_normal.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_button_clicked.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}
- (void)backButton:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)setViewTitle:(NSString *)viewTitle {
    _viewTitle = viewTitle;
    self.title = viewTitle;
    [self addButtonForAddImage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIActionSheet source ------------------------------------

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"%ld",buttonIndex);
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        switch (buttonIndex) {
            case 0:{//手机相册
                // 创建控制器
                MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
                // 默认显示相册里面的内容SavePhotos
                pickerVc.status = PickerViewShowStatusCameraRoll;
                pickerVc.minCount = imageCount - self.imageAry.count;
                [pickerVc showPickerVc:self];
                __weak typeof(self) weakSelf = self;
                pickerVc.callBack = ^(NSArray *assets){
                    
                    for (MLSelectPhotoAssets *asset in assets) {
                        [weakSelf.imageAry addObject:asset.originImage];
                    }
                    
                    [weakSelf displayImage];
                };
                
            }
                break;
            case 1:{//拍照
                UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
                
                [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
                ipc.delegate = self;
                //ipc.allowsEditing = YES;
                [self presentViewController:ipc animated:YES completion:nil];
            }break;
            case 2:{//取消
                
            }break;
            default:
                break;
        }
    }else {
        switch (buttonIndex) {
            case 0:{//手机相册
                // 创建控制器
                MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
                // 默认显示相册里面的内容SavePhotos
                pickerVc.status = PickerViewShowStatusCameraRoll;
                pickerVc.minCount = imageCount - self.imageAry.count;
                [pickerVc showPickerVc:self];
                __weak typeof(self) weakSelf = self;
                pickerVc.callBack = ^(NSArray *assets){
                    
                    for (MLSelectPhotoAssets *asset in assets) {
                        [weakSelf.imageAry addObject:asset.originImage];
                    }
                    
                    [weakSelf displayImage];
                };
                
            }
                break;
                
            case 1:{//取消
                
            }break;
            default:
                break;
        }
    }
}

//将图片显示出来
-(void)displayImage{
    //NSLog(@"%ld~",_imageAry.count);
    //先把显示在self.view上的图片删除掉
    for (UIImageView *iv in self.imageViewAry) {
        [iv removeFromSuperview];
    }
    [self.imageViewAry removeAllObjects];
    
    
    //根据_imageAry，把图片显示在界面上
    for (int i = 0; i<_imageAry.count; i++) {
        CGFloat X = (_imageW +20)*(i%(imageCount/2))+20;
        CGFloat Y = CGRectGetMaxY(self.countLabel.frame)+10 + (_imageW +20)*(i/(imageCount/2));
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(X , Y, _imageW, _imageW)];
        iv.image = _imageAry[i];
        
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(_imageW-20, 0, 20, 20)];
        [deleteBtn setTitle:@"X" forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [iv addSubview:deleteBtn];
        iv.userInteractionEnabled = YES;
        
        [self.imageViewAry addObject:iv];
        [self.view addSubview:iv];
    }
    
    //调整添加按钮
    if (_imageAry.count >= imageCount) {
        self.addImageButton.hidden = YES;
    }else{
        
        CGFloat X = (_imageW +20)*(_imageAry.count%(imageCount/2))+20;
        CGFloat Y = CGRectGetMaxY(self.countLabel.frame)+10 + (_imageW +20)*(_imageAry.count/(imageCount/2));
        self.addImageButton.frame = CGRectMake(X , Y, _imageW, _imageW);
    }
    
}

//点击删除按钮
-(void)deleteAction:(UIButton *)delBtn{
    
    [self.imageViewAry removeObject:delBtn.superview];
    [delBtn.superview removeFromSuperview];
    [self.imageAry removeAllObjects];
    
    //NSLog(@"%d",_imageViewAry.count);
    for (int i = 0; i<_imageViewAry.count; i++) {
        UIImageView *iv = _imageViewAry[i];
        
        [self.imageAry addObject:iv.image];
        
        CGFloat X = (_imageW +20)*(i%(imageCount/2))+20;
        CGFloat Y = CGRectGetMaxY(self.countLabel.frame)+10 + (_imageW +20)*(i/(imageCount/2));
        iv.frame = CGRectMake(X , Y, _imageW, _imageW);
        
    }
    
    //调整添加按钮
    self.addImageButton.hidden = NO;
    
    CGFloat X = (_imageW +20)*(_imageAry.count%(imageCount/2))+20;
    CGFloat Y = CGRectGetMaxY(self.countLabel.frame)+10 + (_imageW +20)*(_imageAry.count/(imageCount/2));
    self.addImageButton.frame = CGRectMake(X , Y, _imageW, _imageW);
    
}


#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}
#pragma mark - UIImagePickerControllerDelegate ------------------------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //NSLog(@"%@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageAry addObject:image];
    [self displayImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textView source ------------------------------------

//2.在开始编辑的代理方法中进行如下操作
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:defaultStr] || [self.myTextView.text isEqualToString:defaultPublish]) {
        _myTextView.textColor = ZEBColor(51, 51, 51);
        textView.text = @"";
        
    }
}
//3.在结束编辑的代理方法中进行如下操作
- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length<1) {
        _myTextView.textColor = ZEBColor(85, 85, 85);
        textView.text = defaultStr;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    //NSLog(@"%d---%@",textView.text.length,textView.text);
    
    //    if (textView.text.length <15) {
    //        NSUInteger last = 15 - textView.text.length;
    //        _countLabel.text = [NSString stringWithFormat:@"加油,还差%d个字",last];
    //    }else
    if (textView.text.length <= 200){
        NSUInteger last =200 - textView.text.length;
        _countLabel.text = [NSString stringWithFormat:@"你还可以再输入%d个字",last];
    }else{
        _countLabel.text = [NSString stringWithFormat:@"你还可以再输入0个字"];
    }
    
}
//超过200字不让输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length >200) {
        return NO;
    }
    return YES;
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.myTextView resignFirstResponder];
}
#pragma mark - private-owned ------------------------------------------

//图片压缩
-(UIImage *) imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize{
    //newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}
#pragma mark - event response ------------------------------------－－－－
//添加图片按钮
-(void)addImageClick{
    [self.myTextView resignFirstResponder];
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择",@"拍照", nil];
    }else {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
    }
    [actionSheet showInView:self.view];
}
// 点击发布的时候 先上传图片
-(void)pubilshClick{
    NSLog(@"发布");
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    //HUD.mode = MBProgressHUDModeCustomView;
    //HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success.png"]];
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    HUD.delegate = self;
    //HUD.labelText = @"";
    //HUD.detailsLabelText = @"请期待。。。。";
    //HUD.square = YES;
    //HUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
    [HUD show:YES];
    //[HUD hide:YES afterDelay:2];
    // Show the HUD while the provided method executes in a new thread
    //[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    
    //如果没有图片  直接发表
    if (_imageAry.count == 0) {
        [self pubilshComment];
    }
    //如果有图片，上传完图片在发表
    //1.首先将图片上传到服务器  拿到返回的图片地址和缩略图地址
    for (UIImage *image in _imageAry) {
        [self UPLoadImage:image];
    }
    
    
}
//发表评论
-(void)pubilshComment{
    
    NSLog(@"%s",__func__);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"TargetID"] = @(self.userID);
    //    NSLog(@"&&&&&&&&&&&&&&&&&&&&&&&&&&%ld",self.userID);
    //    params[@"CommentType"] = @(3);
    if ([self.myTextView.text isEqualToString:defaultStr] || [self.myTextView.text isEqualToString:defaultPublish]) {
        params[@"CommentText"] = @"";
    }else{
        params[@"CommentText"] = self.myTextView.text;
    }
    //params[@"UserID"] = [[NSUserDefaults standardUserDefaults] objectForKey:keyUserID];
    
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:self.imgurls
                                                      options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strs=[[NSString alloc] initWithData:jsonData
                                         encoding:NSUTF8StringEncoding];
    params[@"imgurls"] = strs;
    
    NSLog(@"%@",strs);
    
    // POST方法
    [manager POST:URL_ZEBCrowdComment parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUD hide:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUD hide:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"~~~~~~~~~~~~~~%@", error);
        
    }];
}

//上传图片
-(void)UPLoadImage:(UIImage *)image{
    //image.size.width/2
    //CGFloat scale = image.size.width/600;
    //图片压缩
    UIImage *upLoadImage=[self imageWithImageSimple:image scaledToSize:CGSizeMake(600, image.size.height/image.size.width*600)];
    
    [self saveImage:upLoadImage WithName:@"upLoad.png"];
    
    NSString *paths = NSHomeDirectory();
    NSString *path = [paths stringByAppendingPathComponent:@"Documents/upLoad.png"];
    //    NSLog(@"%@",path);
    //    //将图片转换成二进制流
    //    NSData* mydata =   [NSData dataWithContentsOfFile:path];
    //将图片压缩转换成jpg
    NSData* mydata = UIImageJPEGRepresentation(image, 0.5);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //上传图片采用二进制流，默认的上传和下载都是json
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"IsWater"] = @0;
    params[@"IsThumbnail"] = @1;
    //这个方法是用来穿二进制的
    [manager POST:URL_uploadfile parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:mydata name:@"FileUpLoad" fileName:@"upLoad.png" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.index++;
        //NSLog(@"----responseObject---%@",responseObject);
        //        NSArray *dicArray = [responseObject objectExceptNullForKey:@"list"];
        
        
        //        if (dicArray.count >0) {
        //            NSDictionary *Dic = dicArray[0];
        
        NSDictionary *dic = @{@"OriginalPath":[responseObject objectExceptNullForKey:@"path"],
                              @"ThumbPath":[responseObject objectExceptNullForKey:@"thumb"]};
        
        [self.imgurls addObject:dic];
        
        //删除沙盒里的图片
        NSFileManager* fileManager=[NSFileManager defaultManager];
        [fileManager removeItemAtPath:path error:nil];
        
        
        //判断如果是最后一张才发表评论
        if (self.index >= _imageAry.count) {
            //2.发布评论
            NSLog(@"%d>=%d",self.index,_imageAry.count);
            [self pubilshComment];
        }
        //        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"~~~~~~~~~~~~~~%@", error);
        
    }];
}


//将图片保存到沙盒 用来提供上传。
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName

{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}

#pragma mark - getters & setters ------------------------------------
//用来存储 上传图片之后返回的图片地址
-(NSMutableArray *)imgurls{
    if (_imgurls == nil) {
        _imgurls = [NSMutableArray array];
    }
    return _imgurls;
}

//显示在界面上的imageView（带删除button）
-(NSMutableArray *)imageViewAry{
    if (_imageViewAry == nil) {
        _imageViewAry = [NSMutableArray array];
    }
    return _imageViewAry;
}
//保存图片
-(NSMutableArray *)imageAry{
    if (_imageAry == nil) {
        _imageAry = [NSMutableArray array];
    }
    return _imageAry;
}
//添加按钮
-(UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth() - 10 -150,CGRectGetMaxY(self.myTextView.frame)+5,  150, 12)];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont systemFontOfSize:12];
        [_countLabel setTextColor:ZEBColor(85, 85, 85)];
        [_countLabel setText:@"你可以输入200个字"];
    }
    return _countLabel;
}
//
-(UITextView *)myTextView{
    if (_myTextView == nil) {
        _myTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, screenWidth()-20, 150)];
        _myTextView.delegate = self;
        
        _myTextView.layer.borderWidth = 0.5;//加边框
        _myTextView.layer.cornerRadius = 5;
        _myTextView.layer.borderColor = ZEBColor(219, 214, 214).CGColor;
        _myTextView.font = [UIFont systemFontOfSize:13];
        _myTextView.textAlignment = NSTextAlignmentLeft;
        _myTextView.backgroundColor = [UIColor whiteColor];
        _myTextView.textColor = ZEBColor(85, 85, 85);
        //1.附一个初始值
        if ([_viewTitle isEqualToString:@"我要点评"]) {
            _myTextView.text = defaultStr;
        }else {
            _myTextView.text = defaultPublish;
        }
        
        
    }
    return _myTextView;
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
