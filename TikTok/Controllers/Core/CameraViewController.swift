//
//  CameraViewController.swift
//  TikTok
//
//  Created by Ling Xie on 7/24/21.
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController {
    
    //capture session
    var captureSession = AVCaptureSession()
    
    //capture device
    var videoCaptureDevice: AVCaptureDevice?
    
    //capture output
    var captureOutput = AVCaptureMovieFileOutput()
    
    //capture preview
    var capturePreviewLayer: AVCaptureVideoPreviewLayer?
    
    private let cameraView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cameraView)
        view.backgroundColor = .systemBackground
        setUpCamera()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func didTapClose(){
        captureSession.stopRunning()
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 0
    }
    
    func setUpCamera(){
        //add devices
        if let audioDevice = AVCaptureDevice.default(for: .audio){
            let audioInput =  try? AVCaptureDeviceInput(device: audioDevice)
            if let audioInput = audioInput {
                if captureSession.canAddInput(audioInput){
                    captureSession.addInput(audioInput)
                }
            }
        }
        
        if let videoDevice = AVCaptureDevice.default(for: .video){
            if let videoInput = try? AVCaptureDeviceInput(device: videoDevice){
                if captureSession.canAddInput(videoInput){
                    captureSession.addInput(videoInput)
                }
            }
        }
        
        //update session
        captureSession.sessionPreset = .hd1280x720
        if captureSession.canAddOutput(captureOutput){
            
            captureSession.addOutput(captureOutput)
        }
        
        //configure preview
        capturePreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        capturePreviewLayer?.videoGravity = .resizeAspectFill
        capturePreviewLayer?.frame = view.bounds
        if let layer = capturePreviewLayer{
            cameraView.layer.addSublayer(layer)
        }
        
        //enable camera start
        captureSession.startRunning()
    }
}

extension CameraViewController: AVCaptureFileOutputRecordingDelegate{
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
    
        guard error == nil else{
            return
        }
        
        print("Finished recording \(outputFileURL.absoluteString)")
    }
}
