//
//  ChatRoomViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import Alamofire
class ChatRoomViewController: UIViewController {
    
    let chat1 = Chat(type: .mine, nickName: "my", message: "hihi")
    let chat2 = Chat(type: .mine, nickName: "my", message: "hey~~~")
    let chat3 = Chat(type: .other, nickName: "your", message: "hihi")
    let chat4 = Chat(type: .other, nickName: "your", message: "merry")
    let chat5 = Chat(type: .other, nickName: "your", message: "...")
    let chat6 = Chat(type: .other, nickName: "your", message: "hoo... nononononononononononononononononononononononononononono")
    let chat7 = Chat(type: .date, message: "2020.02.10")
    let chat8 = Chat(type: .otherProfile, nickName: "you")
    let chat9 = Chat(type: .myInvite, nickName: "you")
    let chat10 = Chat(type: .otherInvite, nickName: "you")
    let chat11 = Chat(type: .complete, nickName: "you")
    
    @IBOutlet weak var chatAreaView: UIView!
    @IBOutlet weak var chatTextView: UITextView!
    var testList: [Chat] = []
    var chatList: [Chat] = []
    @IBOutlet weak var chatTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTableView.dataSource = self
        self.chatTableView.delegate = self
        self.chatTextView.delegate = self
        testList = [chat1, chat2, chat3, chat4, chat5, chat6, chat7, chat8, chat9, chat10, chat11]
        setChatView()
    }
    @IBAction func sendButtonClick(_ sender: Any) {
        let text = self.chatTextView.text
        //        self.socket.emit("test", text)
        //        self.testList.append(Chat(type: .mine, message: text)
        self.testList.append(Chat(type: .mine, message: text))
        self.updateChat(count: self.testList.count) {
            print("Send Message")
        }
    }
    // MARK: - Chat Update
    func updateChat( count: Int, completion: @escaping () -> Void ) {
        let indexPath = IndexPath( row: count-1, section: 0 )
        self.chatTableView.beginUpdates()
        self.chatTableView.insertRows(at: [indexPath], with: .none)
        self.chatTableView.endUpdates()
        self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        completion()
    }
    // MARK: - ChatView 설정
    func setChatView() {
        self.chatAreaView.layer.cornerRadius = 6
        self.chatAreaView.layer.borderColor = UIColor.chatViewBorderGray.cgColor
        self.chatAreaView.layer.borderWidth = 1
        chatTextView.labelKern(kerningValue: -0.78)
        chatTextView.labelParagraphStyle(paragraphValue: 3)
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = testList[indexPath.row]
        if chat.type == .date {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! ChatDateTableViewCell
            cell.dateLabel.text = chat.message
            return cell
        } else if chat.type == .otherProfile {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ChatProfileTableViewCell
            cell.userIdLabel.text = chat.message
            return cell
        } else if chat.type == .myInvite {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyInviteCell", for: indexPath) as! ChatMyInviteTableViewCell
            
            return cell
        } else if chat.type == .otherInvite {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherInviteCell", for: indexPath) as! ChatOtherInviteTableViewCell
            return cell
        } else if chat.type == .complete {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteCell", for: indexPath) as! ChatCompleteTableViewCell
            return cell
        }
        let cellid = chat.type == .mine ? "MyChatCell" : "YourChatCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ChatBubbleTableViewCell

        cell.chatTextLabel.text = chat.message
        cell.chatTextLabel.labelKern(kerningValue: -0.78)
        return cell
    }
}
// MARK: - TableView Delegate
extension ChatRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chat = testList[indexPath.row]
        if chat.type == .otherProfile {
            return 42
        } else if chat.type == .date {
            return 55
        } else if chat.type == .myInvite{
            return 177
        } else if chat.type == .otherInvite{
            return 215
        } else if chat.type == .complete{
            return 177
        } else {
            let approximateWidthOfText = view.frame.width - 36 - 131
            let size = CGSize(width: approximateWidthOfText, height: 1200)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
            let estimatedFrame = NSString(string: chat.message ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return estimatedFrame.height + 13 + 13 + 2
        }
    }
}

// MARK: - TextView 동적 사이즈 변경
extension ChatRoomViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        var estimatedSize = textView.sizeThatFits(size)
        if estimatedSize.height > 75 {
            return
        } else if estimatedSize.height < 32 {
            estimatedSize.height = 31
        }
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}

extension ChatRoomViewController {
//
//
//    
//    //GestureRecognizer 생성
//    func initGestureRecognizer() {
//        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
//        view.addGestureRecognizer(textFieldTap)
//    }
//
//    // 다른 위치 탭했을 때 키보드 없어지는 코드
//    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//    }
//
//
//    // observer생성
//    func registerForKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    //observer해제
//    func unregisterForKeyboardNotifications() {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    // keyboard가 보여질 때 어떤 동작을 수행
//    @objc func keyboardWillShow(_ notification: NSNotification) {
//
//        //키보드의 동작시간 얻기
//        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
//
//        //키보드의 애니메이션종류 얻기
//        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
//
//        //키보드의 크기 얻기
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//
//        //iOS11이상부터는 노치가 존재하기때문에 safeArea값을 고려
//        if #available(iOS 11.0, *) {
//            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
//        } else {
//            keyboardHeight = keyboardFrame.cgRectValue.height
//        }
//
//        self.botViewLayout.constant = -self.keyboardHeight
//        //키보드 높이만큼 inset조정
//        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
//        if myChat.count > 0 {
//            self.tableView.scrollToRow(at: IndexPath(row: myChat.count-1, section: 0), at: .bottom, animated: false)
//        }
//
//        self.view.setNeedsLayout()
//        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
//            //animation처럼 보이게하기
//            self.view.layoutIfNeeded()
//        })
//
//
//    }
//
//    // keyboard가 사라질 때 어떤 동작을 수행
//    @objc func keyboardWillHide(_ notification: NSNotification) {
//        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
//        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
//
//        // 원래대로 돌아가도록
//        self.botViewLayout.constant = 0
//        self.tableView.contentInset = .zero
//        self.view.setNeedsLayout()
//        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
//            self.view.layoutIfNeeded()
//        })
//
//    }
}

struct Chat {
    var type: ChatType
    var nickName: String?
    var message: String?
    var date: Date?
}

enum ChatType {
    case mine
    case other
    case myInvite
    case otherInvite
    case complete
    case otherProfile
    case date
}
