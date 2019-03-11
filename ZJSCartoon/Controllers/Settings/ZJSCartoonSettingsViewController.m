//
//  ZJSCartoonSettingsViewController.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/3/11.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonSettingsViewController.h"

#import <YTKNetwork/YTKNetwork.h>
#import <BFKit/BFKit.h>


#import "ZJSSettingsManager.h"



@interface ZJSCartoonSettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *serverPickerView;

@property (nonatomic,strong) NSMutableArray *debugURLs;

@end

@implementation ZJSCartoonSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
    
}

-(NSMutableArray*)loadUrls{
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    NSArray *array = [[ZJSSettingsManager sharedManager] loadServerUrls];
   
    if (array.count > 0) {
        [urls addObjectsFromArray:array];
    }else{
        urls = [@[[ZJSSettingsManager readBaseUrl]] mutableCopy];
    }
    
    return urls;
}

-(void)setupViews{

    self.debugURLs = [self loadUrls];
    
    self.urlTextField.text = [YTKNetworkConfig sharedConfig].baseUrl;
    
    NSInteger index = [self.debugURLs indexOfObject:self.urlTextField.text];
    
    if (index>=0 && index < self.debugURLs.count) {
        [self.serverPickerView selectRow:index inComponent:0 animated:NO];
    }
    
    [self setupNaviBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupNaviBar{
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [closeButton setTitle:@"取消" forState:UIControlStateNormal];
    [closeButton sizeToFit];
    [closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItems = @[closeItem];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton sizeToFit];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItems = @[rightItem];
}

#pragma mark - response events

-(void)closeButtonAction:(UIButton*)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)rightButtonAction:(UIButton*)sender{
    [self saveServerUrl];
    [self saveCustomUrls];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - dataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.debugURLs.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.debugURLs objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.urlTextField.text = [self.debugURLs objectAtIndex:row];
    
//    [self saveServerUrl];
}


#pragma mark - private methods

-(void)saveServerUrl{
    NSString *url = [self.urlTextField.text removeExtraSpaces];
    [YTKNetworkConfig sharedConfig].baseUrl = url;
    [ZJSSettingsManager saveBaseUrl:url];
}




-(void)saveCustomUrls{
    NSString *url = [self.urlTextField.text removeExtraSpaces];
    if (![self.debugURLs containsObject:url]) {
        if (url) {
            [self.debugURLs insertObject:url atIndex:0];
            
            [[ZJSSettingsManager sharedManager] saveServerUrls:self.debugURLs];
        }
    }
}

@end
