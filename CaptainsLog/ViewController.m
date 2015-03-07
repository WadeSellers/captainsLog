//
//  ViewController.m
//  CaptainsLog
//
//  Created by Wade Sellers on 2/19/15.
//  Copyright (c) 2015 WadeSellers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *woodTable;
@property (weak, nonatomic) IBOutlet UIImageView *logCover;
@property (weak, nonatomic) IBOutlet UIImageView *quill;
@property (weak, nonatomic) IBOutlet UIImageView *paper;
@property (weak, nonatomic) IBOutlet UITextView *paperTextView;


@property CGRect bookRestPosition;
@property CGRect bookActivePosition;
@property CGRect bookOpenPosition;
@property CGRect quillRestPosition;
@property CGRect quillActivePosition;
@property CGRect woodTableRestPosition;
@property CGRect woodTableActivePosition;
@property CGRect paperRestPosition;
@property CGRect paperActivePosition;
@property CGRect paperTextViewRestPosition;
@property CGRect paperTextViewActivePosition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSUserDefaults *log = [NSUserDefaults standardUserDefaults];
//    self.paperTextView.text = [log stringForKey:@"textLog"];
    

    

}

- (void)viewDidAppear:(BOOL)animated
{
    //Books active and rest position will effect other elements (paper and paperTextView)
    self.bookRestPosition = CGRectMake((self.view.frame.size.width * 0.10), (self.view.frame.size.height * 0.4), self.view.frame.size.width, self.view.frame.size.height);
    self.bookActivePosition = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +100, self.view.frame.size.width, self.view.frame.size.height);
    self.bookOpenPosition = CGRectMake(self.bookActivePosition.origin.x, self.bookActivePosition.origin.y, 20, self.bookActivePosition.size.height);


    self.quillRestPosition = self.quill.frame;
    self.quillActivePosition = CGRectMake(self.quill.frame.origin.x, self.view.frame.origin.y -200, self.quill.frame.size.width, self.quill.frame.size.height);

    self.woodTableRestPosition = self.view.frame;
    self.woodTableActivePosition = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -200, self.view.frame.size.width, self.view.frame.size.height +200);


    self.paperRestPosition = self.bookRestPosition;
    self.paperActivePosition = CGRectMake(self.bookOpenPosition.size.width, self.bookActivePosition.origin.y, self.bookActivePosition.size.width, self.bookActivePosition.size.height);

    self.paperTextViewRestPosition = self.bookRestPosition;
    self.paperTextViewActivePosition = CGRectMake(self.paperActivePosition.origin.x, self.paperActivePosition.origin.y, self.paperActivePosition.size.width - 20, self.paperActivePosition.size.height);
    self.paperTextView.editable = NO;


    self.paper.alpha = 0.0;
    self.paperTextView.alpha = 0.0;

    self.paper.frame = self.bookRestPosition;
    self.paperTextView.frame = self.bookRestPosition;




    [self animateAtStartup];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBookTapped:(UITapGestureRecognizer *)sender {
    if (self.logCover.frame.origin.x == self.bookRestPosition.origin.x) {

        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self activateLogAndViewsAssociated];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Slid up!");
                         }];
    }
    else if (self.logCover.frame.origin.x == 0){
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self everythingAtRestPosition];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Slid Down!");
                         }];
    }
}

- (IBAction)swipeBookLeft:(UISwipeGestureRecognizer *)sender {
    //if (self.logCoverImage.frame.origin.x == 0) {
        self.paper.alpha = 1.0;
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.logCover setFrame:self.bookOpenPosition];

                         } completion:^(BOOL finished) {
                             NSLog(@"Book Has Opened!");

                             //This must be here.  The paperTextView is what the swipe right gesture is attached to
                             self.paperTextView.alpha = 1.0;
//                             self.logCoverImage.alpha = 0.0;
//                             self.quill.alpha = 0.0;
                         }];
    //}
}
- (IBAction)onPaperSwipeRight:(UISwipeGestureRecognizer *)sender {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.logCover setFrame:self.bookActivePosition];

                     } completion:^(BOOL finished) {
                         NSLog(@"Book Has Closed!");
                         //self.paper.alpha = 0.0;

//                         [NSUserDefaults *log = [NSUserDefaults standardUserDefaults];
//                         [log setObject:self.paperTextView forKey:@"textLog"];

                     }];
}
- (IBAction)onBookSwipeDown:(UISwipeGestureRecognizer *)sender {
    if (self.logCover.frame.origin.x == 0) {
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self everythingAtRestPosition];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Slid Down!");
                         }];
    }
}
- (IBAction)onBookSwipeUp:(UISwipeGestureRecognizer *)sender {
    if (self.logCover.frame.origin.x == self.bookRestPosition.origin.x) {

        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self activateLogAndViewsAssociated];
                         } completion:^(BOOL finished) {
                             NSLog(@"Book Slid up!");
                         }];
    }
}

- (void)animateAtStartup
{
    self.logCover.frame = CGRectMake(self.view.frame.size.width, self.view.frame.size.height, self.bookRestPosition.size.width, self.bookRestPosition.size.height);
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.logCover setFrame:self.bookRestPosition];
                     } completion:^(BOOL finished) {
                         NSLog(@"Book Slid Down!");
                     }];
}





- (void)everythingAtRestPosition
{
    [self.woodTable setFrame:self.woodTableRestPosition];
    [self.logCover setFrame:self.bookRestPosition];
    [self.paper setFrame:self.paperRestPosition];
    [self.paperTextView setFrame:self.paperTextViewRestPosition];
    [self.quill setFrame:self.quillRestPosition];

}

- (void) activateLogAndViewsAssociated
{
    [self.woodTable setFrame:self.woodTableActivePosition];
    [self.logCover setFrame:self.bookActivePosition];
    [self.paper setFrame:self.paperActivePosition];
    [self.paperTextView setFrame:self.paperTextViewActivePosition];
    [self.quill setFrame:self.quillActivePosition];
}




@end
