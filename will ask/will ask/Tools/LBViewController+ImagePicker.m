//
//  UIViewController+ImagePicker.m
//  text
//
//  Created by  郑晖 on 11/01/2017.
//  Copyright © 2017 郑晖. All rights reserved.
//

#import "LBViewController+ImagePicker.h"
#import <objc/message.h>

static const NSString * LBImagePickerDidFinishSelectedMedisKey = @"LBImagePickerDidFinishSelectedMedisKey";
static const NSString * LBImagePickerDidCancelKey = @"LBImagePickerDidCancelKey";

@interface UIViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation UIViewController (ImagePicker)
#pragma mark - Override Setter/Getter Methods
- (void)setDidFinishSelectedMedia:(LBPhotoPickerDidFinishSelectedMedia)didFinishSelectedMedia {
    objc_setAssociatedObject(self, &LBImagePickerDidFinishSelectedMedisKey, didFinishSelectedMedia, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LBPhotoPickerDidFinishSelectedMedia)didFinishSelectedMedia {
    return objc_getAssociatedObject(self, &LBImagePickerDidFinishSelectedMedisKey);
}

- (void)setDidCancel:(LBPhotoPickerDidCancel)didCancel {
    objc_setAssociatedObject(self, &LBImagePickerDidCancelKey, didCancel, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LBPhotoPickerDidCancel)didCancel {
    return objc_getAssociatedObject(self, &LBImagePickerDidCancelKey);
}

#pragma mark - Public methods
- (void)selectPhotoWithSuccessBlock:(LBPhotoPickerDidFinishSelectedMedia)didFinishSelectedMedia cancelBlock:(LBPhotoPickerDidCancel)didCancel {
    
    // Save completion
    self.didFinishSelectedMedia = didFinishSelectedMedia;
    self.didCancel = didCancel;
    
    //
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] || ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
//        [LBMessageHUD showMessage: @"您的设备不支持!" inView: self.view];
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [self configureNavigationBar: imagePicker];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController: imagePicker animated: YES completion: nil];
}

- (void)openCameraWithSuccessBlock:(LBPhotoPickerDidFinishSelectedMedia)didFinishSelectedMedia cancelBlock:(LBPhotoPickerDidCancel)didCancel {
    
    // Save completion
    self.didFinishSelectedMedia = didFinishSelectedMedia;
    self.didCancel = didCancel;
    
    //
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        [LBMessageHUD showMessage: @"您的设备不支持!" inView: self.view];
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [self configureNavigationBar: imagePicker];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController: imagePicker animated: YES completion: nil];
}

#pragma mark - Helper
- (void)configureNavigationBar:(UIImagePickerController *)imagePicker {
    
    imagePicker.navigationBar.titleTextAttributes = @{
                                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                                      };
    imagePicker.navigationBar.translucent = NO;
//    imagePicker.navigationBar.tintColor = kColor_brandColor;
//    imagePicker.navigationBar.barTintColor = kColor_HXCOLOR(@"43434F");
    [imagePicker.navigationBar setShadowImage: [UIImage new]];
    [imagePicker.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

#pragma mark - UIImage Picker Controller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated: YES completion: nil];
    self.didFinishSelectedMedia(picker, info);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated: YES completion: nil];
    self.didCancel(picker);
}

@end
