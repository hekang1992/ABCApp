//
//  BannerView.swift
//  ABCApp
//
//  Created by Boris on 2024/2/29.
//

import UIKit

typealias SelBannerViewBlock = (_ index:NSInteger) -> ()


class BannerView: UIView, SDCycleScrollViewDelegate {

    var selBabberViewBlock: SelBannerViewBlock?

    lazy var cycleScrollView: SDCycleScrollView =  {
        cycleScrollView = SDCycleScrollView(frame: self.bounds, delegate: self, placeholderImage: nil)
        cycleScrollView.backgroundColor = UIColor.white
        // _cycleScrollView.autoScroll = false
        cycleScrollView.currentPageDotColor = UIColor(hexString: "#299F2D")
        cycleScrollView.pageDotColor = UIColor.white
        return cycleScrollView
    }()
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        self.selBabberViewBlock!(index)
    }
    
    func selBannerblockAction(block: @escaping SelBannerViewBlock) -> Void {
        self.selBabberViewBlock = block
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(cycleScrollView)

        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
