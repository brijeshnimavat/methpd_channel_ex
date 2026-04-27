import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {

  private let CHANNEL = "battery_channel"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController 

    let batteryChannel = FlutterMethodChannel(name: CHANNE, binaryMessanger: controller.binaryMessanger)

    
    batteryChannel.setMethodCallHandler{ (call, result) in

        if call.method == "getBatteryLevel"{
          self.getBatteryLevel(result:result)

        } else{
          result(FlutterMethodNotImplemented)
        }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getBatteryLevel(result: flutterResult){
    UIDevice.current.isBatteryMonitoringEnabled = true

    let batteryLevel = UIDevice.current.batteryLevel

    if batteryLevel  < 0 {
      result(FlutterError(code:"UNAVAILABLE", message: "Battery level not available",details: nil))
    }
    else{
      result(Int(batteryLevel * 100))
    }
  }
}
