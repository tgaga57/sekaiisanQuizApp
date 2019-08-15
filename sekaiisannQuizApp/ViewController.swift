//
//  ViewController.swift
//  sekaiisannQuizApp
//
//  Created by 志賀大河 on 2019/08/13.
//  Copyright © 2019 Taigashiga. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    // 問題が何問目かを表示
    @IBOutlet weak var titleQuestion: UINavigationItem!
    // 問題を表示する
    @IBOutlet weak var questionView: UITextView!
    // 回答のボタン
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    // 回答結果の配列
    var result: [String] = []
    // 問題を管理
    let questions: [[String: Any]] = [
        ["title": "第1問", "question": "日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。\n1. 文化遺産\n2. 自然遺産\n3. 山岳遺産\n4. 伝統遺産",
         "answer": 1, "choise": 4
        ],
        ["title": "第2問", "question": "イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。\n1. シュルレアリスム \n2. アバンギャルド \n3. ルネサンス",
         "answer": 3, "choise": 3
        ],
        ["title": "第3問", "question": "2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれか。\n1. コパカバーナの山 \n2. コルコバードの丘",
         "answer": 2, "choise": 2
        ]
    ]
    // 現在の問題番号を格納する変数
    var questionsCount: Int = 1
    // 問題数の管理
    var currentQuestionNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    // 問題画面から結果の画面に行った時の処理
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "問題へ", style: .plain, target: nil, action: nil)
        questionView.isUserInteractionEnabled = false
        // カウント初期化
        currentQuestionNum = 0
        // リスト初期化
        result = []
        // 問題を表示する関数 showQuestion() 呼び出し
        showQuestion()
    }
    
    // 回答を確認する関数
    func checkAnswer(yourAnswer: Int) {
        // 回答があっているか確認
        let question = questions[currentQuestionNum]
        if let ans = question["answer"] as? Int {
            // 選んだ答えと答えがあっているか
            if yourAnswer == ans{
                // 正解の時
                correctAlert()
            } else {
                // 不正解の時
                falseAlert()
            }
        }
    }
    
    // 問題を表示する
    func showQuestion() {
        // currentQuestionNumの問題を取得
        let question = questions[currentQuestionNum]
        // タイトルを取り出す
        if let title = question["title"] as? String {
            self.navigationItem.title = title
        }
        // 問題を取り出す
        if let que = question["question"] as? String {
            questionView.text = que
        }
        // 何択の問題によって表示を変える
        if let choise = question["choise"] as? Int {
            if choise == 4 {
                button3.isHidden = false
                button4.isHidden = false
            } else if choise == 3 {
                button4.isHidden = true
            } else if choise == 2 {
                button3.isHidden = true
            }
        }
    }
    
    // セグエ実行前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "answerResult", let vc = segue.destination as? ResultTableViewController else {
            return
        }
        vc.result = result
    }
    // 正解時のアラートを表示する関数
    func correctAlert() {
        // アラートの作成
        let alert = UIAlertController(title: "正解でござる", message: "次に進むでござる", preferredStyle: .alert)
        // アラートのアクションボタン
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: {
            (action: UIAlertAction!) in
            // インデックス番号に　＋１
            self.currentQuestionNum += 1
            // 結果リストに追加
            let num = self.currentQuestionNum
            self.result.append("第\(num)問目: ◎")
            if self.currentQuestionNum >= self.questions.count {
                // 最後の画面のとき画面遷移
                self.performSegue(withIdentifier: "answerResult", sender: nil)
            } else {
                // 最後の問題の時はそれ以外を表示させる
                self.showQuestion()
            }
        })
        alert.addAction(ok)
        present(alert, animated: true)
    }
    // 不正解のアラートを表示する関数
    func falseAlert() {
        // アラートの作成
        let alert = UIAlertController(title: "不正解でござる", message: "次に進むのか？", preferredStyle: .alert)
        // アラートのアクションボタン
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: {
            (action: UIAlertAction!) in
            // okボタン押したら
            // インデックス番号に　＋１
            self.currentQuestionNum += 1
            // 結果リストに追加
            let num = self.currentQuestionNum
            self.result.append("第\(num)問目: X")
            
            if self.currentQuestionNum >= self.questions.count {
                // 最後の画面のとき画面遷移
                self.performSegue(withIdentifier: "answerResult", sender: nil)
            } else {
                self.showQuestion()
            }
        })
        // もう一度を選択した時は何もしない
        let oneMore = UIAlertAction(title: "もう一度", style: .default, handler: nil)
        // 作成したアラートにボタンを追加
        alert.addAction(oneMore)
        alert.addAction(ok)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func button(_ sender: Any) {
        checkAnswer(yourAnswer: 1)
    }
    @IBAction func button2(_ sender: Any) {
        checkAnswer(yourAnswer: 2)
    }
    @IBAction func button3(_ sender: Any) {
        checkAnswer(yourAnswer: 3)
    }
    @IBAction func button4(_ sender: Any) {
        checkAnswer(yourAnswer: 4)
    }
}

