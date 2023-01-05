//
//  ViewController.swift
//  ios_todo_list
//
//  Created by k22120kk on 2023/01/04.
//

import UIKit

// MainActivtity
class ReminderListViewController: UICollectionViewController {
    // セルのコンテンツと外観を設定する
    // 型の名前を保存して、使いやすくする。typedefみたいなやつ。
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // を暗黙的にアンラップするプロパティを追加します
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //レイアウトの作成
        let listLayout = listLayout()
        //レイアウトの反映
        collectionView.collectionViewLayout = listLayout
        
        /*
         見た目作成
         */
        // リストの表示部分
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier:String) in
            
            // アイテムを取得する。
            let reminder = Reminder.sampleData[indexPath.item]
            
            // セルのコンテンツ構成を取得する。
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
        }
        
        
        /*
         入れる中身を宣言
         */
        // 新しいデータ ソースを作成します。
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            
            // セルを宣言して、セルをでキューして返す。
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        
        /*
         中身を入れる
         */
        // スナップショットを作成する。
        // データの状態を管理するために用いる。
        var snapshot = Snapshot()
        //スナップショットのセクションを追加する。
        snapshot.appendSections([0])
        //スナップショットに項目を追加する。
        snapshot.appendItems(Reminder.sampleData.map{$0.title})
        //スナップショットのデータソースに適応する。
        dataSource.apply(snapshot)

        //データソースをコレクションビューに割り当てる。
        collectionView.dataSource = dataSource
    }
    
    //グループ化された外観を持つ新しいリスト構成変数
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        
        // 区切りを無効にして、背景色をクリアに変更する。
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        // リスト構成を返却する。
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    


}

