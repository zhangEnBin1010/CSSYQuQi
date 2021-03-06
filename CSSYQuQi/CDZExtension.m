//
//  CDZExtension.m
//
//
//  Created by baight on 14-8-21.
//  Copyright (c) 2014年 baight. All rights reserved.
//

#import "CDZExtension.h"
#import <ImageIO/ImageIO.h>

#pragma mark - UIView
@implementation UIView (CDZViewExtension)
+(id)loadFromBundleWithOwner:(id)owner{
    NSString* className = NSStringFromClass([self class]);
    id obj = [[[NSBundle mainBundle] loadNibNamed:className owner:owner options:nil] firstObject];
    if([obj isKindOfClass:[UITableViewCell class]]){
        [obj setValue:className forKey:@"reuseIdentifier"];
    }
    return obj;
}

-(void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
-(CGFloat)y{
    return self.frame.origin.y;
}
- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}
- (void)setRight:(CGFloat)right;{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}
- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(CGFloat)height{
    return self.frame.size.height;
}
-(void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
-(CGSize)size{
    return self.frame.size;
}

- (CGFloat)centerX{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}
- (CGFloat)centerY{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
}
-(UIColor*)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}
-(CGFloat)borderWidth{
    return self.layer.borderWidth;
}

-(UIImage*)snapshoot{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.bounds.size.width,self.bounds.size.height), self.opaque, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if([self isKindOfClass:[UIScrollView class]]){
        UIScrollView* s = (UIScrollView*)self;
        CGContextTranslateCTM(context, -s.contentOffset.x, -s.contentOffset.y);
    }
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)removeAllSubviews{
    for(UIView* v in self.subviews){
        [v removeFromSuperview];
    }
}
-(UIView*)viewWithClass:(Class)c;{
    for(UIView* v in self.subviews){
        if( [v isMemberOfClass:c]){
            return v;
        }
    }
    return nil;
}

-(void)moveToRightOfView:(UIView *)view interval:(CGFloat)interval{
    CGSize size = view.bounds.size;
    if([view isKindOfClass:[UILabel class]]){
        UILabel* label = (UILabel*)view;
        //Cc修改
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = label.font;
        size = [label.text sizeWithAttributes:attributes];
        //size = [label.text sizeWithFont:label.font];
        if(size.width > view.bounds.size.width){
            size.width = view.bounds.size.width;
        }
    }
    CGRect rect = self.frame;
    rect.origin.x = view.frame.origin.x + size.width + interval;
    self.frame = rect;
}

- (void)moveToLeftOfView:(UIView*)view inteval:(CGFloat)interval{
    CGSize size = view.bounds.size;
    if([view isKindOfClass:[UILabel class]]){
        UILabel* label = (UILabel*)view;
        //Cc修改
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = label.font;
        size = [label.text sizeWithAttributes:attributes];
        //size = [label.text sizeWithFont:label.font];
        if(size.width > view.bounds.size.width){
            size.width = view.bounds.size.width;
        }
    }
    CGRect rect = self.frame;
    rect.origin.x = view.frame.origin.x - interval;
    self.frame = rect;
}

-(void)moveToBottomnOfView:(UIView*)view interval:(CGFloat)interval{
    CGRect rect = self.frame;
    rect.origin.y = view.frame.origin.y + view.bounds.size.height + interval;
    self.frame = rect;
}

//获取view的controller
- (UIViewController *)viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end

@implementation UIScrollView (CDZScrollViewExtension)
-(CGFloat)contentWidth{
    return self.contentSize.width;
}
-(void)setContentWidth:(CGFloat)contentWidth{
    CGSize size = self.contentSize;
    size.width= contentWidth;
    self.contentSize = size;
}
-(CGFloat)contentHeight{
    return self.contentSize.height;
}
-(void)setContentHeight:(CGFloat)contentHeight{
    CGSize size = self.contentSize;
    size.height = contentHeight;
    self.contentSize = size;
}
-(NSInteger)totalPage{
    NSInteger page = self.contentSize.width / self.bounds.size.width;
    if(self.contentSize.width - page*self.bounds.size.width > 10){
        page++;
    }
    return page;
}
-(NSInteger)currentPage{
    NSInteger page = self.contentOffset.x / self.bounds.size.width;
    if(self.contentOffset.x - page*self.bounds.size.width > self.bounds.size.width/2){
        page++;
    }
    return page;
}
@end

@implementation UILabel(CDZLabelExtension)
-(CGSize)textSize{
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.font;
    return [self.text sizeWithAttributes:attributes];
    //return [self.text sizeWithFont:self.font];
}
@end

@implementation UIImage (CDZImageExtension)
+(UIImage*)imageOfColor:(UIColor*)color{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image stretchableImageWithLeftCapWidth:0 topCapHeight:0];
}

-(UIImage*)zoomoutToSize:(CGSize)size{
    return [self zoomoutToSize:size aspect:false];
}
-(UIImage*)zoomoutToSize:(CGSize)size aspect:(bool)aspect{
    if(self.size.width > size.width || self.size.height > size.height){
        return [self scaleToSize:size aspect:aspect];
    }
    else{
        return self;
    }
}
-(UIImage*)scaleToSize:(CGSize)size{
    return [self scaleToSize:size aspect:false];
}
-(UIImage*)scaleToSize:(CGSize)size aspect:(bool)aspect{
    int width = size.width, height = size.height;
    if(aspect){
        // 先假设以宽为基准
        width = size.width;
        height = size.width * self.size.height/self.size.width;
        
        // 如果假设不成立，则改为以高为基准
        if(height > size.height){
            height = size.height;
            width = size.height * self.size.width/self.size.height;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width,
                                                      height),
                                           NO,
                                           self.scale);
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

@interface CDZClearFooterView : UIView
@end
@implementation CDZClearFooterView
@end
@implementation UITableView (CDZTableViewExtension)
-(void)setClearTableFooterView{
    self.tableFooterView = [[CDZClearFooterView alloc]init];
    self.tableFooterView.backgroundColor = [UIColor clearColor];
}
-(void)setClearTableFooterViewWidthHeight:(CGFloat)height{
    self.tableFooterView = [[CDZClearFooterView alloc]initWithFrame:CGRectMake(0, 0, 1, height)];
    self.tableFooterView.backgroundColor = [UIColor clearColor];
}
-(BOOL)isClearFooterView{
    return [self.tableFooterView isKindOfClass:[CDZClearFooterView class]];
}
@end

@implementation UITableViewCell (CDZTableViewCellExtension)
+(instancetype)reusableCellFromTable:(UITableView*)tableView{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
}
-(CGPoint)pointAtTableView{
    UITableView* tableView = [self tableView];
    CGPoint point = [self convertPoint:CGPointMake(0, 0) toView:tableView];
    return point;
}
-(UITableView*)tableView{
    UIView* tableView = self.superview;
    while (tableView != nil) {
        if([tableView isKindOfClass:[UITableView class]]){
            return (UITableView*)tableView;
        }
        tableView = tableView.superview;
    }
    return nil;
}
@end

@implementation UIScreen (CDZScreenExtension)
-(CGFloat)width{
    return self.bounds.size.width;
}
-(CGFloat)height{
    return self.bounds.size.height;
}
@end

@implementation UIColor (CDZColorExtension)
+ (UIColor*) colorWithHexadecimal:(long)hexColor{
    return [UIColor colorWithHexadecimal:hexColor alpha:1.];
}
+ (UIColor *)colorWithHexadecimal:(long)hexColor alpha:(float)opacity{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
@end

#pragma mark - UIViewController
@implementation UIViewController(CDZControllerExtension)
+(id)loadFromNib{
    __autoreleasing UIViewController* c = [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
    return c;
}
-(BOOL)isVisible{
    return (self.isViewLoaded && self.view.window != nil);
}
@end

@implementation UINavigationController (CDZNavigationControllerExtension)
-(void)popToViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated{
    if(index >= self.viewControllers.count){
        return;
    }
    UIViewController* c = [self.viewControllers objectAtIndex:index];
    [self popToViewController:c animated:animated];
}

@end

@implementation UIApplication (CDZApplicationExtension)
- (UIWindow*)appWindow{
    UIWindow* appWindow = self.keyWindow;
    if(appWindow.windowLevel != UIWindowLevelNormal){
        for(UIWindow* w in self.windows){
            if(w.windowLevel == UIWindowLevelNormal && !w.hidden){
                appWindow = w;
                break;
            }
        }
    }
    return appWindow;
}
@end

#pragma mark - SBJson
@implementation NSString (SBJson)
-(id)JSONValue{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) return nil;
    return result;
}
@end

@implementation NSArray (SBJson)
-(NSString*)JSONRepresentation{
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    
    __autoreleasing NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
@end

@implementation NSDictionary (SBJson)
-(NSString*)JSONRepresentation{
    NSError* error = nil;
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    
    __autoreleasing NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
@end

#pragma mark - NSObject

@implementation NSObject (CDZObjectExtension)
+(NSString*)classString{
    return NSStringFromClass([self class]);
}
+(UIViewController*)topViewController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal && !tmpWin.hidden){
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] firstObject];
    UIViewController* controller = [frontView viewController];
    if ([controller isKindOfClass:[UINavigationController class]]){
        UINavigationController* nav = (UINavigationController*)controller;
        result = [nav topViewController];
    }
    else if ([controller isKindOfClass:[UIViewController class]]){
        result = controller;
    }
    else{
        result = window.rootViewController;
    }
    return result;
}
@end

@implementation NSString (CDZStringExtension)
+(NSString*)documentDirectoryPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
+(NSString*)cacheDirectoryPath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
+(NSString*)temporaryDirectoryPath{
    return NSTemporaryDirectory();
}
+(NSString*)stringWithInteger:(NSInteger)integer{
    return [NSString stringWithFormat:@"%zd", integer, nil];
}
-(instancetype)initWithInteger:(NSInteger)integer{
    return [self initWithFormat:@"%zd", integer, nil];
}
-(NSDictionary*)dictionaryOfUrlParams{
    NSString* params = self;
    NSRange range = [self rangeOfString:@"?"];
    if(range.location != NSNotFound && range.location != self.length-1){
        params = [self substringFromIndex:range.location+1];
    }
    
    NSMutableDictionary* d = [NSMutableDictionary dictionary];
    NSArray* a = [params componentsSeparatedByString:@"&"];
    for(NSString* p in a){
        NSArray* keyValue = [p componentsSeparatedByString:@"="];
        if(keyValue.count > 1){
            NSString* key = [keyValue firstObject];
            NSString* value = [keyValue lastObject];
            if(key && value){
                [d setObject:value forKey:key];
            }
        }
    }
    return d;
}
-(long long) hexadecimalValue{
    if(self.length == 0){
        return 0;
    }
    long long ans = 0;
    NSUInteger times = 1;
    for(NSInteger i = self.length - 1; i >= 0; i--){
        unichar c = [self characterAtIndex:i];
        // 数字
        if(c <= 0x39){
            ans += (c - 0x30) * times;
        }
        // 大写字母
        else if(c <= 0x5a){
            ans += (c - 0x41 + 10) * times;
        }
        // 小写字母
        else{
            ans += (c - 0x61 + 10) * times;
        }
        times *= 16;
    }
    return ans;
}

-(NSMutableAttributedString*)attributedStringWithAttribute:(NSString*)attribute value:(id)value range:(NSRange)range{
    NSMutableAttributedString* mas = [[NSMutableAttributedString alloc]initWithString:self];
    [mas addAttribute:attribute value:value range:range];
    return mas;
}
@end

@implementation  NSMutableArray (CDZArrayExtension)
-(void)removeFirstObject{
    if(self.count > 0){
        [self removeObjectAtIndex:0];
    }
}
@end

@implementation ALAsset (CDZAssetExtension)
-(UIImage*)image{
    ALAssetRepresentation *assetRep = [self defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:UIImageOrientationUp];
    return img;
}
-(UIImage*)imageOfFullScreen{
    ALAssetRepresentation *assetRep = [self defaultRepresentation];
    CGImageRef imgRef = [assetRep fullScreenImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:UIImageOrientationUp];
    return img;
}
-(UIImage*)imageOfThumbnail{
    CGImageRef  ref = [self thumbnail];
    UIImage *img = [UIImage imageWithCGImage:ref];
    return img;
}
-(UIImage*)imageWithMaxSize:(CGSize)size{
    ALAssetRepresentation *assetRep = [self defaultRepresentation];
    CGSize mySize = [assetRep dimensions];
    
    UIImage* img = nil;
    if(mySize.width > mySize.height){
        if(mySize.width > size.width){
            img = [self imageWithMaxPixelLength:size.width];
        }
        else{
            img = [self image];
        }
    }
    else{
        if(mySize.height > size.height){
            img = [self imageWithMaxPixelLength:size.height];
        }
        else{
            img = [self image];
        }
    }
    return img;
}

// 下边的方法，摘自网络，http://blog.csdn.net/huangmindong/article/details/34884257
// Helper methods for thumbnailForAsset:maxPixelSize:
static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count){
    ALAssetRepresentation *rep = (__bridge id)info;
    NSError *error = nil;
    size_t countRead = [rep getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    if (countRead == 0 && error) {
        // We have no way of passing this info back to the caller, so we log it, at least.
        NSLog(@"thumbnailForAsset:maxPixelSize: got an error reading an asset: %@", error);
    }
    return countRead;
}
static void releaseAssetCallback(void *info){
    // The info here is an ALAssetRepresentation which we CFRetain in thumbnailForAsset:maxPixelSize:.
    // This release balances that retain.
    CFRelease(info);
}
// Returns a UIImage for the given asset, with size length at most the passed size.
// The resulting UIImage will be already rotated to UIImageOrientationUp, so its CGImageRef
// can be used directly without additional rotation handling.
// This is done synchronously, so you should call this method on a background queue/thread.
- (UIImage *)imageWithMaxPixelLength:(NSUInteger)size{
    NSParameterAssert(size > 0);
    ALAssetRepresentation *rep = [self defaultRepresentation];
    CGDataProviderDirectCallbacks callbacks ={
        .version = 0,
        .getBytePointer = NULL,
        .releaseBytePointer = NULL,
        .getBytesAtPosition = getAssetBytesCallback,
        .releaseInfo = releaseAssetCallback,
    };
    
    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)CFBridgingRetain(rep), [rep size], &callbacks);
    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef)
  @{   (NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
       (NSString *)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithUnsignedInteger:size],
       (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
       });
    
    CFRelease(source);
    CFRelease(provider);
    
    if (!imageRef) {
        return nil;
    }
    
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    return toReturn;
}
@end

@implementation NSDictionary (CDZDictionaryExtension)
-(id)objectExceptNullForKey:(id)aKey{
    id object = [self objectForKey:aKey];
    if([object isKindOfClass:[NSNull class]]){
        return nil;
    }
    else{
        return object;
    }
}
@end

@implementation NSDate (CDZDateExtension)
+(NSString*)stringFromTimeIntervalSince1970:(NSTimeInterval)timeInterval formate:(NSString*)formate{
    NSDate* date = [[NSDate alloc]initWithTimeIntervalSince1970:timeInterval];
    return [date stringWithFormat:formate];
}
-(NSString*)stringWithFormat:(NSString*)formate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formate];
    return [formatter stringFromDate:self];
}
@end

@implementation NSData (CDZDataExtension)
-(NSString*)stringWithEncoding:(NSStringEncoding)encoding{
    return [[NSString alloc]initWithData:self encoding:encoding];
}
@end

@implementation NSError (CDZErrorExtension)
-(NSString*)errorMessage{
    return [NSString stringWithFormat:@"Error Code: %zd\nDomain: %@\nDescription: %@\nReason: %@",
            self.code,
            self.domain,
            self.localizedDescription,
            self.localizedFailureReason];
}
@end



