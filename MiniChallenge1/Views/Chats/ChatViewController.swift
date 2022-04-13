//
//  ChatViewController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 12/04/22.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController, MessagesDataSource {
    
    lazy var messageList: [Message] = []
    var isOptionSelected: Bool = false
    var isUserClickSend: Bool = false
    
    var stories: [Int] = [1,2,3,4,5,6,7,8,9,10]
    
    let currentUser = Sender(senderId: "1", displayName: "Me")
    let botCat = Sender(senderId: "2", displayName: "Nyan Cat")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMessageCollectionView()
        configureMessageInputBar()
        loadMessage()
    }
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func configureMessageCollectionView() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        
        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false

        showMessageTimestampOnSwipeLeft = true // default false
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .blue
        messageInputBar.sendButton.setTitleColor(.blue, for: .normal)
        messageInputBar.sendButton.setTitleColor(
            UIColor.blue.withAlphaComponent(0.3),
            for: .highlighted
        )
    }
    
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return messageList[indexPath.section].sender.displayName == messageList[indexPath.section - 1].sender.displayName    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section + 1 < messageList.count else { return false }
        return messageList[indexPath.section].sender.displayName == messageList[indexPath.section + 1].sender.displayName
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
          string: name,
          attributes: [
            .font: UIFont.preferredFont(forTextStyle: .caption1),
            .foregroundColor: UIColor(white: 0.3, alpha: 1)
          ]
        )
    }

        
    func loadMessage() {
        print("Load Pesan")
//        DispatchQueue.global(qos: .userInitiated).async {
//            DispatchQueue.main.async {
//            }
//        }
        
        
        self.messageList.append(Message(sender: self.botCat,
             messageId: UUID().uuidString,
             sentDate: Date().addingTimeInterval(0),
             kind: .text("Halo! I'm Nyan, miaw. First of all, I will help you and be your assistant to help prioritize your budget")
           ))
        
        
        self.messageList.append(Message(sender: self.botCat,
                                     messageId: UUID().uuidString,
                                     sentDate: Date().addingTimeInterval(10),
                                     kind: .text("What do you like to be called, miaw?")
                               ))
        
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToLastItem()
    }
    
    // MARK: - Helpers
    
    func insertMessage(_ message: Message, _ isStory: Bool = false) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        })
        
        print("IS OPTION SELECTEDD!!!", isOptionSelected)
        
        if(self.isOptionSelected) {
            removeOptionMessage()
        }
        
        if(isStory) {
            stories.removeFirst()
        }
                
        self.isUserClickSend = false
    }
    
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    // MASK - EVENT LISTENER
    
    // MASK - CUSTOM BUTTON
    
    private func makeButton(named: String) -> InputBarButtonItem {
        return InputBarButtonItem()
            .configure {
                $0.spacing = .fixed(10)
                $0.title = named
                $0.setSize(CGSize(width: 25, height: 25), animated: false)
                $0.tintColor = UIColor(white: 0.8, alpha: 1)
            }.onSelected {
                $0.tintColor = .blue
            }.onDeselected {
                $0.tintColor = UIColor(white: 0.8, alpha: 1)
            }.onTouchUpInside { _ in
                let message = Message(sender: self.currentUser,
                      messageId: UUID().uuidString,
                      sentDate: Date().addingTimeInterval(10),
                      kind: .text(named)
                )
                self.isOptionSelected = true
                self.insertMessage(message)
                self.handleChatbot()
        }
    }
    
    func handleChatbot() {
        let story = stories[0]
        
        print("STORIESS", stories)
        
        switch(story) {
            //-- Tanya makan
            case 1:
                DispatchQueue.global(qos: .default).async {
                    DispatchQueue.main.async {
                        self.insertMessage(Message(sender: self.botCat,
                                  messageId: UUID().uuidString,
                                  sentDate: Date().addingTimeInterval(10),
                                  kind: .text("Hello, Huda! Nice to meet you. So, I will give you some of question about cat.")
                            ), false)
                        self.insertMessage(Message(sender: self.botCat,
                                  messageId: UUID().uuidString,
                                  sentDate: Date().addingTimeInterval(10),
                                  kind: .text("How many cats do you have?")
                            ), true)
                        self.configureOptionMessage([
                            self.makeButton(named: "0"),
                            self.makeButton(named: "1"),
                            self.makeButton(named: "2"),
                            self.makeButton(named: "3"),
                            self.makeButton(named: ">3"),
                                .flexibleSpace])
                    }
                }
            break;
            
            //-- Tanya usia kucing
        case 2:
                DispatchQueue.global(qos: .default).async {
                    DispatchQueue.main.async {
                        self.insertMessage(Message(sender: self.botCat,
                                  messageId: UUID().uuidString,
                                  sentDate: Date().addingTimeInterval(10),
                                  kind: .text("Great! You like pet a cat, awsome miaw!")
                            ), false)
                        self.insertMessage(Message(sender: self.botCat,
                                  messageId: UUID().uuidString,
                                  sentDate: Date().addingTimeInterval(10),
                                  kind: .text("How old your cats are?")
                            ), false)
                        self.insertMessage(Message(sender: self.botCat,
                                  messageId: UUID().uuidString,
                                  sentDate: Date().addingTimeInterval(10),
                                  kind: .text("""
                                    A. Kitten - birth up to 1 year
                                    B. Young adult - 1-6 years
                                    C. Mature Adult - 7-10 years
                                    D. Senior - >10 years
                                    """)
                            ), true)
                        self.configureOptionMessage([
                            self.makeButton(named: "A"),
                            self.makeButton(named: "B"),
                            self.makeButton(named: "C"),
                            self.makeButton(named: "D"),
                                .flexibleSpace])
                    }
                }
            break;
            
            //-- Tanya litterbox
        case 3:
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("Ahhh.. So many kitten")
                        ), false)
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("How many litter boxes are in your home?")
                        ), true)
                    self.configureOptionMessage([
                        self.makeButton(named: "0"),
                        self.makeButton(named: "1"),
                        self.makeButton(named: "2"),
                        self.makeButton(named: "3"),
                        self.makeButton(named: ">3"),
                            .flexibleSpace])
                }
            }
            break;
            
            //-- Tanya budget
        case 4:
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("Noted, miaw. Next question about your budget")
                        ), false)
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("How much your budget for all cats this month?")
                        ), true)
                }
            }
            break;
            
            //-- Tanya budget
        case 5:
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("Hmmm..., Rp700.000, good budget for more 3 cats")
                        ), false)
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                           kind: .text("""
                             So, I will give you statement about your relationship with your cats, miaw. You can choose from option below about current condition
                             1. Strongly disagree
                             2. Disagree
                             3. Agree
                             4. Strongly agree
                             """)
                        ), false)
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("Are you ready? I'm ready! So, first statement..")
                        ), false)
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("1. I don’t know what I would do without my cat.")
                        ), true)
                    self.configureOptionMessage([
                        self.makeButton(named: "1"),
                        self.makeButton(named: "2"),
                        self.makeButton(named: "3"),
                        self.makeButton(named: "4"),
                            .flexibleSpace])
                }
            }
            break;
            
        case 6:
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("2. My cat is my best friend")
                        ), true)
                    self.configureOptionMessage([
                        self.makeButton(named: "1"),
                        self.makeButton(named: "2"),
                        self.makeButton(named: "3"),
                        self.makeButton(named: "4"),
                            .flexibleSpace])
                }
            }
            break;
            
        case 7:
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("3. I think of my cat as like a child.")
                        ), true)
                    self.configureOptionMessage([
                        self.makeButton(named: "1"),
                        self.makeButton(named: "2"),
                        self.makeButton(named: "3"),
                        self.makeButton(named: "4"),
                            .flexibleSpace])
                }
            }
            break;
            
        case 8:
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("4. I am very protective of my cat")
                        ), true)
                    self.configureOptionMessage([
                        self.makeButton(named: "1"),
                        self.makeButton(named: "2"),
                        self.makeButton(named: "3"),
                        self.makeButton(named: "4"),
                            .flexibleSpace])
                }
            }
            break;
            
        case 9:
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.insertMessage(Message(sender: self.botCat,
                              messageId: UUID().uuidString,
                              sentDate: Date().addingTimeInterval(10),
                              kind: .text("Thank you for talk with me. I will give you recommendation for a minute...")
                        ), true)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    let rc = self.storyboard?.instantiateViewController(withIdentifier: "waiting_result") as! WaitingResultController
                    self.navigationController?.pushViewController( rc, animated:true)
                }
            }
            break;
            
            //-- Tanya b
            default:
                return
        }
            
    }
    
    private func configureOptionMessage(_ bottomItems: [InputItem]) {
        messageInputBar.setMiddleContentView(messageInputBar.inputTextView, animated: false)
        messageInputBar.setRightStackViewWidthConstant(to: 52, animated: false)
        messageInputBar.setStackViewItems(bottomItems, forStack: .bottom, animated: false)
    }
    
    private func removeOptionMessage() {
        messageInputBar.setStackViewItems([], forStack: .bottom, animated: false)
    }
    
    
//    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        return 35
//    }
    
//    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//        let name = message.sender.displayName
//        return NSAttributedString(
//          string: name,
//          attributes: [
//            .font: UIFont.preferredFont(forTextStyle: .caption1),
//            .foregroundColor: UIColor(white: 0.3, alpha: 1)
//          ]
//        )
//    }
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String = ""
    var sentDate: Date
    var kind: MessageKind
}

private let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

extension ChatViewController: MessageCellDelegate {
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("Message tapped")
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        self.isUserClickSend = true
        processInputBar(messageInputBar)
        handleChatbot()
    }
    
    func processInputBar(_ inputBar: InputBarAccessoryView) {
        // Here we can parse for which substrings were autocompleted
        let attributedText = inputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in

            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
        }

        let components = inputBar.inputTextView.components
        inputBar.inputTextView.text = String()
        inputBar.invalidatePlugins()
        // Send button activity animation
        inputBar.sendButton.startAnimating()
        inputBar.inputTextView.placeholder = "Sending..."
        // Resign first responder for iPad split view
        inputBar.inputTextView.resignFirstResponder()
        DispatchQueue.global(qos: .default).async {
            // fake send request task
//            sleep(1)
            DispatchQueue.main.async { [weak self] in
                inputBar.sendButton.stopAnimating()
                inputBar.inputTextView.placeholder = "Aa"
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        }
    }
    
    private func insertMessages(_ data: [Any]) {
        for component in data {
            let user = currentUser
            if let str = component as? String {
                let message = Message(sender: user,
                                      messageId: UUID().uuidString,
                                      sentDate: Date().addingTimeInterval(10),
                                      kind: .text(str)
                                )
                insertMessage(message)
            }
        }
    }
}

//extension ChatViewController: InputBarAccessoryViewDelegate {
//
//    @objc
//    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
//        print("Text berubah = " + text)
//        inputBar.inputTextView.text = ""
//    }
//
//    @objc
//    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//        print("Text ditekan = " + text)
//        inputBar.inputTextView.text = ""
//    }
//
//}
