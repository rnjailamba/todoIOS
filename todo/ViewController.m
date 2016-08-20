//
//  ViewController.m
//  todo
//
//  Created by Mr Ruby on 20/08/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addClicked:(id)sender;
@property (nonatomic) NSMutableArray *todos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen]bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSMutableArray *todos = [NSMutableArray arrayWithArray:@[@"First",@"Second"]];
    _todos = todos;
    [self registerNib];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)registerNib{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"random"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addClicked:(id)sender {

}

#pragma UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.todos count];    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"random"];
    cell.backgroundColor = [self randomNiceColor];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel * label  = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, self.view.frame.size.width, 30)];
    label.text = [self.todos objectAtIndex:indexPath.row];
    label.textColor = [UIColor whiteColor];
    [label setFont:[UIFont boldSystemFontOfSize:20]];
    
    [cell.contentView addSubview:label];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UIColor *)randomNiceColor
{
    // This method returns a random color in a range of nice ones,
    // using HSB coordinates.
    
    // Random hue from 0 to 359 degrees.
    
    CGFloat hue = (arc4random() % 360) / 359.0f;
    
    // Random saturation from 0.0 to 1.0
    
    CGFloat saturation = (float)arc4random() / UINT32_MAX;
    
    // Random brightness from 0.0 to 1.0
    
    CGFloat brightness = (float)arc4random() / UINT32_MAX;
    
    // Limit saturation and brightness to get a nice colors palette.
    // Remove the following 2 lines to generate a color from the full range.
    
    saturation = saturation < 0.5 ? 0.5 : saturation;
    brightness = brightness < 0.9 ? 0.9 : brightness;
    
    // Return a random UIColor.
    
    return [UIColor colorWithHue:hue
                      saturation:saturation
                      brightness:brightness
                           alpha:1];
}


@end
