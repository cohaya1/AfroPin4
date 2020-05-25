//
//  RateEmojiViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 4/29/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import UIKit
import AVKit
import Vision
import AVFoundation

class RateEmojiViewController:  UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate{
     override var prefersStatusBarHidden: Bool {
            return true
        }
        @IBOutlet weak var cameraButton:UIButton!
        @IBOutlet weak var belowView: UIView!
        @IBOutlet weak var objectNameLabel: UILabel!
        @IBOutlet weak var accuracyLabel: UILabel!
       
 var model = AfroPinScan_1().model
        
           
           var backFacingCamera: AVCaptureDevice?
           var frontFacingCamera: AVCaptureDevice?
           var currentDevice: AVCaptureDevice!
          // let captureSession = AVCaptureSession()
           var stillImageOutput: AVCapturePhotoOutput!
           var stillImage: UIImage?
           
           var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
           
           var toggleCameraGestureRecognizer = UISwipeGestureRecognizer()
           var zoomInGestureRecognizer = UISwipeGestureRecognizer()
           var zoomOutGestureRecognizer = UISwipeGestureRecognizer()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
           
            //camera
            let captureSession = AVCaptureSession()
            configure()
            guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
            guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
            captureSession.addInput(input)
            
            captureSession.startRunning()
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(previewLayer)
            previewLayer.frame = view.frame
            // The camera is now created!
            
            view.addSubview(belowView)
            
            belowView.clipsToBounds = true
            belowView.layer.cornerRadius = 15.0
            belowView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            
            let  dataOutput = AVCaptureVideoDataOutput()
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession.addOutput(dataOutput)
            
            
            
        }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
    
    guard let model = try? VNCoreMLModel(for: model) else { return }
    let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
        
        guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
        guard let firstObservation = results.first else {return}
        
        let name: String = firstObservation.identifier
        let acc: Int = Int(firstObservation.confidence * 100)
        
        DispatchQueue.main.async {
            self.objectNameLabel.text = name
            self.accuracyLabel.text = "Accuracy: \(acc)%"
        }
        
        }
    try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
    }

    
    // MARK: - Segues
    
    @IBAction func unwindToCameraView(segue: UIStoryboardSegue) {
    
    }
   
        
        // MARK: - Configuration
        
        private func configure() {
            
            // Preset the session for taking photo in full resolution
            
            
            // Get the front and back-facing camera for taking photos
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)

            for device in deviceDiscoverySession.devices {
                if device.position == .back {
                    backFacingCamera = device
                } else if device.position == .front {
                    frontFacingCamera = device
                }
            }

            currentDevice = backFacingCamera

            guard let captureDeviceInput = try? AVCaptureDeviceInput(device: currentDevice) else {
                return
            }

            // Configure the session with the output for capturing still images
            stillImageOutput = AVCapturePhotoOutput()
            
            // Configure the session with the input and the output devices
           
            
            // Provide a camera preview
         //   cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            

            // Bring the camera button to front
            view.bringSubviewToFront(cameraButton)
           // captureSession.startRunning()
            
            // Toggle Camera recognizer
            toggleCameraGestureRecognizer.direction = .up
     //       toggleCameraGestureRecognizer.addTarget(self, action: #selector(toggleCamera))
            view.addGestureRecognizer(toggleCameraGestureRecognizer)
            
            // Zoom In recognizer
            zoomInGestureRecognizer.direction = .right
            zoomInGestureRecognizer.addTarget(self, action: #selector(zoomIn))
            view.addGestureRecognizer(zoomInGestureRecognizer)

            // Zoom Out recognizer
            zoomOutGestureRecognizer.direction = .left
            zoomOutGestureRecognizer.addTarget(self, action: #selector(zoomOut))
            view.addGestureRecognizer(zoomOutGestureRecognizer)
        }
        
        // MARK: - Camera Functions
        
        
        
        @objc func zoomIn() {
            if let zoomFactor = currentDevice?.videoZoomFactor {
                if zoomFactor < 5.0 {
                    let newZoomFactor = min(zoomFactor + 1.0, 5.0)
                    do {
                        try currentDevice?.lockForConfiguration()
                        currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                        currentDevice?.unlockForConfiguration()
                    } catch {
                        print(error)
                    }
                }
            }
        }

        @objc func zoomOut() {
            if let zoomFactor = currentDevice?.videoZoomFactor {
                if zoomFactor > 1.0 {
                    let newZoomFactor = max(zoomFactor - 1.0, 1.0)
                    do {
                        try currentDevice?.lockForConfiguration()
                        currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                        currentDevice?.unlockForConfiguration()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }

           
           
    

        
        

        

    
