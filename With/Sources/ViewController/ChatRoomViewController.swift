//
//  ChatRoomViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
class ChatRoomViewController: UIViewController {
    
    @IBOutlet weak var chatViewBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var noticeImage: UIImageView!
    @IBOutlet weak var noticeRegionLabel: UILabel!
    @IBOutlet weak var noticeTitleLabel: UILabel!
    @IBOutlet weak var noticeDateLabel: UILabel!
    @IBOutlet weak var chatAreaView: UIView!
    @IBOutlet weak var chatTextView: UITextView!
    var chatList: [Chat] = []
    var keyboardHeight: CGFloat = 0
    @IBOutlet weak var chatTableView: UITableView!
    let dateFommatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "hh:mm"
        return formatter
    }()
    let fullDateFommatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        return formatter
    }()
    let monthFommatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    var ref: DatabaseReference!
    var isInvite = false
    var otherId = 11
    var otherName = "위드위드"
    var roomId = "12_11"
    var unSeenCount = 0
    var meetDateString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTableView.dataSource = self
        self.chatTableView.delegate = self
        self.chatTextView.delegate = self
        setChatView()
        setNoticeView()
        initGestureRecognizer()
        registerForKeyboardNotifications()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.ref.removeAllObservers()
        unregisterForKeyboardNotifications()
    }
    override func viewDidAppear(_ animated: Bool) {
        firebaseEventObserver(roomId: roomId)
    }
    override func viewWillAppear(_ animated: Bool) {
        setFirebase()
    }
    @IBAction func cancelButtonClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func sendButtonClick(_ sender: Any) {
        guard let text = self.chatTextView.text else { return }
        sendChat(msg: text) { bool in
            if bool {
               print("메시지 전송 성공")
            } else {
                self.simpleAlert(title: "전송 실패", msg: "전송에 실패하였습니다.")
            }
            self.chatTextView.text = ""
        }
    }
    @IBAction func inviteButtonClick(_ sender: Any) {
        
        let floatAlert = self.storyboard?.instantiateViewController(withIdentifier: "Invite") as! InviteViewController
        floatAlert.roomId = self.roomId
        floatAlert.otherId = self.otherId
        floatAlert.unSeenCount = self.unSeenCount
        
        self.present(floatAlert, animated: true)
    }
    // MARK: - 다른유저가 입력할시 비교
    func userCompare(userIdx: Int) -> Bool {
        //다음셀의 타입이 mine이면 프로필삽입
        guard self.chatList.count > 1 else { return false }
        
        let index = self.chatList.count-1
        let before = self.chatList[index-1]
        guard before.type != .otherProfile else { return false }
        guard before.userIdx != userIdx else { return false }
       
        return true
    }
    //채팅의 모든 날짜비교
//    func dateAllCompare() {
//        guard !self.chatList.isEmpty else { return }
//        for index in 1..<self.chatList.count {
//            let before = self.chatList[index-1]
//            let cur = self.chatList[index]
//            guard before.date == cur.date else { continue }
//            guard before.userIdx == cur.userIdx else { continue }
//            self.chatList[index-1].hide = true
//            self.chatList[index].hide = false
//        }
//    }
    
    // MARK: - 유저의 채팅시간비교
    func dateCompare() {
        guard self.chatList.count > 1 else { return }
        let index = self.chatList.count - 1
        let before = self.chatList[index-1]
        let cur = self.chatList[index]
        guard before.date == cur.date else { return }
        guard before.userIdx == cur.userIdx else { return }
        self.chatList[index-1].hide = true
        self.chatList[index].hide = false
        self.chatTableView.reloadData()
//
//        for index in 1..<self.chatList.count {
//            let before = self.chatList[index-1]
//            let cur = self.chatList[index]
//            guard before.date == cur.date else { continue }
//            guard before.userIdx == cur.userIdx else { continue }
//            self.chatList[index-1].hide = true
//            self.chatList[index].hide = false
//        }
//
//        guard self.chatList.count > 1 else { return }
//        let index = self.chatList.count-1
//        let before = chatList[index-1]
//        let cur = chatList[index]
//        guard before.date == cur.date else { return }
//        guard before.userIdx == cur.userIdx else { return }
//        let indexPath = IndexPath( row: index, section: 0 )
//
//        switch before.type {
//        case .other, .mine:
//            let cell = self.chatTableView.cellForRow(at: indexPath) as! ChatBubbleTableViewCell
//            cell.hide = true
//        case .myInvite:
//            let cell = self.chatTableView.cellForRow(at: indexPath) as! ChatMyInviteTableViewCell
//            cell.hide = true
//        case .otherInvite:
//            let cell = self.chatTableView.cellForRow(at: indexPath) as! ChatOtherInviteTableViewCell
//            cell.hide = true
//        case .otherComplete:
//            let cell = self.chatTableView.cellForRow(at: indexPath) as! ChatCompleteTableViewCell
//            cell.hide = true
//
//        default:
//            return
//        }
//        chatList[index].hide = false
//        chatList[index-1].hide = true
//
//        return
    }
    // MARK: - Chat Update
//    func updateChat() {
//        //self.chatTableView.reloadData()
//        guard self.chatList.count > 0 else { return }
//        let indexPath = IndexPath( row: self.chatList.count-1, section: 0 )
//        self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//    }
    // MARK: - ChatView 설정
    func setChatView() {
        self.chatAreaView.layer.cornerRadius = 6
        self.chatAreaView.layer.borderColor = UIColor.chatViewBorderGray.cgColor
        self.chatAreaView.layer.borderWidth = 1
        chatTextView.labelKern(kerningValue: -0.78)
        chatTextView.labelParagraphStyle(paragraphValue: 3)
    }
    // MARK: - NoticeView 설정
    func setNoticeView() {
        self.noticeDateLabel.labelKern(kerningValue: -0.06)
        self.noticeView.dropShadow()
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatList[indexPath.row]
        
        if chat.type == .date {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! ChatDateTableViewCell
            cell.dateLabel.text = chat.message
            return cell
        } else if chat.type == .otherProfile {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ChatProfileTableViewCell
            cell.userIdLabel.text = chat.nickName
            return cell
        } else if chat.type == .myInvite {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyInviteCell", for: indexPath) as! ChatMyInviteTableViewCell
            
            cell.timeLabel.text = chat.date
            cell.timeLabel.labelKern(kerningValue: -0.06)
            cell.meetTimeLabel.text = chat.meetDate
            cell.nameLabel.text = "김루희"
            cell.hide = chat.hide ?? false
            
            return cell
        } else if chat.type == .otherInvite {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherInviteCell", for: indexPath) as! ChatOtherInviteTableViewCell
            cell.timeLabel.text = chat.date
            cell.timeLabel.labelKern(kerningValue: -0.06)
            cell.meetTimeLabel.text = chat.meetDate
            self.meetDateString = chat.meetDate ?? ""
            cell.nameLabel.text = otherName
            cell.acceptButton.addTarget(self, action: #selector(acceptRequest), for: .touchUpInside)
            cell.hide = chat.hide ?? false
            return cell
        } else if chat.type == .otherComplete {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteCell", for: indexPath) as! ChatCompleteTableViewCell
            cell.timeLabel.text = chat.date
            cell.timeLabel.labelKern(kerningValue: -0.06)
            cell.meetTimeLabel.text = chat.meetDate
            cell.nameLabel.text = otherName
            if UserInfo.shared.getUserIdx() == chat.userIdx {
                cell.youAndITypeLabel.text = "님의"
            } else {
                cell.youAndITypeLabel.text = "님이"
            }
            cell.hide = chat.hide ?? false
            return cell
        }
        let cellid = chat.type == .mine ? "MyChatCell" : "YourChatCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ChatBubbleTableViewCell
        
        cell.chatTextLabel.text = chat.message
        cell.chatTextLabel.labelKern(kerningValue: -0.78)
        cell.timeLabel.text = chat.date
        cell.timeLabel.labelKern(kerningValue: -0.06)
        cell.hide = chat.hide ?? false
        
        return cell
    }
}
// MARK: - TableView Delegate
extension ChatRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chat = chatList[indexPath.row]
        if chat.type == .otherProfile {
            return 42
        } else if chat.type == .date {
            return 55
        } else if chat.type == .myInvite {
            return 203
        } else if chat.type == .otherInvite {
            return 245
        } else if chat.type == .otherComplete {
            return 203
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
        print(estimatedSize)
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
    //GestureRecognizer 생성
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // observer생성
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //observer해제
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // keyboard가 보여질 때 어떤 동작을 수행
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        //키보드의 동작시간 얻기
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        //키보드의 애니메이션종류 얻기
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        //키보드의 크기 얻기
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        //iOS11이상부터는 노치가 존재하기때문에 safeArea값을 고려
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        self.chatViewBottomLayout.constant = self.keyboardHeight
        //키보드 높이만큼 inset조정 + 여유공간
        self.chatTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 25, right: 0)
        if !chatList.isEmpty {
            self.chatTableView.scrollToRow(at: IndexPath(row: chatList.count-1, section: 0), at: .bottom, animated: false)
        }
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            //animation처럼 보이게하기
            self.view.layoutIfNeeded()
        })
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        // 원래대로 돌아가도록
        self.chatViewBottomLayout.constant = 0
        self.chatTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        self.view.setNeedsLayout()
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
        
    }
}
