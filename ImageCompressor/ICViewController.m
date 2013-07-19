//
//  ICViewController.m
//  ImageCompressor
//
//  Created by Alcanzar Soft on 18/07/13.
//  Copyright (c) 2013 Arpit. All rights reserved.
//

#import "ICViewController.h"

@interface ICViewController ()

@end

@implementation ICViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self createCompressedImageFolder:COMPRESSED_IMAGE_FOLDER];
    NSArray *imagePaths = [self getListOfFileAtPath:[self getDocumentDirectoryPath]];
    [self compressImages:imagePaths];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) createCompressedImageFolder : (NSString *)name{
    NSError *error = [[NSError alloc] init];
    if (![[NSFileManager defaultManager] createDirectoryAtPath:[[self getDocumentDirectoryPath] stringByAppendingPathComponent:name] withIntermediateDirectories:NO attributes:nil error:&error]) {
        NSLog(@"Error: Folder not created!");
    }
}

- (void) compressImages : (NSArray *) imagePaths{
    for (NSString *imageName in imagePaths) {
        NSString *imagePath = [[self getDocumentDirectoryPath] stringByAppendingPathComponent:imageName];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            NSString *imageSavePath = [[[self getDocumentDirectoryPath] stringByAppendingPathComponent:COMPRESSED_IMAGE_FOLDER] stringByAppendingPathComponent:imageName];
            image = [self compressedImage:image];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.25);
            [imageData writeToFile:imageSavePath atomically:YES];
        }
    }
}

- (UIImage *) compressedImage : (UIImage *) image{
    //DefaultSilentAudio.wav
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    return [UIImage imageWithData:imageData scale:0.25f];
}

- (NSString *)getDocumentDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return documentsPath;
}


//get list of image
- (NSArray *) getListOfFileAtPath : (NSString *) string{
    NSError *error = [[NSError alloc] init];
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self getDocumentDirectoryPath] error:&error];
    return array;
}

@end
