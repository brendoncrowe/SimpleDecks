//
//  CreateCardDeckViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit


protocol CreateCardDeckViewControllerDelegate: NSObject {
    func didCreate(_ sender: CreateCardDeckViewController, cardDeck: CardDeck)
}

class CreateCardDeckViewController: UIViewController {
    
    private var createCardDeckView = CreateCardDeckView()
    public weak var delegate: CreateCardDeckViewControllerDelegate?
    
    
    override func loadView() {
        super.loadView()
        view = createCardDeckView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Add a Card Deck"
        createCardDeckView.createDeckButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        createCardDeckView.deckDescriptionTextField.delegate = self
        createCardDeckView.deckTitleTextField.delegate = self
        updateSaveButtonState()
    }
    
    @objc private func createButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
        createCardDeck()
    }
    
    private func updateSaveButtonState() {
        let deckTitle = createCardDeckView.deckTitleTextField.text ?? ""
        let deckDescription = createCardDeckView.deckTitleTextField.text ?? ""
        createCardDeckView.createDeckButton.isEnabled =  !deckTitle.isEmpty
        && !deckDescription.isEmpty
    }
    
    
    private func createCardDeck() {
        guard let deckTitle = createCardDeckView.deckTitleTextField.text,
              let deckDescription = createCardDeckView.deckDescriptionTextField.text else { return }
        let cardDeck = CardDeck(title: deckTitle, description: deckDescription, flashCards: nil)
        delegate?.didCreate(self, cardDeck: cardDeck)
        dismiss(animated: true)
    }
}


extension CreateCardDeckViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            updateSaveButtonState()
            return
        }
        updateSaveButtonState()
        print(text)
    }
}
