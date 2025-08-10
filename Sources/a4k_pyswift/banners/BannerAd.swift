//
//  BannerAd.swift
//  PySwiftBackend
//

import GoogleMobileAds
import PySwiftKit
import PySerializing
import PySwiftObject
import PySwiftWrapper
import PyUnpack


public final class BannerAd: AdmobClass {
	
	var banner: GADBannerView?
	private var scaleFactor: CGFloat = 2.0
    var height: Double
    let adUnitID: String
	
	public init(unit_id: String, height: Double) {
		self.height = height
		self.adUnitID = unit_id
	}
	
    public static func new(ad_unit: String) -> Self {
        Self.init(unit_id: ad_unit, height: 160)
    }
    
	public func disable() {
		if banner != nil {
			banner?.removeFromSuperview()
			banner = nil
			//set self.ads_space in kivy back to 0
		}
		//py?.banner_did_load(w: 0, h: 0)
	}
    public func show(delegate: AdmobListener? = nil) {
        show(delegate: delegate, top: true)
    }
    public func show(delegate: AdmobListener? = nil, top: Bool) {
		guard
			let kivy_vc = kivy_viewController,
			let view = kivy_vc.view
		else { return }
		scaleFactor = view.contentScaleFactor
		
		
		if banner == nil {
			let frame = view.frame
			let viewWidth = frame.width
			let scale = kivy_vc.view.contentScaleFactor
			scaleFactor = scale
			let banner = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: viewWidth / 2 , height: self.height / scale)))
			
			banner.adUnitID = adUnitID
			banner.delegate = delegate
			banner.translatesAutoresizingMaskIntoConstraints = false
			banner.rootViewController = kivy_vc
			kivy_vc.view.addSubview(banner)
			
			let horizontalConstraint = NSLayoutConstraint(item: banner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            let verticalConstraint = if top {
                NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0)
            } else {
                NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0)
            }
			
			kivy_vc.view.addConstraints([horizontalConstraint, verticalConstraint])
			banner.load(GADRequest())
			self.banner = banner
		}
		
	}
	
}
