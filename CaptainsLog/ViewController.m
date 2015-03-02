//
//  ViewController.m
//  CaptainsLog
//
//  Created by Wade Sellers on 2/19/15.
//  Copyright (c) 2015 WadeSellers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *woodTableImage;
@property (weak, nonatomic) IBOutlet UIImageView *logCoverImage;
@property (weak, nonatomic) IBOutlet UIImageView *quill;
@property (weak, nonatomic) IBOutlet UIImageView *paper;
@property (weak, nonatomic) IBOutlet UITextView *paperTextView;


@property CGRect bookStartPosition;
@property CGRect quillStartPosition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *log = [NSUserDefaults standardUserDefaults];
    self.paperTextView.text = [log stringForKey:@"textLog"];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    self.paper.alpha = 0.0;
    self.paperTextView.alpha = 0.0;
    self.bookStartPosition = self.logCoverImage.frame;
    self.quillStartPosition = self.quill.frame;
    [self animateAtStartup];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBookTapped:(UITapGestureRecognizer *)sender {
    if (self.logCoverImage.frame.origin.x == self.bookStartPosition.origin.x) {

        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.logCoverImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                             [self.quill setFrame:CGRectMake(self.quill.frame.origin.x, -200, self.quill.frame.size.width, self.quill.frame.size.height -200)];
                             [self.woodTableImage setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -200, self.view.frame.size.width, self.view.frame.size.height +200)];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Slid up!");
                         }];
    }
    else if (self.logCoverImage.frame.origin.x == 0){
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.logCoverImage setFrame:self.bookStartPosition];
                             [self.quill setFrame:self.quillStartPosition];
                             [self.woodTableImage setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Slid Down!");
                         }];
    }
}

- (IBAction)swipeBookLeft:(UISwipeGestureRecognizer *)sender {
    if (self.logCoverImage.frame.origin.x == 0) {
        self.paper.alpha = 1.0;
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.logCoverImage setFrame:CGRectMake(0, 0, 20, self.logCoverImage.frame.size.height)];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Has Opened!");
                             self.paperTextView.alpha = 1.0;
//                             self.logCoverImage.alpha = 0.0;
//                             self.quill.alpha = 0.0;
                         }];
    }
}
- (IBAction)onPaperSwipeRight:(UISwipeGestureRecognizer *)sender {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.logCoverImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                     } completion:^(BOOL finished) {
                         NSLog(@"Book Has Closed!");
                         self.paper.alpha = 0.0;

                         NSUserDefaults *log = [NSUserDefaults standardUserDefaults];
                         [log setObject:self.paperTextView forKey:@"textLog"];

                     }];
}
- (IBAction)onBookSwipeDown:(UISwipeGestureRecognizer *)sender {
    if (self.logCoverImage.frame.origin.x == 0) {
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.logCoverImage setFrame:self.bookStartPosition];
                             [self.quill setFrame:self.quillStartPosition];
                             [self.woodTableImage setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Slid Down!");
                         }];
    }
}
- (IBAction)onBookSwipeUp:(UISwipeGestureRecognizer *)sender {
    if (self.logCoverImage.frame.origin.x == self.bookStartPosition.origin.x) {

        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.logCoverImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                             [self.quill setFrame:CGRectMake(self.quill.frame.origin.x, -200, self.quill.frame.size.width, self.quill.frame.size.height -200)];
                             [self.woodTableImage setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -200, self.view.frame.size.width, self.view.frame.size.height +200)];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Slid up!");
                         }];
    }
}

- (void)animateAtStartup
{
    self.logCoverImage.frame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height, self.bookStartPosition.size.width, self.bookStartPosition.size.height);
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.logCoverImage setFrame:self.bookStartPosition];
                         //[self.quill setFrame:self.quillStartPosition];
                     } completion:^(BOOL finished) {
                         NSLog(@"Book Slid Down!");
                     }];
}

- (BOOL)textview:(UITextView *)textView{
//    self.logCoverImage.alpha = 0.0;
//    self.quill.alpha = 0.0;
    return YES;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
