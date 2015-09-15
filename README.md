# twoSlider
双向滚动slider
- (void)viewDidLoad
{
    [super viewDidLoad];
    _rangeSlider = [[WLRangeSlider alloc] initWithFrame:CGRectMake(0, 100, 320, 10)];
    [_rangeSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_rangeSlider];
}
The Key Point is in  "WLRangeSlider.m"
in the methord    - (void)initLayers
{
 //z这里更改时间轴---24为24个小时
    _maxValue = 24.0;
    _minValue = 0.0;
    _leftValue = 0;
    _rightValue = 6.5;
    _leftValue1=21.0;
    _rightValue1=24;
    }
    next step   we initUI
    
    then   change value  in  the methord  of UIcontrol
    - (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
    - (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
    - (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
    - (void)cancelTrackingWithEvent:(UIEvent *)event
    
    
