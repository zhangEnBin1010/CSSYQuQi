//
//  PersonInfoViewController.m
//  CSSYQuQi
//
//  Created by cssy-apple on 15/12/7.
//  Copyright © 2015年 cssy-apple. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PersonInfoTableViewCell.h"
#import "PersonImageTableViewCell.h"
#import "NickNameViewController.h"
#import "BigTuxiangViewController.h"
@interface PersonInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, PersonImageForBigDelegate> {
    UITableView *_tableView;
    UIImagePickerController *_imagePickerController;
    NSTimer *_timer;
}
@property (nonatomic, strong) PersonImageTableViewCell *tuxiangCell;
@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createBackButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_tableView != nil) {
        [_tableView removeFromSuperview];
        _tableView = nil;
    }
    [self initall];
   
}
- (void)initall {
    [self createTableView];
    
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
- (void)createTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width(self.view.frame), height(self.view.frame)-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        [self.view addSubview:_tableView];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    static NSString *identifier1 = @"identifier1";
    
    if (indexPath.section == 0) {
        _tuxiangCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (_tuxiangCell == nil) {
            _tuxiangCell = [[PersonImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        _tuxiangCell.delegate = self;
        return _tuxiangCell;
    }
    PersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (cell == nil) {
        cell = [[PersonInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
    }
    NSArray *nameArray = @[@"昵称",@"性别"];
    cell.nameStr = nameArray[indexPath.section-1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //从相册或者相机替换用户的图像
        [self chooseImage];
    }else if (indexPath.section == 1) {
        NickNameViewController *nickController = [[NickNameViewController alloc] init];
        nickController.title = @"更改昵称";
        [self.navigationController pushViewController:nickController animated:YES];
    }else if (indexPath.section == 2) {
        [self createAlert];
    }
}
- (void)createAlert {
    //创建弹出控制图
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请选择性别" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertBoy = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:@"男" forKey:UserSex];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_tableView reloadData];
    }];
    UIAlertAction *alertGirl = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:@"女" forKey:UserSex];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_tableView reloadData];
    }];
    [alertController addAction:alertBoy];
    [alertController addAction:alertGirl];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}
- (void)chooseImage {
    UIActionSheet *actionSheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择",@"拍照", nil];
    }
    else {
        
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
    }
    
    actionSheet.tag = 255;
    
    [actionSheet showInView:self.view];
}
#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    
                    // 取消
                    return;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
            } else {
                
                return;
            }
        }
        // 跳转到相机或相册页面
        _imagePickerController = [[UIImagePickerController alloc] init];
        
        _imagePickerController.delegate = self;
        
        _imagePickerController.allowsEditing = YES;
        
        _imagePickerController.sourceType = sourceType;
        
        _imagePickerController.modalTransitionStyle = 2;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(change) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:@"NSDefaultRunLoopMode"];
        
    }
}
//纠正_imagePickerController代理
- (void)change {
    _imagePickerController.delegate = self;
    ZEBLog(@"%@",_imagePickerController.delegate);
}
//图片压缩
-(UIImage *) imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize{
    //newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}
//照片保存沙盒路径
- (void)saveImage:(UIImage *)currenImage WithName:(NSString *)imageName {
    NSData *imageData = UIImageJPEGRepresentation(currenImage, 0.5);
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [imageData writeToFile:fullPath atomically:NO];
    });
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        [_timer invalidate];
        _timer = nil;
    }];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{
        [_timer invalidate];
        _timer = nil;
    }];
    
    [self saveImage:image WithName:@"currentImage.png"];
    _tuxiangCell.infoImageView.imageView.image = image;
    if (image == nil) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请添加图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else {
    
        //AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
    }
}
- (void)PersonImageForBig:(PersonImageTableViewCell *)cell url:(NSString *)url {
    BigTuxiangViewController *bigTuxiangController = [BigTuxiangViewController new];
    bigTuxiangController.url = url;
    bigTuxiangController.modalTransitionStyle = 2;
    [self presentViewController:bigTuxiangController animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
