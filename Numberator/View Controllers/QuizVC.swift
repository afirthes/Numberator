//
//  QuizVC.swift
//  TibetanLearning
//
//  Created by Icetusk on 11.11.2023.
//
import UIKit

class QuizVC: UIViewController {
    
    var currentIndex = 0
    
    var quiz: Quiz! {
        model.quizes[currentIndex]
    }
    
    let model: LessonsModel
    
    init() {
        model = LessonsModel()
        super.init(nibName: nil, bundle: nil)
        next()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func next() {
        
        quiz.answered = true
        model.save()
        
        while (model.quizes[self.currentIndex].answered) {
                    currentIndex += 1
        }
        
        multiplyQuestion.text = "\(quiz.firstNumber) x \(quiz.secondNumber)"
        multiplyAnswer.text = "\(quiz.firstNumber * quiz.secondNumber)"
        multiplyAnswer.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.currentIndex = 0
        while model.quizes[self.currentIndex].answered {
            print(currentIndex)
            self.currentIndex += 1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let gearImage = UIImage(systemName: "gear")
        let gearButton = UIBarButtonItem(image: gearImage, style: .plain, target: self, action: #selector(gearButtonTapped))
        
        let refreshImage = UIImage(systemName: "gear")
        let refreshButton = UIBarButtonItem(image: gearImage, style: .plain, target: self, action: #selector(gearButtonTapped))
//        gearButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = gearButton
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(gearButtonTapped))
        
        view.addSubview(multiplyQuestion)
        view.addSubview(multiplyAnswer)
        view.addSubview(showAnswer)
        
        bottomButtonStackView.addArrangedSubview(nextButton)
        view.addSubview(bottomButtonStackView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            multiplyQuestion.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            multiplyQuestion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            multiplyQuestion.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            multiplyAnswer.topAnchor.constraint(equalTo: multiplyQuestion.bottomAnchor, constant: 100),
            multiplyAnswer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            multiplyAnswer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            showAnswer.topAnchor.constraint(equalTo: multiplyAnswer.bottomAnchor, constant: 100),
            showAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            bottomButtonStackView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }



    @objc func showAnswerButtonTapped() {
        multiplyAnswer.isHidden = false
        quiz.answered = true
        model.save()
    }
    
    
    @objc func nextButtonTapped() {
        print("nextButtonTapped Tapped")
        next()
    }
    
    @objc func gearButtonTapped() {
        let settingsVC = SettingsVC()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc func refreshButtonTapped() {
        
    }

    // Labels
    lazy var multiplyQuestion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20 x 20"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 48)
        return label
    }()
    
    lazy var multiplyAnswer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "400"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0  // Allow multiple lines
        label.lineBreakMode = .byWordWrapping  // Word wrap
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    // Button
    lazy var showAnswer: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show answer", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(showAnswerButtonTapped), for: .touchUpInside)
        return button
    }()
    

    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    lazy var bottomButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
}

