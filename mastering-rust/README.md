# <span id="top">Book <i>Mastering Rust</i></span> <span style="font-size:90%;">[⬆](../README.md#top)</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="../docs/images/rust-logo-blk.svg" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">Directory <code>mastering-rust\</code> gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples from Sharma's book <a href="https://www.packtpub.com/product/mastering-rust-second-edition/9781789346572" rel="external"><i>Mastering Rust</i></a>.<br/>
  It also includes several build scripts (<a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a>, <a href="https://makefiletutorial.com/" rel="external">Make scripts</a> and more) for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on a Windows machine.
  </td>
  </tr>
</table>

Code examples in directory `mastering-rust\` can be build/run with the following build tools in addition to [**`cargo.exe`**][cargo_cli], the standard tool <sup id="anchor_01">[1](#footnote_01)</sup> for [Rust] projects :

| Build&nbsp;tool               | Build&nbsp;file                     | Parent&nbsp;file | Environment(s) |
|-------------------------------|-------------------------------------|----|----|
| [**`cmd.exe`**][cmd_cli] | [`build.bat`](./Chapter01/build.bat)<br/>[`build.properties`](./Chapter01/build.properties) <sup><b>a)</b></sup> | &nbsp; | Windows only |
| [**`cargo.exe`**][cargo_cli]      | [`Cargo.toml`](Chapter01/Cargo.toml) | &nbsp; | Any <sup><b>b)</b></sup> |
| [**`make.exe`**][gmake_cli] | [`Makefile`](Chapter01/Makefile) | [`Makefile.inc`](./Makefile.inc) | Any |
<div style="font-size:90%;margin:-10px 0 10px 8px;">
<sup><b>a)</b></sup> Optional (batch file defines default values).<br/>
<sup><b>b)</b></sup> Here "Any" means "tested on Windows, Cygwin, MSYS2 and Unix".</div>

## <span id="chapter01">Chapter01</span>

The [**`Chapter01`**](Chapter01) code example gives an overview of the [Rust] language through many small source files such as [`arrays.rs`](Chapter01/src/arrays.rs), [`closures.rs`](Chapter01/src/closures.rs), [`enums.rs`](Chapter01/src/enums.rs) and so on :

### <b id="build">`build.bat`</b> <sup id="anchor_02">[2](#footnote_02)</sup>

The default main program [`arrays.rs`](Chapter01/src/arrays.rs) is defined in configuration file [`build.properties`](Chapter01/build.properties):

<pre style="font-size:80%;">
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cd">cd</a></b>
R:\mastering-rust\Chapter01
&nbsp;
<b>&gt; <a href="Chapter01/build.bat">build</a> -verbose clean run</b>
Delete directory "target"
Compile 1 Rust source file to directory "target"
Execute program "target\arrays.exe"
Number: 7
Float: 0.3
</pre>

We can select another main program with option `-main:<name>`, e.g.

<pre style="font-size:80%;">
<b>&gt; <a href="Chapter01/build.bat">build</a> -verbose -main:closures clean run</b>
Delete directory "target"
Compile 1 Rust source file to directory "target"
Execute program "target\closures.exe"
5 doubled is 10
Result from closure: 30
</pre>

We can display the executed command lines with option `-debug`, e.g.

<pre style="font-size:80%;">
<b>&gt; <a href="Chapter01/build.bat">build</a> -debug clean run</b>
[build] Options    : _EDITION=2021 _TARGET=msvc _TIMER=0 _VERBOSE=0
[build] Subcommands: _CLEAN=1 _COMPILE=1 _DOC=0 _DUMP=0 _RUN=1 _TEST=0
[build] Variables  : "CARGO_HOME=%USERPROFILE%\.cargo"
[build] Variables  : "GIT_HOME=C:\opt\Git"
[build] Variables  : "MSYS_HOME=C:\opt\msys64"
[build] Variables  : "RUSTUP_HOME=%USERPROFILE%\.rustup"
[build] Variables  : _CRATE_NAME=arrays _CRATE_TYPE=bin
[build] Variables  : _TARGET_TRIPLE="x86_64-pc-windows-msvc"
[build] rmdir /s /q "R:\mastering-rust\Chapter01\target"
[build] 00000000000000 Target : 'R:\mastering-rust\Chapter01\target\arrays.exe'
[build] 20211025151633 Sources: 'R:\mastering-rust\Chapter01\src\*.rs'
[build] _ACTION_REQUIRED=1
[build] "%USERPROFILE%\.cargo\bin\rustc.exe" -g  --crate-name "arrays" --crate-type bin --edition 2021 --out-dir "R:\mastering-rust\Chapter01\target" --target "x86_64-pc-windows-msvc"  "R:\mastering-rust\Chapter01\src\arrays.rs"
[build] "R:\mastering-rust\Chapter01\target\arrays.exe"
Number: 7
Float: 0.3
[build] _EXITCODE=0
</pre>

### <b id="cargo">`cargo.exe`</b>

The default main program is [`arrays.rs`](Chapter01/src/arrays.rs) is defined in configuration file [`Cargo.toml`](Chapter01/Cargo.toml):

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/build-commands.html">cargo</a> clean & <a href="https://doc.rust-lang.org/cargo/commands/build-commands.html">cargo</a> run --bin=arrays</b>
   Compiling Chapter01 v1.0.0 (R:\mastering-rust\Chapter01)
    Finished dev [unoptimized + debuginfo] target(s) in 2.85s
     Running `target\debug\arrays.exe`
Number: 7
Float: 0.3
</pre>

We can select another main program with option `--bin:<name>`, e.g.

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/build-commands.html">cargo</a> clean & <a href="https://doc.rust-lang.org/cargo/commands/build-commands.html">cargo</a> run --bin=closures</b>
   Compiling Chapter01 v1.0.0 (R:\mastering-rust\Chapter01)
    Finished dev [unoptimized + debuginfo] target(s) in 2.20s
     Running `target\debug\closures.exe`
5 doubled is 10
Result from closure: 30
</pre>

> **:mag_right:** Alternatively one may also add the field `default-run` in the `[package]` section of [`Cargo.toml`](Chapter01/Cargo.toml) (see [**Target Selection**][cargo_run] in the online [Cargo Book][cargo_book]).
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/build-commands.html">cargo</a> --quiet run</b>
> Number: 7
> Float: 0.3
> </pre>

### <b id="make">`make.exe`</b>

<pre style="font-size:80%;">
<b>&gt; <a href="https://www.gnu.org/software/make/manual/html_node/Running.html">make</a> clean run</b>
"C:/opt/Git/usr/bin/rm.exe" -rf "target"
"C:/opt/Git/usr/bin/rm.exe" -f "Cargo.lock"
[ -d "target" ] || "C:/opt/Git/usr/bin/mkdir.exe" -p "target"
"%USERPROFILE%/.cargo/bin/rustc.exe"  --crate-name "arrays" --crate-type bin --edition 2018 --out-dir "target" --target "x86_64-pc-windows-msvc" src/arrays.rs
target\arrays.exe
Number: 7
Float: 0.3
</pre>

`2018` is the default [Rust edition](https://doc.rust-lang.org/edition-guide/editions/) (see above session example); we can select another edition with variable `EDITION`, e.g.

<pre style="font-size:80%;">
<b>&gt; <a href="https://www.gnu.org/software/make/manual/html_node/Running.html">make</a> EDITION=2021 clean run</b>
"C:/opt/Git/usr/bin/rm.exe" -rf "target"
"C:/opt/Git/usr/bin/rm.exe" -f "Cargo.lock"
[ -d "target" ] || "C:/opt/Git/usr/bin/mkdir.exe" -p "target"
"%USERPROFILE%/.cargo/bin/rustc.exe"  --crate-name "arrays" --crate-type bin --edition 2021 --out-dir "target" --target "x86_64-pc-windows-msvc" src/arrays.rs
target\arrays.exe
Number: 7
Float: 0.3
</pre>

## <span id="chapter02">Chapter02</span> [**&#x25B4;**](#top)

<i>WIP</i>

## <span id="chapter03">Chapter03</span>

<i>WIP</i>

## <span id="chapter04">Chapter04</span>

<i>WIP</i>

## <span id="chapter17">Chapter17</span>

## <span id="chapter17_buggie">`buggie`</span>

Code example `buggie` expects a natural number as argument (source file [`src\main.rs`](./Chapter17/buggie/src/main.rs)) :

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/build-commands.html">cargo</a> -q run</b>
Missing argument.
&nbsp;
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/build-commands.html">cargo</a> -q run 10</b>
Fibonacci number at 10 is 34
</pre>

Command `build.bat run` generates the same output :

<pre style="font-size:80%;">
<b>&gt; <a href="./Chapter17/buggie/build.bat">build</a> -verbose run</b>
Compile 1 Rust source file to directory "target"
Execute program "target\main.exe"
Fibonacci number at 10 is 34
</pre>

## <span id="chapter17_rr_demo">`rr_demo`</span>

Code example `rr_demo` depends on Crate [`rand`](https://crates.io/crates/rand) as defined in configuration file [`Cargo.toml`](./Chapter17/rr_demo/Cargo.toml) (source file [`src\main.rs`](./Chapter17/rr_demo/src/main.rs)).

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/build-commands.html">cargo</a> -q run</b>
0 3 7 9 5 2 4 1 6 8 Hello, world!
</pre>

## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> **`cargo` commands** [↩](#anchor_01)

<dl><dd>
<a href="https://doc.rust-lang.org/cargo/commands/cargo.html" rel="external"><b></code>cargo.exe</code></b></a> is actually <i>both</i> a package manager and a build tool for the <a href="https://www.rust-lang.org/" rel="external">Rust</a> language; subcommands are organized is several groups :
</dd>
<dd>
<ul>
<li><a href="https://doc.rust-lang.org/cargo/commands/cargo.html#build-commands">Build commands</a></li>
<li><a href="https://doc.rust-lang.org/cargo/commands/cargo.html#manifest-commands">Manifest commands</a></li>
<li><a href="https://doc.rust-lang.org/cargo/commands/cargo.html#package-commands">Package commands</a></li>
<li><a href="https://doc.rust-lang.org/cargo/commands/cargo.html#publishing-commands">Publish commands</a></li>
</ul>
</dd></dl>

<span id="footnote_02">[2]</span> **`build` subcommands** [↩](#anchor_02)

<dl><dd>
Command <code><b>build.bat</b></code> with no subcommand displays the help message:
</dd>
<dd>
<image src="../docs/images/build_help.png" />
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/July 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_book]: https://doc.rust-lang.org/cargo/
[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
[cargo_run]: https://doc.rust-lang.org/cargo/commands/cargo-run.html#target-selection
[cmd_cli]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cmd
[gmake_cli]: http://www.glue.umd.edu/lsf-docs/man/gmake.html
[rust]: https://www.rust-lang.org/
[rustc_cli]: https://doc.rust-lang.org/rustc/command-line-arguments.html
