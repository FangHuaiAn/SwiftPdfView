//
//  ViewController.swift
//  StrategistReader
//
//  Created by 房懷安 on 2022/4/23.
//

import UIKit
import PDFKit
import WebKit

class ViewController: UIViewController, PDFViewDelegate
{

    @IBOutlet weak var previewPdfView: UIView!
    
    let books : [String] = [
        "Air War in the Falklands 1982"
        ,"American Grand Strategy and Corporate Elite Networks The Open Door since the End of the Cold War"
        ,"Combat modeling"
        ,"Comparative Grand Strategy A Framework And Cases"
        ,"Grand Strategy in Theory and Practice The Need for an Effective American Foreign Policy"
        ,"Net Assessment and Military Strategy Retrospective and Prospective Essays"
        ,"Strategic Air Power in Desert Storm"
        ,"Strategic Studies A Reader"
        ,"Strategy The Logic of War and Peace"
        ,"The evolution of modern grand strategic thought"
        ,"The Limits of Restraint"
        ,"The Projects of Skunk Works 75 Years of Lockheed Martin’s Advanced Development Programs"
        ,"The Science of War Defense Budgeting, Military Technology, Logistics, and Combat Outcomes"
        ,"The Shaping of Grand Strategy Policy, Diplomacy, and War"
        ,"The Twilight Struggle What the Cold War Teaches Us about Great-Power Rivalry Today"
        ,"TheOriginOfNetAssessment"
    ]
    
    var bookIndex : Int = 0
    let pdfView = PDFView()
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnForward: UIBarButtonItem!
    
    fileprivate func loadPdf(with index : Int  ) {
        if let pdfUrl = Bundle.main.url(forResource: books[index], withExtension: "pdf") {
            
            guard let document = PDFDocument(url: pdfUrl) else{
                return
            }
            
            pdfView.document = document
            pdfView.displaysAsBook = true
            pdfView.autoScales = true
            pdfView.documentView?.sizeToFit()
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
        loadPdf(with: bookIndex)
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

        loadPdf(with: bookIndex)
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
        
        loadPdf(with: bookIndex)
    }
    
    func pdfViewWillClick(onLink sender: PDFView, with url: URL) {
        
    }
}
