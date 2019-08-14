//
//  ViewController.swift
//  sekaiisannQuizApp
//
//  Created by 志賀大河 on 2019/08/13.
//  Copyright © 2019 Taigashiga. All rights reserved.
//

//StackViewを利用して4択、3択、2択の問題形式に併せて選択肢のボタンの表示調節を行うこと。
//正解の選択肢ボタンを押した場合、正解のアラートを出し、次の問題へ遷移させること。
//不正解の選択肢ボタンを押した場合、不正解のアラートを出して、次に進むかやり直すかの選択肢を与えること。
//３問全て終えたら結果画面に遷移し、各問の正誤結果が示されること。なお、不正解の場合もやり直して正解になった問題は正解として表示されるようにすること。
//結果画面から戻るとまた１問目に戻り、再び３問回答でき、回答後の結果画面では再度回答した３問分の正誤のみが表示されること。

import UIKit

class ViewController: UIViewController {
    
    
    // 問題が何問目かを表示
    @IBOutlet weak var titleQuestion: UINavigationItem!
    // 問題を表示する
    @IBOutlet weak var questionView: UITextView!
    // 回答のボタン
    @IBAction func answerButtom(_ sender: UIButton) {
        
    }
    
    // 回答結果の配列
    var result: [String] = []
    
    // 問題を管理
    let questions: [[String: Any]] = [
        ["title": "第1問", "question": "日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。\n1. 文化遺産\n2. 自然遺産\n3. 山岳遺産\n4. 伝統遺産",
         "answer": 1, "choice": 4
        ],
        ["title": "第2問", "question": "イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。\n1. シュルレアリスム \n2. アバンギャルド \n3. ルネサンス",
         "answer": 3, "choice": 3
        ],
        ["title": "第3問", "question": "2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれか。\n1. コパカバーナの山 \n2. コルコバードの丘",
         "answer": 2, "choice": 2
        ]
    ]
    
    
    // 現在の問題番号を格納する変数
    var questionsCount: Int = 1
    
    // 問題数の管理
    var currentQuestionNum: Int = 0
    // 総問題数
    var questionCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 総問題数に格納します
        questionsCount = questions.count
    }
    
    // 問題画面から結果の画面に行った時の処理
    override func viewWillDisappear(_ animated: Bool) {
        // タイトルの変更 titleQuestion.title = "問題"
    }
    
    // 結果の画面から問題の画面にもだった時の処理
    override func viewWillAppear(_ animated: Bool) {
        // naviationTitle「一問目」に戻す
        titleQuestion.title = "\(questionsCount)番目"
    }
    
    // 回答を確認するアプリ
    func checkAnswer(yourAnswer: Int) {
        // 回答があっているか確認
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Int {
            // 選んだ答えと答えがあっているか
            if yourAnswer == ans{
                // 【正解のとき】
                correctAlert()
            } else {
                // 不正解の時
                falseAlert()
            }
        }
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
        
        // 不正解のアラートを表示する関数
        func correctAlert() {
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
}

}
