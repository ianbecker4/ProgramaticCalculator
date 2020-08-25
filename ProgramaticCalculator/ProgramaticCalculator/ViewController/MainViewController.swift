//
//  MainViewController.swift
//  ProgramaticCalculator
//
//  Created by Ian Becker on 8/25/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var buttons: [UIButton] {
        return [tenPercentButton, fifteenPercentButton, twentyPercentButton, calculateCustomTipButton]
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        addAllSubViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activateButtons()
    }
    
    // MARK: - Methods
    func addAllSubViews() {
        self.view.addSubview(billStackView)
        self.view.addSubview(tipStackView)
        self.view.addSubview(topThirdStackView)
        self.view.addSubview(customTipStackView)
        self.view.addSubview(middleThirdStackView)
        self.view.addSubview(totalTipStackView)
        self.view.addSubview(totalBillStackView)
        self.view.addSubview(bottomThirdStackView)
        self.view.addSubview(fullStackView)
    }
    
    func setupBillStackView() {
        billStackView.addSubview(billLabel)
        billStackView.addSubview(billTextField)
    }
    
    func setupTipPercentStackView() {
        tipStackView.addSubview(tenPercentButton)
        tipStackView.addSubview(fifteenPercentButton)
        tipStackView.addSubview(twentyPercentButton)
    }
    
    func setupTopThirdStackView() {
        topThirdStackView.addSubview(billStackView)
        topThirdStackView.addSubview(tipStackView)
    }
    
    func setupCustomTipStackView() {
        customTipStackView.addSubview(customTipLabel)
        customTipStackView.addSubview(customTipTextField)
    }
    
    func setupMiddleThirdStackView() {
        middleThirdStackView.addSubview(customTipStackView)
        middleThirdStackView.addSubview(calculateCustomTipButton)
    }
    
    func setupTotalTipStackView() {
        totalTipStackView.addSubview(totalTipLabel)
        totalTipStackView.addSubview(totalTipTextField)
    }
    
    func setupTotalBillStackView() {
        totalBillStackView.addSubview(totalBillLabel)
        totalBillStackView.addSubview(totalBillTextField)
    }
    
    func setupBottomThirdStackView() {
        bottomThirdStackView.addSubview(totalTipStackView)
        bottomThirdStackView.addSubview(totalBillStackView)
    }
    
    func setupFullStackView() {
        fullStackView.addSubview(topThirdStackView)
        fullStackView.addSubview(middleThirdStackView)
        fullStackView.addSubview(bottomThirdStackView)
        
        fullStackView.anchor(top: self.safeArea.topAnchor, bottom: self.safeArea.bottomAnchor, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: SpacingConstants.outerVerticalPadding, paddingBottom: SpacingConstants.outerVerticalPadding, paddingLeading: SpacingConstants.outerHorizontalPadding, paddingTrailing: SpacingConstants.outerHorizontalPadding)
    }
    
    @objc func selectButton(sender: UIButton) {
        buttons.forEach { $0.setTitleColor(.white, for: .normal)}
        sender.backgroundColor = UIColor.customGreen
        switch sender {
        case tenPercentButton:
            guard let bill = billTextField.text, !bill.isEmpty else {return}
            let billNum = Double(bill)
            let tip = billNum! * 0.10
            let totalBill = billNum! + tip
            totalTipTextField.text = String(format: "$%.2f", tip)
            totalBillTextField.text = String(format: "$%.2f", totalBill)
        case fifteenPercentButton:
            guard let bill = billTextField.text, !bill.isEmpty else {return}
            let billNum = Double(bill)
            let tip = billNum! * 0.15
            let totalBill = billNum! + tip
            totalTipTextField.text = String(format: "$%.2f", tip)
            totalBillTextField.text = String(format: "$%.2f", totalBill)
        case twentyPercentButton:
            guard let bill = billTextField.text, !bill.isEmpty else {return}
            let billNum = Double(bill)
            let tip = billNum! * 0.20
            let totalBill = billNum! + tip
            totalTipTextField.text = String(format: "$%.2f", tip)
            totalBillTextField.text = String(format: "$%.2f", totalBill)
        case calculateCustomTipButton:
            guard let bill = billTextField.text, !bill.isEmpty, let customTip = customTipTextField.text, !customTip.isEmpty else {return}
            let billNum = Double(bill)
            let customTipNum = Double(customTip)
            let customTipNumAsPercent = customTipNum! / 100
            let tip = billNum! * customTipNumAsPercent
            let totalBill = billNum! + tip
            totalTipTextField.text = String(format: "$%.2f", tip)
            totalBillTextField.text = String(format: "$%.2f", totalBill)
        default:
            tenPercentButton.backgroundColor = UIColor.darkBlue
            fifteenPercentButton.backgroundColor = UIColor.darkBlue
            twentyPercentButton.backgroundColor = UIColor.darkBlue
            calculateCustomTipButton.backgroundColor = UIColor.darkBlue
        }
    }
    
    func activateButtons() {
        buttons.forEach { $0.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside)}
    }
    
    // MARK: - Views
    let billLabel: UILabel = {
        let label = UILabel()
        label.text = "BILL:"
        label.textColor = UIColor.headerGray
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        
        return label
    }()
    
    let billTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.darkBlue
        textField.addCornerRadius(10)
        textField.layer.masksToBounds = true
        textField.textColor = .white
        textField.font = UIFont(name: "Helvetica-Bold", size: 24)
        textField.keyboardType = .decimalPad
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your bill...", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 24)
        ])
        
        return textField
    }()
    
    let billStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let tenPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("10%", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.backgroundColor = UIColor.darkBlue
        button.addCornerRadius(10)
        
        return button
    }()
    
    let fifteenPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("15%", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.backgroundColor = UIColor.darkBlue
        button.addCornerRadius(10)
        
        return button
    }()
    
    let twentyPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("20%", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.backgroundColor = UIColor.darkBlue
        button.addCornerRadius(10)
        
        return button
    }()
    
    let tipStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 46
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let topThirdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 34
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let customTipLabel: UILabel = {
        let label = UILabel()
        label.text = "CUSTOM TIP:"
        label.textColor = UIColor.headerGray
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        
        return label
    }()
    
    let customTipTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.darkBlue
        textField.addCornerRadius(10)
        textField.layer.masksToBounds = true
        textField.textColor = .white
        textField.font = UIFont(name: "Helvetica-Bold", size: 24)
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "Enter tip %", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 24)
        ])
        
        return textField
    }()
    
    let customTipStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let calculateCustomTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate Custom Tip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.backgroundColor = UIColor.darkBlue
        button.addCornerRadius(10)
        
        return button
    }()
    
    let middleThirdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let totalTipLabel: UILabel = {
        let label = UILabel()
        label.text = "TOTAL TIP:"
        label.textColor = UIColor.headerGray
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        
        return label
    }()
    
    let totalTipTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.darkBlue
        textField.addCornerRadius(10)
        textField.layer.masksToBounds = true
        textField.textColor = .white
        textField.font = UIFont(name: "Helvetica-Bold", size: 24)
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "$0.00", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 24)
        ])
        
        return textField
    }()
    
    let totalTipStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let totalBillLabel: UILabel = {
        let label = UILabel()
        label.text = "TOTAL BILL:"
        label.textColor = UIColor.headerGray
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        
        return label
    }()
    
    let totalBillTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.darkBlue
        textField.addCornerRadius(10)
        textField.layer.masksToBounds = true
        textField.textColor = .white
        textField.font = UIFont(name: "Helvetica-Bold", size: 24)
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "$0.00", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 24)
        ])
        
        return textField
    }()
    
    let totalBillStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let bottomThirdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let fullStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 38
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stackView
    }()
} // End of class
