# <span id="top">Playing with Rust on Windows</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="docs/images/rust-logo-blk.svg" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples coming from various websites and books.<br/>
  It also includes several build scripts (<a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a>, <a href="https://makefiletutorial.com/" rel="external">Make scripts</a> and more) for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on a Windows machine.
  </td>
  </tr>
</table>

[Ada][ada_examples], [Akka][akka_examples], [C++][cpp_examples], [Dart][dart_examples], [Deno][deno_examples], [Flix][flix_examples], [Golang][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kafka][kafka_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Python][python_examples], [Scala 3][scala3_examples], [Spark][spark_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples] and [WiX Toolset][wix_examples] are other trending topics we are continuously monitoring.

## <span id="proj_deps">Project dependencies</span>

This project depends on two external software for the **Microsoft Windows** plaform:

- [Git 2.39][git_downloads] ([*release notes*][git_relnotes])
- [Rust 1.67][rust_downloads] <sup id="anchor_01"><a href="#footnote_01">1</a></sup> ([*release notes*][rust_relnotes])

<!--
Rust 1.67.1 -> 2023-01-26
Rust 1.66.0 -> 2022-12-15
-->

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a Windows installer. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*similar to* the [**`/opt/`**][linux_opt] directory on Unix).

For instance our development environment looks as follows (*February 2023*) <sup id="anchor_02">[2](#footnote_02)</sup>:

<pre style="font-size:80%;">
C:\opt\Git-2.39.2\      <i>(314 MB)</i>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\   <i>(100 MB)</i>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.rustup\  <i>(593 MB, installed toolchains and configuration options)</i>
</pre>

> **:mag_right:** Git for Windows provides a BASH emulation used to run [**`git`**][git_docs] from the command line (as well as over 250 Unix commands like [**`awk`**][man1_awk], [**`diff`**][man1_diff], [**`file`**][man1_file], [**`grep`**][man1_grep], [**`more`**][man1_more], [**`mv`**][man1_mv], [**`rmdir`**][man1_rmdir], [**`sed`**][man1_sed] and [**`wc`**][man1_wc]).

## <span id="structure">Directory structure</span> [**&#x25B4;**](#top)

This project is organized as follows:
<pre style="font-size:80%;">
bin\
docs\
examples\{<a href="examples/README.md">README.md</a>, <a href="examples/diceroller/">diceroller</a>, <a href="examples/rust-ui-druid/">rust-ui-druid</a>}
mastering-rust\{<a href="mastering-rust/README.md">README.md</a>, <a href="mastering-rust/Chapter01/">Chapter01</a>, etc.}
possiblerust-examples\{<a href="possiblerust-examples/README.md">README.md</a>, <a href="possiblerust-examples/InnerFunctions/">InnerFunctions</a>, <a href="possiblerust-examples/TraitObjects/">TraitObjects</a>, etc.}
rust-by-example\{<a href="rust-by-example/README.md">README.md</a>, <a href="rust-by-example/01_Display/">01_Display</a>, etc.}
<a href="CONTRIBUTIONS.md">CONTRIBUTIONS.md</a>
README.md
<a href="RESOURCES.md">RESOURCES.md</a>
<a href="SETUP.md">SETUP.md</a>
<a href="setenv.bat">setenv.bat</a>
</pre>

where

- directory [**`bin\`**](bin/) contains utility batch scripts.
- directory [**`docs\`**](docs/) contains [Rust][rust_lang] related papers/articles.
- directory [**`examples\`**](examples/) contains [Rust][rust_lang] code examples (see [**`README.md`**](./examples/README.md)).
- directory [**`mastering-rust\`**](mastering-rust/) contains [Rust][rust_lang] code examples (see [`README.md`](mastering-rust/README.md)).
- directory [**`rust-by-example\`**](rust-by-example/) contains [Rust][rust_lang] code examples (see [`README.md`](rust-by-example/README.md)).
- file [**`CONTRIBUTIONS.md`**](CONTRIBUTIONS.md) gathers reported issues and pull requests to the [Rust][rust_lang] project.
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
    > **&#9755;** While using **`cargo`** is the recommanded way to build/run [Rust][rust_lang] projects we also provide the batch command [**`build.bat`**](examples/dotty-example-project/build.bat) in order to exercise the usage of the [**`rustc.exe`**][rustc_cli] command.

## <span id="usage_examples">Usage examples</span> [**&#x25B4;**](#top)

### **`setenv.bat`**

Command [**`setenv.bat`**](setenv.bat) is executed once to setup your development environment:

<pre style="font-size:80%;">
<b>&gt; <a href="setenv.bat">setenv</a></b>
Tool versions:
   cargo 1.67.1, rustc 1.67.1, rustfmt <a href="https://github.com/rust-lang/rustfmt/blob/master/CHANGELOG.md#151-2022-06-24" rel="external">1.5.1-stable</a>, rustup 1.25.2,
   pelook v1.73, git 2.39.2.windows.1, diff 3.8, bash 4.4.23(1)-release
&nbsp;
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> cargo rustc rustup pelook</b>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin\cargo.exe
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin\rustc.exe
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin\rustup.exe
R:\bin\<a href="http://bytepointer.com/tools/index.htm#pelook">pelook.exe</a>
</pre>

Command [**`setenv.bat`**](setenv.bat) with option **`-verbose`** displays additional information:
- the tool paths (which may not contain the version suffix, i.e. **`C:\opt\Git\bin\git.exe`** in some installations),
- the environment variables *defined locally* within this session,
- and the path associations (i.e. **`F:\`** in this case, but other drive names may be displayed as path associations are *globally defined*).

<pre style="font-size:80%;">
<b>&gt; <a href="setenv.bat">setenv</a> -verbose</b>
Tool versions:
   cargo 1.67.1, rustc 1.67.1, rustfmt <a href="https://github.com/rust-lang/rustfmt/blob/master/CHANGELOG.md" rel="external">1.5.1-stable</a>, rustup 1.25.2,
   pelook v1.73, git 2.39.2.windows.1, diff 3.8, bash 4.4.23(1)-release
Tool paths:
   <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin\<a href="https://doc.rust-lang.org/cargo/commands/">cargo.exe</a>
   %USERPROFILE%\.cargo\bin\<a href="https://doc.rust-lang.org/rustc/command-line-arguments.html">rustc.exe</a>
   %USERPROFILE%\.cargo\bin\<a href="https://rust-lang.github.io/rustfmt">rustfmt.exe</a>
   %USERPROFILE%\.cargo\bin\<a href="https://rust-lang.github.io/rustup/basics.html">rustup.exe</a>
   R:\bin\pelook.exe
   C:\opt\Git-2.39.2\bin\git.exe
   C:\opt\Git-2.39.2\mingw64\bin\git.exe
   C:\opt\Git-2.39.2\usr\bin\diff.exe
   C:\opt\Git-2.39.2\bin\bash.exe
Environment variables:
   "CARGO_HOME=%USERPROFILE%\.cargo"
   "GIT_HOME=C:\opt\Git-2.39.2"
   "MSYS_HOME=C:\opt\msys64"
   "RUSTUP_HOME=%USERPROFILE%\.rustup"
Path associations:
   R:\: => C:\Users\michelou\workspace-perso\rust-examples
</pre>

## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***LLVM Backend*** [↩](#anchor_01)

<dl><dd>
<a href="https://doc.rust-lang.org/rustc/command-line-arguments.html" rel="external"><code>rustc.exe</code></a> uses LLVM for code generation (see section <a href="https://rustc-dev-guide.rust-lang.org/backend/codegen.html" rel="external">Code Generation</a> in the online <a href="https://rustc-dev-guide.rust-lang.org/" rel="external">Rustc Development Guide</a>).
</dd>
<dd>
<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/rustc/command-line-arguments.html">rustc</a> --version --verbose | <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /b "rustc LLVM"</b>
rustc 1.67.1 (d5a82bbd2 2023-02-07)
LLVM version: 15.0.6
</pre>
</dd>
<dd>
<table>
<tr><th>Rustc Version</th><th>LLVM Version</th></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.67.1" rel="external">1.67.1</a></td><td><a href="https://discourse.llvm.org/t/llvm-15-0-6-released/66899" rel="external">15.0.6</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.66.1" rel="external">1.66.1</a></td><td><a href="https://discourse.llvm.org/t/llvm-15-0-2-released/65695" rel="external">15.0.2</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.66.0" rel="external">1.66.0</a></td><td><a href="https://releases.llvm.org/15.0.0/docs/ReleaseNotes.html" rel="external">15.0.0</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.64.0" rel="external">1.64.0</a></td><td><a href="https://releases.llvm.org/14.0.0/docs/ReleaseNotes.html">14.0.6</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.62.0" rel="external">1.62.0</a> - <a href="https://github.com/rust-lang/rust/releases/tag/1.63.0" rel="external">1.63.0</a></td><td><a href="https://releases.llvm.org/14.0.5/docs/ReleaseNotes.html" rel="external">14.0.5</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.60.0" rel="external">1.60.0</a> - <a href="https://github.com/rust-lang/rust/releases/tag/1.61.0" rel="external">1.61.0</a></td><td><a href="https://releases.llvm.org/14.0.0/docs/ReleaseNotes.html" rel="external">14.0.0</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.56.0">1.56.0</a> - <a href="https://github.com/rust-lang/rust/releases/tag/1.59.https0">1.59.0</a></td><td><a href="https://releases.llvm.org/13.0.0/docs/ReleaseNotes.html">13.0.0</a></td></tr>
<tr><td><a href="https://github.com/rust-lang/rust/releases/tag/1.55.0">1.55.0</a></td><td><a href="https://releases.llvm.org/12.0.0/docs/ReleaseNotes.html" rel="external">12.0.1</a></td></tr>
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
<a href="https://git-scm.com/download/win">PortableGit-2.39.2-64-bit.7z.exe</a>  <i>(46 MB)</i>
</pre>
</dd>
<dd>
Once the <a href="https://github.com/rust-lang/rustup/blob/master/README.md"><b><code>rustup.exe</code></b></a> tool is installed, we can update our installation by simply running <a href="https://rust-lang.github.io/rustup/basics.html"><b><code>rustup.exe update</code></b></a>. 
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/February 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples
[akka_examples]: https://github.com/michelou/akka-examples
[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
[cpp_examples]: https://github.com/michelou/cpp-examples
[dart_examples]: https://github.com/michelou/dart-examples
[deno_examples]: https://github.com/michelou/deno-examples
[flix_examples]: https://github.com/michelou/flix-examples
[git_docs]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[github_markdown]: https://github.github.com/gfm/
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.39.2.txt
[golang_examples]: https://github.com/michelou/golang-examples
[graalvm_examples]: https://github.com/michelou/graalvm-examples
[haskell_examples]: https://github.com/michelou/haskell-examples
[kafka_examples]: https://github.com/michelou/kafka-examples
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
[spark_examples]: https://github.com/michelou/spark-examples
[spring_examples]: https://github.com/michelou/spring-examples
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples
[windows_limitation]: https://support.microsoft.com/en-gb/help/830473/command-prompt-cmd-exe-command-line-string-limitation
[windows_subst]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst
[wix_examples]: https://github.com/michelou/wix-examples
[zip_archive]: https://www.howtogeek.com/178146/
