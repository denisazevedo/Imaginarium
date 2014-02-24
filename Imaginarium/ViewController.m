//
//  ViewController.m
//  Imaginarium
//
//  Created by Denis C de Azevedo on 24/02/14.
//  Copyright (c) 2014 Denis C de Azevedo. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        
        NSString *urlString = [NSString stringWithFormat:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg", segue.identifier];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        ivc.imageURL = url;
        ivc.title = segue.identifier;
    }
}

@end
