//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Denis C de Azevedo on 24/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@end

@implementation ImageViewController

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    self.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:imageURL]];   
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
}

@end
