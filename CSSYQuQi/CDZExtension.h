//
//  CDZExtension.h
//
//
//  Created by baight on 14-8-21.
//  Copyright (c) 2014年 baight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

#define RGB(r,g,b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define GCDAsyncInMain(block)        dispatch_async(dispatch_get_main_queue(), (block))
#define GCDSyncInMain(block)         dispatch_sync(dispatch_get_main_queue(), (block))
#define GCDAsyncInBackground(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), (block))
#define GCDsyncInBackground(block)   dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), (block))

#define StringNotNil(str) (str ? str : @"")

#pragma mark - UIView
@interface UIView (CDZViewExtension)
+(id)loadFromBundleWithOwner:(id)owner;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, getter=x, setter=setX:) CGFloat left;
@property (nonatomic, getter=y, setter=setY:) CGFloat top;


@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor* borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

// 获得 view 的 快照
-(UIImage*)snapshoot;

-(void)removeAllSubviews;
-(UIView*)viewWithClass:(Class)c;

// 移动自己 到 view 的右边，与其间距 interval
-(void)moveToRightOfView:(UIView*)view interval:(CGFloat)interval;
-(void)moveToBottomnOfView:(UIView*)view interval:(CGFloat)interval;
- (void)moveToLeftOfView:(UIView*)view inteval:(CGFloat)interval;

//获取 view 的 controller
- (UIViewController *)viewController;

@end

@interface UIScrollView (CDZScrollViewExtension)
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;

-(NSInteger)totalPage;
-(NSInteger)currentPage;
@end

@interface UILabel (CDZLabelExtension)
-(CGSize)textSize;
@end

@interface UIImage (CDZImageExtension)
// 得到一张 1*1 的纯色图片
+(UIImage*)imageOfColor:(UIColor*)color;

// 缩小图片尺寸（如果本身就小于指定尺寸，则不进行任何处理）
-(UIImage*)zoomoutToSize:(CGSize)size;
-(UIImage*)zoomoutToSize:(CGSize)size aspect:(bool)aspect;
// 缩放图片尺寸
-(UIImage*)scaleToSize:(CGSize)size;
-(UIImage*)scaleToSize:(CGSize)size aspect:(bool)aspect;
@end

@interface UITableView (CDZTableViewExtension)
-(void)setClearTableFooterView;
-(void)setClearTableFooterViewWidthHeight:(CGFloat)height;
-(BOOL)isClearFooterView;
@end

@interface UITableViewCell (CDZTableViewCellExtension)
+(instancetype)reusableCellFromTable:(UITableView*)tableView;
-(CGPoint)pointAtTableView;
-(UITableView*)tableView;
@end

@interface UIScreen (CDZScreenExtension)
-(CGFloat)width;
-(CGFloat)height;
@end

@interface UIColor (CDZColorExtension)
+(UIColor*)colorWithHexadecimal:(long)hexColor;
+(UIColor*)colorWithHexadecimal:(long)hexColor alpha:(float)opacity;
@end

#pragma mark - UIViewController
@interface UIViewController(CDZControllerExtension)
+(id)loadFromNib;
-(BOOL)isVisible;
@end

@interface UINavigationController (CDZNavigationControllerExtension)
-(void)popToViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;
@end

@interface UIApplication (CDZApplicationExtension)
- (UIWindow*)appWindow;
@end

#pragma mark - SBJson
@interface NSString (SBJson)
-(id)JSONValue;
@end

@interface NSArray (SBJson)
-(NSString*)JSONRepresentation;
@end

@interface NSDictionary (SBJson)
-(NSString*)JSONRepresentation;
@end

#pragma mark - NSObject
@interface NSObject (CDZObjectExtension)
+(NSString*)classString;
+(UIViewController*)topViewController;
@end

@interface NSString (CDZStringExtension)
+(NSString*)documentDirectoryPath;
+(NSString*)cacheDirectoryPath;
+(NSString*)temporaryDirectoryPath;

+(NSString*)stringWithInteger:(NSInteger)integer;
-(instancetype)initWithInteger:(NSInteger)integer;

-(NSDictionary*)dictionaryOfUrlParams;
-(long long) hexadecimalValue;

-(NSMutableAttributedString*)attributedStringWithAttribute:(NSString*)attribute value:(id)value range:(NSRange)range;
@end

@interface NSMutableArray (CDZArrayExtension)
-(void)removeFirstObject;
@end

@interface ALAsset (CDZAssetExtension)
-(UIImage*)image;             // 全分辨率图
-(UIImage*)imageOfFullScreen; // 全屏图
-(UIImage*)imageOfThumbnail;  // 缩略图
-(UIImage*)imageWithMaxSize:(CGSize)size;  // 获取缩略图，size为最大尺寸
-(UIImage*)imageWithMaxPixelLength:(NSUInteger)size;  // 获取缩略图，size为最大边长
@end

@interface NSDictionary (CDZDictionaryExtension)
-(id)objectExceptNullForKey:(id)aKey;
@end

@interface NSDate (CDZDateExtension)
+(NSString*)stringFromTimeIntervalSince1970:(NSTimeInterval)timeInterval formate:(NSString*)formate;
-(NSString*)stringWithFormat:(NSString*)formate;
@end

@interface NSData (CDZDataExtension)
-(NSString*)stringWithEncoding:(NSStringEncoding)encoding;
@end

@interface NSError (CDZErrorExtension)
-(NSString*)errorMessage;
@end

