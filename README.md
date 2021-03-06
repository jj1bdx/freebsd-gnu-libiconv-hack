# Running command with GNU libiconv preloaded to fix ISO-2022-JP and other character conversion problems

* Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan, and Kenji Rikitake
* License: BSD (2-clause, see preload-gnuiconv.sh)

* This program uses the portion of the code from Fumiyasu Satoh's [wcwidth-cjk](https://GitHub.com/fumiyas/wcwidth-cjk).

## WARNING: this program is not applicable to FreeBSD 11 or later

* The locale system has been largely changed between FreeBSD 11 and FreeBSD 10 or older versions.

## UPDATE 7-DEC-2013

* Kenji Rikitake concludes GNU iconv or Citrus iconv *did not* involve in the problem, at least from 10.0-BETA4. See <http://svnweb.freebsd.org/base?view=revision&revision=258316>
* Kenji Rikitake concluded the cluttered Japanese code detection script in his dot-vimrc caused the problem.
* The latest `editors/vim` with base iconv *no longer has to be replaced* by the GNU libiconv, to be used with `mail/mutt`. 
* Added `dot-vimrc.txt` (UTF-8 encoded) to show an example for UTF-8-encoded Japanese environment.
* The old README.md exists in `OLD.README.md`.
* Summary in Japanese: muttでの問題は少なくとも10.0-BETA4以降では GNU/Citrus iconv の問題ではなく，.vimrcでの日本語文字コード変換に問題があったことが理由であろうと結論を出した．古いREADME.mdはOLD.README.mdに参考のため保管してある．

## What this library and script do

* A local FreeBSD Port-style directory and the distfiles of GNU libiconv 1.14, the standard for FreeBSD 9-STABLE and before (which is actually a modified copy from the FreeBSD Port `converters/libiconv`)
* A script to set `LD_PRELOAD` environmentable variable, which also acts as a wrapper to run a command with the GNU libiconv preloaded
* This library and script is a hack to run code on FreeBSD 10 and later as they were in FreeBSD 9-STABLE, with proper encoding handling of ISO-2022-JP and etc.
* The character code conversion failure problem possibly exists in the following points (rough English translation from <http://www.jp.netbsd.org/ja/JP/ml/tech-pkg-ja/201307/msg00000.html>):
     1. Citrus iconv library of FreeBSD 10 and later
     2. Improper usage of `iconv_open()` for encoding detection
     3. The policy of FreeBSD Ports which does not allow GNU iconv/libiconv to coexist with the base libiconv

## このライブラリは何をするものか（日本語）(Japanese)

* GNU libiconv 1.14のFreeBSD Ports `converters/libiconv` からの引用
* `LD_PRELOAD` を使ってコンパイルしたlibiconvを実行させるためのスクリプト
* FreeBSD 10以降で, コードが動作する際FreeBSD 9以前のようにISO-2022-JP他のエンコーディングを適切に処理できるようにするために必要
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
