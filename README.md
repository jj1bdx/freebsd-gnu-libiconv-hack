# Running command with GNU libiconv preloaded to fix ISO-2022-JP and other character conversion problems

* Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan, and Kenji Rikitake
* License: BSD-like (2-clause, see preload-gnuiconv.sh)

* This program uses the portion of the code from Fumiyasu Satoh's [wcwidth-cjk](https://GitHub.com/fumiyas/wcwidth-cjk).

## What this library and script do

* A local FreeBSD Port-style directory and the distfiles of GNU libiconv 1.14, the standard for FreeBSD 9-STABLE and before (which is actually a modified copy from the FreeBSD Port `converters/libiconv`)
* A script to set `LD_PRELOAD` environmentable variable, which also acts as a wrapper to run a command with the GNU libiconv preloaded
* This library and script is a hack to run `mail/mutt` and `editors/vim` on FreeBSD 10 and later as they were in FreeBSD 9-STABLE, with proper encoding handling of ISO-2022-JP and etc.
* The character code conversion failure problem possibly exists in the following points (rough English translation from <http://www.jp.netbsd.org/ja/JP/ml/tech-pkg-ja/201307/msg00000.html>):
     1. Citrus iconv library of FreeBSD 10 and later
     2. Improper usage of `iconv_open()` for encoding detection
     3. The policy of FreeBSD Ports which does not allow GNU iconv/libiconv to coexist with the base libiconv

## このライブラリは何をするものか（日本語）(Japanese)

* GNU libiconv 1.14のFreeBSD Ports `converters/libiconv` からの引用
* `LD_PRELOAD` を使ってコンパイルしたlibiconvを実行させるためのスクリプト
* FreeBSD 10以降で, FreeBSD 9以前のように`mail/mutt`や`editors/vim`でISO-2022-JP他のエンコーディングを適切に処理できるようにするために必要
* 文字コード変換の問題は以下の点にあると推測される (<http://www.jp.netbsd.org/ja/JP/ml/tech-pkg-ja/201307/msg00000.html>)
     1. FreeBSD 10以降のCitrus iconvライブラリ 
     2. `iconv_open()`をエンコーディング検出に使う不適切な使用法
     3. GNU libiconvとbase libiconvの共存を許さないFreeBSD Portsのポリシー

## How to build

* See libiconv/README.md for installing the shared libraries
* *NOTE WELL: abusing the preload mechanism can induce an unwanted vulnerability to your code. Use with care.*

## Usage

* Shell initiation

          % eval `preload-gnuiconv.sh --sh-init`
          % zsh
          ...

* Running a command via the wrapper script:

          % preload-gnuiconv.sh command arguments
          ...

## Acknowledgments

* [Fumiyasu Satoh](https://twitter.com/satoh_fumiyasu), for [the wcwidth-cjk repository](https://github.com/fumiyas/wcwidth-cjk)
* [Takashi Takizawa](https://twitter.com/ttkzw), for the hint to write this tiny kludge and hack
* [Jun Yamashiro](https://twitter.com/yamajun_ofug), for [the problem analysis](http://www.jp.netbsd.org/ja/JP/ml/tech-pkg-ja/201307/msg00000.htm)
