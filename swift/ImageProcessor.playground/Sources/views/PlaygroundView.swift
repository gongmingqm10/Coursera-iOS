import UIKit

public class PlaygroundView: UIView {
    
    let screenWidth: CGFloat = 320
    let screenHeight: CGFloat = 600
    let sliderDefault: Float = 5.0
    let sliderMaxValue: Float = 10.0
    
    var imageView: UIImageView?
    var intensitySlider: UISlider?
    var originalImage: UIImage?
    var imageFilters: ImageFilters?
    var currentFilters: [Filter]?
    
    enum FilterType: Int {
        case NONE = 0
        case BW = 1
        case LAYER = 2
        case MULTIPLE = 3
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init() {
        super.init(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        initFilters()
        initSubView()
        resetStatus()
    }
    
    func changeFilter(sender: UIButton) {
        intensitySlider?.hidden = false
        switch sender.tag {
        case FilterType.BW.rawValue:
            currentFilters = [FilterFactory.createBWFilter()]
        case FilterType.LAYER.rawValue:
            currentFilters = [FilterFactory.createLayerFilter()]
        case FilterType.MULTIPLE.rawValue:
            currentFilters = [FilterFactory.createLayerFilter(), FilterFactory.createBWFilter()]
        default:
            resetStatus()
        }
        intensitySlider?.setValue(sliderDefault, animated: false)
        changeIntensity(intensitySlider!)
    }
    
    func changeIntensity(sender: UISlider) {
        let filterIntensity = Double(sender.value / sliderMaxValue)
        let filteredImage = imageFilters?.apply(filterIntensity, filters: currentFilters!)
        imageView?.image = filteredImage
    }
    
    private func resetStatus() {
        imageView?.image = originalImage
        currentFilters = []
        intensitySlider?.hidden = true
    }
    
    private func initFilters() {
        originalImage = UIImage(named: "London")
        imageFilters = ImageFilters(image: originalImage!)
    }
    
    private func initSubView() {
        addImageView()
        addVerticalSlider()
        addFilterButtons()
    }
    
    private func addImageView() {
        imageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        imageView?.backgroundColor = UIColor.whiteColor()
        imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        imageView?.image = originalImage!
        addSubview(imageView!)
    }
    
    private func addVerticalSlider() {
        let sliderHeight: CGFloat = 240
        intensitySlider = UISlider(frame: CGRectMake(screenWidth - sliderHeight / 2 - 15, screenHeight / 2, sliderHeight, 10))
        intensitySlider?.minimumValue = 0.0
        intensitySlider?.maximumValue = sliderMaxValue
        intensitySlider?.continuous = false
        intensitySlider?.value = sliderDefault
        intensitySlider?.tintColor = UIColor.redColor()
        intensitySlider?.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        intensitySlider?.addTarget(self,
                                   action: #selector(PlaygroundView.changeIntensity(_:)),
                                   forControlEvents: .ValueChanged)
        addSubview(intensitySlider!)
    }
    
    private func addFilterButtons() {
        let buttonsViewHeight: CGFloat = 50
        let buttonsView = UIView(frame: CGRectMake(0, screenHeight - buttonsViewHeight, screenWidth, buttonsViewHeight))
        addSubview(buttonsView)
        
        buttonsView.addSubview(createButton("B&W", frame: CGRectMake(10, 0, 64, 32), type: .BW))
        buttonsView.addSubview(createButton("Layer", frame: CGRectMake(80, 0, 64, 32), type: .LAYER))
        buttonsView.addSubview(createButton("Multiple", frame: CGRectMake(150, 0, 64, 32), type: .MULTIPLE))
        buttonsView.addSubview(createButton("Reset", frame: CGRectMake(220, 0, 64, 32), type: .NONE))
    }
    
    private func createButton(title: String, frame: CGRect, type: FilterType) -> UIButton {
        let filterButton = UIButton(type: UIButtonType.RoundedRect)
        filterButton.frame = frame
        filterButton.setTitle(title, forState: UIControlState.Normal)
        filterButton.addTarget(self,
                           action: #selector(PlaygroundView.changeFilter(_:)),
                           forControlEvents: .TouchUpInside)
        filterButton.tag = type.rawValue
        return filterButton
    }
}
