import Foundation
import PySwiftKit
import PySerializing
import PySwiftObject
import PyUnpack
import PySwiftWrapper

import GoogleMobileAds

public protocol AdmobClass: AnyObject {
    func show(delegate: AdmobListener?)
    func disable()
    
    static func new(ad_unit: String) -> Self
}

public typealias AdmobDelegates = GADBannerViewDelegate & GADFullScreenContentDelegate & GADMediationInterstitialAdEventDelegate

public protocol AdmobListener: NSObject, AdmobDelegates, PyDeserialize {
    
}

@PyModule
struct a4k_pyswift: PyModuleProtocol {
 
    
    static var py_classes: [any (PyClassProtocol & AnyObject).Type] = [
        AdmobBackend.self
    ]
}

public extension PySwiftModuleImport {
    
    //static let admob4ios: PySwiftModuleImport = .init(name: "admob4kivy_ios", module: Admob4ios.py_init)
    
    static let a4k_pyswift: PySwiftModuleImport = .init(name: "a4k_pyswift", module: a4k_pyswift.py_init)
}
