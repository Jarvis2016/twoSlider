#import "ViewController.h"
#import "WLRangeSlider.h"

@interface ViewController ()

@property (nonatomic,strong)WLRangeSlider *rangeSlider;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *time2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _rangeSlider = [[WLRangeSlider alloc] initWithFrame:CGRectMake(0, 100, 320, 10)];
    [_rangeSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_rangeSlider];
    UISwitch *defaultSwitch = [[UISwitch alloc] init];
    [defaultSwitch addTarget:self action:@selector(switchCornorRadius:) forControlEvents:UIControlEventValueChanged];
    defaultSwitch.center = self.view.center;
    defaultSwitch.on = YES;
    [self.view addSubview:defaultSwitch];
    
   
}

- (void)switchCornorRadius:(UISwitch *)sender{
    if (sender.on) {
        _rangeSlider.trackHighlightTintColor = [UIColor clearColor];
        _rangeSlider.thumbColor = [UIColor redColor];
        _rangeSlider.cornorRadiusScale = 1;
    }else{
        _rangeSlider.trackHighlightTintColor = [UIColor redColor];
        _rangeSlider.thumbColor = [UIColor greenColor];
        _rangeSlider.cornorRadiusScale = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)notRounding:(float)price afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
    
    
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
    
}



- (void)valueChanged:(WLRangeSlider *)slider{
    NSLog(@"slider.value----%f=====%f----%f======%f",_rangeSlider.leftValue,_rangeSlider.rightValue,_rangeSlider.leftValue1,_rangeSlider.rightValue1);
    NSLog(@"----zhi%@",[[NSString stringWithFormat:@"%f",_rangeSlider.leftValue ] componentsSeparatedByString:@"."][1]);
    [self changeStr:[NSString stringWithFormat:@"%f",_rangeSlider.leftValue]];
    _time1.text=[NSString stringWithFormat:@"%@-%@",[self changeStr:[NSString stringWithFormat:@"%f",_rangeSlider.leftValue]],[self changeStr:[NSString stringWithFormat:@"%f",_rangeSlider.rightValue]]];
    _time2.text=[NSString stringWithFormat:@"%@-%@",[self changeStr:[NSString stringWithFormat:@"%f",_rangeSlider.leftValue1]],[self changeStr:[NSString stringWithFormat:@"%f",_rangeSlider.rightValue1]]];
}
-(NSString*)changeStr:(NSString*)myStr
{
    NSString*str=nil;
    NSString*fenStr=[NSString stringWithFormat:@"0.%@",[myStr componentsSeparatedByString:@"."][1]];
     NSString*fen=[self notRounding:[fenStr floatValue]*60  afterPoint:0];
    
    str=[NSString stringWithFormat:@"%@:%@",[NSString stringWithFormat:@"%@",[myStr componentsSeparatedByString:@"."][0]],fen];
    NSLog(@"str--%@",str);
    return str;
}

@end
