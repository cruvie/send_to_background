import Flutter
import UIKit

public class SendToBackgroundPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "send_to_background", binaryMessenger: registrar.messenger())
    let instance = SendToBackgroundPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "sendToBackground":
      DispatchQueue.main.async {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
      }
      result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
