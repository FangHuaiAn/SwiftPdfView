//
//  ViewController.swift
//  StrategistReader
//
//  Created by 房懷安 on 2022/4/23.
//

import UIKit
import PDFKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var previewPdfView: UIView!
    
    let books : [String] = [
        "American Grand Strategy and Corporate Elite Networks The Open Door since the End of the Cold War"
        , "Grand Strategy in Theory and Practice The Need for an Effective American Foreign Policy"
        ,"Net Assessment and Military Strategy Retrospective and Prospective Essays"
        ,"The evolution of modern grand strategic thought"
        ,"The Limits of Restraint"
        ,"The Projects of Skunk Works 75 Years of Lockheed Martin’s Advanced Development Programs"
        ,"TheOriginOfNetAssessment"
    ]
    
    var bookIndex : Int = 0
    let pdfView = PDFView()
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnForward: UIBarButtonItem!
    
    fileprivate func loadPdf( index : Int  ) {
        if let pdfUrl = Bundle.main.url(forResource: books[index], withExtension: "pdf") {
            pdfView.document = PDFDocument(url: pdfUrl)
            pdfView.displaysAsBook = true
            pdfView.autoScales = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        pdfView.frame = previewPdfView.bounds
        
        previewPdfView.addSubview(pdfView)
        
        //
        btnBack.action = #selector(backClicked(button:))
        btnForward.action = #selector(forwardClicked(button:))
        
        if (bookIndex == 0 ){
            btnBack.isEnabled = false
        }
        
        //
        loadPdf(index: bookIndex)
    }

    @IBAction
    func backClicked(button : UIBarButtonItem) -> Void {
        bookIndex -= 1
        
        if ( bookIndex < 0 ){
            bookIndex = 0
            return
        }
        
        if (bookIndex == 0 ){
            button.isEnabled = false
        }
        btnForward.isEnabled = true

        loadPdf(index: bookIndex)
    }

    @IBAction
    func forwardClicked(button : UIBarButtonItem) -> Void {
        bookIndex += 1
        
        if (bookIndex >= books.count){
            bookIndex = books.count - 1
            return
        }
        
        if (bookIndex == (books.count - 1) ){
            button.isEnabled = false
        }
        btnBack.isEnabled = true
        
        loadPdf(index: bookIndex)
        
    }
}
