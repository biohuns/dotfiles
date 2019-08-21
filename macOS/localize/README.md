# ディレクトリのローカライズ

## 注意

- MacのSIP無効化の必要あり

## 手順

1. 翻訳したいディレクトリ直下に`.localized`ファイルを作成する

    ```
    $ cd /path/to/dir && touch .localized
    ```

1. 翻訳ファイルを任意のディレクトリにコピー

    ```
    $ cd /path/to/dir  
    $ cp /System/Library/CoreServices/SystemFolderLocalizations/ja.lproj/SystemFolderLocalizations.strings .
    ```

1. 翻訳ファイルをXML化、編集

    ```
    $ sudo plutil -convert xml1 SystemFolderLocalizations.strings  // 翻訳ファイルをXMLに変換
    $ vim SystemFolderLocalizations.strings  // ディレクトリ名(key)と翻訳(value)を追加する
    ```

1. 翻訳ファイルを再度バイナリ化、反映

    ```
    $ sudo plutil -convert binary1 SystemFolderLocalizations.strings  // 再バイナリ化
    $ sudo cp ./SystemFolderLocalizations.strings /System/Library/CoreServices/SystemFolderLocalizations/ja.lproj/
    $ killall Finder
    ```

## 参考

- https://qiita.com/takahiko-takei/items/10e0bfb7118d69be079f
