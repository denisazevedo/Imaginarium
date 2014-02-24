//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Denis C de Azevedo on 24/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ImageViewController

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    //For zoom
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    //Fit the scroll
    _scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    //self.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:imageURL]]; //blocking
    [self startDownloadingImage];
}

- (void)startDownloadingImage {
    self.image = nil;
    if (self.imageURL) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                if ([request.URL isEqual:self.imageURL]) {
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                                                                    dispatch_async(dispatch_get_main_queue(), ^{ //Execute this block in the main queue
                                                                        self.image = image;
                                                                    });
                                                                    //Or
                                                                    //[self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
                                                                }
                                                            }
                                                        }];
        [task resume];
    }
}

- (UIImageView *)imageView {
    if (!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

@end
