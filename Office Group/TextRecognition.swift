//
//  TextRecgonition.swift
//  Office Group
//
//  Created by Charlton Shih on 8/12/24.
//

import SwiftUI
import Vision

struct TextRecognition: View {
    
    @State private var recognizedText = ""
    
    
    var imageView : UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "example1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Plase upload your ticket.")
                    .font(.title)
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .offset(x: -20)
                
                Image(uiImage: imageView.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                    HStack {
                        
                        Button("Upload") {
                            ImageUpload()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.systemYellow))
                        .cornerRadius(10)
                        
                        Button("Recognize"){
                            recognizeText()
                        }
                            .padding()
                            .foregroundColor(.white)
                        .background(Color(.systemYellow))
                            .cornerRadius(10)
                        
                    }
                
                
                Text(recognizedText)
            }
            .padding()
        }
    }
    
    private func recognizeText() {
       let image = imageView.image!
        
        guard let cgImage = image.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else { print(error!.localizedDescription)
                return
            }
            
            guard let result = request.results as? [VNRecognizedTextObservation] else { return }
            
            let recogArr = result.compactMap { result in
                result.topCandidates(1).first?.string
            }
            
            DispatchQueue.main.async {// delimiter and showing words
                recognizedText = recogArr.joined(separator: " / ")
            }
        }
        request.recognitionLevel = .accurate
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func ImageUpload() {
        //do something here
        return
    }
}

struct TextRecgonition_Preview : PreviewProvider {
    static var previews: some View {
        TextRecognition()
    }
}
