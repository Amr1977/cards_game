//
//  ViewController.m
//  SuperCard
//
//  Created by Amr Lotfy on 8/2/15.
//  Copyright (c) 2015 Amr Lotfy. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property(strong, nonatomic) Deck *deck;

@end

@implementation ViewController

- (Deck *)deck {
  if (!_deck) {
    _deck = [[PlayingCardDeck alloc] init];
  }

  return _deck;
}

- (void)drawRandomPlayingCard {
  Card *card = [[self deck] drawRandomCard];
  if ([card isKindOfClass:[PlayingCard class]]) {
    PlayingCard *playingCard = (PlayingCard *)card;
    self.playingCardView.rank = playingCard.rank;
    self.playingCardView.suit = playingCard.suit;
  }
}
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
  if (!self.playingCardView.faceUp) {
    [self drawRandomPlayingCard];
  }

  self.playingCardView.faceUp = !self.playingCardView.faceUp;
}
- (IBAction)tab:(UITapGestureRecognizer *)sender {
  [UIView animateWithDuration:1.0
      delay:0.0
      options:UIViewAnimationOptionAutoreverse
      animations:^{
        self.playingCardView.alpha = 0.0;
      }
      completion:^(BOOL fin) {
        if (fin) self.playingCardView.alpha = 1.0;
      }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.playingCardView.suit = @"♥️";
  self.playingCardView.rank = 13;
  self.playingCardView.faceUp = TRUE;
  [self.playingCardView
      addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                               initWithTarget:self.playingCardView
                                       action:@selector(pinch:)]];
  UIDynamicAnimator *animator =
      [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
  [animator addBehavior:gravity];
  UICollisionBehavior *collider = [[UICollisionBehavior alloc] init];
  [animator addBehavior:collider];
}

@end
