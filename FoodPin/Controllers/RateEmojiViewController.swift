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


class RateEmojiViewController:  UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
     override var prefersStatusBarHidden: Bool {
            return true
        }
        
        @IBOutlet weak var belowView: UIView!
        @IBOutlet weak var objectNameLabel: UILabel!
        @IBOutlet weak var accuracyLabel: UILabel!
       
        var model = Food101().model
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
           
            //camera
            let captureSession = AVCaptureSession()
            
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

        

    }
