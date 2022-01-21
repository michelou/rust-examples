# <span id="top">Running Rust on Microsoft Windows</span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="https://www.rust-lang.org/static/images/rust-logo-blk.svg" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples coming from various websites and books.<br/>
  It also includes several <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a> for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on the <b>Microsoft Windows</b> platform.
  </td>
  </tr>
</table>

[Ada][ada_examples], [Deno][deno_examples], [Golang][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Python][python_examples], [Scala 3][scala3_examples], [TruffleSqueak][trufflesqueak_examples] and [WiX][wix_examples] are other trending topics we are currently monitoring.

## <span id="proj_deps">Project dependencies</span>

This project depends on two external software for the **Microsoft Windows** plaform:

- [Git 2.34][git_downloads] ([*release notes*][git_relnotes])
- [Rust 1.58][rust_downloads] <sup id="anchor_01"><a href="#footnote_01">[1]</a></sup> ([*release notes*][rust_relnotes])

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a Windows installer. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*similar to* the [`/opt/`][linux_opt] directory on Unix).

For instance our development environment looks as follows (*January 2022*) <sup id="anchor_02"><a href="#footnote_02">[2]</a></sup>:

<pre style="font-size:80%;">
C:\opt\Git-2.34.1\      <i>(279 MB)</i>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\   <i>(100 MB)</i>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.rustup\  <i>(593 MB, installed toolchains and configuration options)</i>
</pre>

> **:mag_right:** Git for Windows provides a BASH emulation used to run [**`git`**][git_docs] from the command line (as well as over 250 Unix commands like [**`awk`**][man1_awk], [**`diff`**][man1_diff], [**`file`**][man1_file], [**`grep`**][man1_grep], [**`more`**][man1_more], [**`mv`**][man1_mv], [**`rmdir`**][man1_rmdir], [**`sed`**][man1_sed] and [**`wc`**][man1_wc]).

## <span id="structure">Directory structure</span>

This project is organized as follows:
<pre style="font-size:80%;">
bin\
docs\
mastering-rust\{<a href="mastering-rust/README.md">README.md</a>, ..}
rust-by-example\{<a href="rust-by-example/README.md">README.md</a>, ..}
README.md
<a href="RESOURCES.md">RESOURCES.md</a>
<a href="SETUP.md">SETUP.md</a>
<a href="setenv.bat">setenv.bat</a>
</pre>

where

- directory [**`bin\`**](bin/) contains utility batch scripts.
- directory [**`docs\`**](docs/) contains [Rust][rust_lang] related papers/articles.
- directory [**`mastering-rust\`**](mastering-rust/) contains [Rust][rust_lang] code examples (see [`README.md`](mastering-rust/README.md) file).
- directory [**`rust-by-example\`**](rust-by-example/) contains [Rust][rust_lang] code examples (see [`README.md`](rust-by-example/README.md) file).
- file **`README.md`** is the [Markdown][github_markdown] document for this page.
- file [**`RESOURCES.md`**](RESOURCES.md) is the [Markdown][github_markdown] document presenting external resources.
- file [**`SETUP.md`**](SETUP.md) gives some [Rust][rust_lang] setup details.
- file [**`setenv.bat`**](setenv.bat) is the batch script for setting up our environment.

We also define a virtual drive **`R:`** in our working environment in order to reduce/hide the real path of our project directory (see article ["Windows command prompt limitation"][windows_limitation] from Microsoft Support).

> **:mag_right:** We use the Windows external command [**`subst`**][windows_subst] to create virtual drives; for instance:
>
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst">subst</a> R: <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\workspace\rust-examples</b>
> </pre>

In the next section we give a brief description of the batch files present in this project.

## <span id="batch_commands">Batch commands</span>


We distinguish different sets of batch commands:

1. [**`setenv.bat`**](setenv.bat) - This batch command makes the external tools such as [**`cargo.exe`**][cargo_cli], [**`rustc.exe`**][rustc_cli] directly available from the command prompt.

   <pre style="font-size:80%;">
   <b>&gt; <a href="setenv.bat">setenv</a> help</b>
   Usage: setenv { &lt;option&gt; | &lt;subcommand&gt; }
   &nbsp;
     Options:
       -bash       start Git bash shell instead of Windows command prompt
       -debug      show commands executed by this script
       -verbose    display environment settings
   &nbsp;
     Subcommands:
       help        display this help message</pre>

2. [**`rust-by-example\*\build.bat`**](rust-by-example\01_Display\build-bat) - Finally each example can be built/run using the [**`build`**](rust-by-example\01_Display\build-bat) command.
    > **&#9755;** While using **`cargo`** is the recommanded way to build/run [Rust][rust_lang] projects we also provide the batch command [**`build`**](examples/dotty-example-project/build.bat) in order to exercise the usage of the [**`rustc`**][rustc_cli] command.

## <span id="usage_examples">Usage examples</span>

### **`setenv.bat`**

Command [**`setenv`**](setenv.bat) is executed once to setup your development environment:

<pre style="font-size:80%;">
<b>&gt; <a href="setenv.bat">setenv</a></b>
Tool versions:
   cargo 1.58.1, rustc 1.58.1, rustfmt 1.4.37-stable, rustup 1.24.3,
   pelook v1.73, git 2.34.1.windows.1, diff 3.8, bash 4.4.23(1)-release
&nbsp;
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> cargo rustc rustup pelook</b>
%USERPROFILE%\.cargo\bin\cargo.exe
%USERPROFILE%\.cargo\bin\rustc.exe
%USERPROFILE%\.cargo\bin\rustup.exe
R:\bin\<a href="http://bytepointer.com/tools/index.htm#pelook">pelook.exe</a>
</pre>

Command [**`setenv -verbose`**](setenv.bat) also displays the tool paths:

<pre style="font-size:80%;">
<b>&gt; <a href="setenv.bat">setenv</a> -verbose</b>
Tool versions:
   cargo 1.58.1, rustc 1.58.1, rustfmt 1.4.37-stable, rustup 1.24.3,
   pelook v1.73, git 2.34.1.windows.1, diff 3.8, bash 4.4.23(1)-release
Tool paths:
   %USERPROFILE%\.cargo\bin\cargo.exe
   %USERPROFILE%\.cargo\bin\rustc.exe
   %USERPROFILE%\.cargo\bin\rustfmt.exe
   %USERPROFILE%\.cargo\bin\rustup.exe
   R:\bin\pelook.exe
   C:\opt\Git-2.34.1\bin\git.exe
   C:\opt\Git-2.34.1\mingw64\bin\git.exe
   C:\opt\Git-2.34.1\usr\bin\diff.exe
   C:\opt\Git-2.34.1\bin\bash.exe
Environment variables:
   "CARGO_HOME=%USERPROFILE%\.cargo"
   "GIT_HOME=C:\opt\Git-2.34.1"
   "MSYS_HOME=C:\opt\msys64"
   "RUSTUP_HOME=%USERPROFILE%\.rustup"
</pre>

## <span id="footnotes">Footnotes</span>

<span id="footnote_01">[1]</span> ***LLVM Backend*** [↩](#anchor_01)

<dl><dd>
<a href="https://doc.rust-lang.org/rustc/command-line-arguments.html"><code>rustc</code></a> uses LLVM for code generation (see section <a href="https://rustc-dev-guide.rust-lang.org/backend/codegen.html">Code Generation</a> in the online <a href="https://rustc-dev-guide.rust-lang.org/">Rustc Development Guide</a>).
</dd>
<dd>
<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/rustc/command-line-arguments.html">rustc</a> --version --verbose | <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /b "rustc LLVM"</b>
rustc 1.58.1 (db9d1b20b 2022-01-20)
LLVM version: 13.0.0
</pre>
</dd>
<dd>
<table>
<tr><th>Rustc Version</th><th>LLVM Version</th></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.56.0">1.56.0</a> - <a href="https://github.com/rust-lang/rust/releases/tag/1.58.1">1.58.1</a></td><td><a href="https://releases.llvm.org/13.0.0/docs/ReleaseNotes.html">13.0.0</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.55.0">1.55.0</a></td><td>12.0.1</td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.52.0">1.52.0</a> - 1.54.0</td><td><a href="https://releases.llvm.org/12.0.0/docs/ReleaseNotes.html">12.0.0</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.47.0">1.47.0</a> - 1.51.0</td><td><a href="https://releases.llvm.org/11.0.0/docs/ReleaseNotes.html">11.0.0</a></td></tr>
</table>
</dd></dl>

<span id="footnote_02">[2]</span> ***Downloads*** [↩](#anchor_02)

<dl><dd>
In our case we downloaded the following installation files (see <a href="#proj_deps">section 1</a>):
</dd>
<dd>
<pre style="font-size:80%;">
<a href="https://www.rust-lang.org/tools/install">rust-init.exe</a>                     <i>( 8 MB)</i>
<a href="https://git-scm.com/download/win">PortableGit-2.34.1-64-bit.7z.exe</a>  <i>(42 MB)</i>
</pre>
</dd>
<dd>
Once the <a href="https://github.com/rust-lang/rustup/blob/master/README.md"><b><code>rustup</code></b></a> tool is installed, we can update our installation by simply running <b><code>rustup update</code></b>. 
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/January 2022* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples
[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
[deno_examples]: https://github.com/michelou/deno-examples
[git_docs]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[github_markdown]: https://github.github.com/gfm/
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.34.1.txt
[golang_examples]: https://github.com/michelou/golang-examples
[graalvm_examples]: https://github.com/michelou/graalvm-examples
[haskell_examples]: https://github.com/michelou/haskell-examples
[kotlin_examples]: https://github.com/michelou/kotlin-examples
[linux_opt]: https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/opt.html
[llvm_examples]: https://github.com/michelou/llvm-examples
[man1_awk]: https://www.linux.org/docs/man1/awk.html
[man1_diff]: https://www.linux.org/docs/man1/diff.html
[man1_file]: https://www.linux.org/docs/man1/file.html
[man1_grep]: https://www.linux.org/docs/man1/grep.html
[man1_more]: https://www.linux.org/docs/man1/more.html
[man1_mv]: https://www.linux.org/docs/man1/mv.html
[man1_rmdir]: https://www.linux.org/docs/man1/rmdir.html
[man1_sed]: https://www.linux.org/docs/man1/sed.html
[man1_wc]: https://www.linux.org/docs/man1/wc.html
[python_examples]: https://github.com/michelou/python-examples
[rust_downloads]: https://forge.rust-lang.org/infra/other-installation-methods.html#standalone-installers
[rust_lang]: https://www.rust-lang.org/
[rust_relnotes]: https://github.com/rust-lang/rust/blob/master/RELEASES.md
[rustc_cli]: https://doc.rust-lang.org/rustc/command-line-arguments.html
[rustup_cli]: https://github.com/rust-lang/rustup/blob/master/README.md
[scala3_examples]: https://github.com/michelou/dotty-examples
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples
[windows_limitation]: https://support.microsoft.com/en-gb/help/830473/command-prompt-cmd-exe-command-line-string-limitation
[windows_subst]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst
[wix_examples]: https://github.com/michelou/wix-examples
[zip_archive]: https://www.howtogeek.com/178146/
