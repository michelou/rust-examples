# <span id="top">Rust Setup</span> <span style="size:30%;"><a href="README.md">↩</a></span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="https://www.rust-lang.org/static/images/rust-logo-blk.svg" width="120" alt="Rust logo"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document presents some <a href="https://www.rust-lang.org/" rel="external">Rust</a> setup details on the Windows platform.
  </td>
  </tr>
</table>

In normal case we are facing one of the following situations:
- [Fresh installation](#installation).
- [Installation update](#updated]).

## <span id="installation">Fresh Installation</span>

Command **`rustup-init --help`** displays the available options:

<pre style="font-size:80%;">
<b>&gt; c:\opt\rust-1.24.3\rustup-init</a> --help</b>
rustup-init 1.24.3 (ce5817a94 2021-05-31)
The installer for rustup

USAGE:
    rustup-init [FLAGS] [OPTIONS]

FLAGS:
    -v, --verbose           Enable verbose output
    -q, --quiet             Disable progress output
    -y                      Disable confirmation prompt.
        --no-modify-path    Don't configure the PATH environment variable
    -h, --help              Prints help information
    -V, --version           Prints version information

OPTIONS:
        --default-host &lt;default-host&gt;              Choose a default host triple
        --default-toolchain &lt;default-toolchain&gt;    Choose a default toolchain to install
        --profile &lt;profile&gt;                        [default: default]  [possible values: minimal, default, complete]
    -c, --component &lt;components&gt;...                Component name to also install
    -t, --target &lt;targets&gt;...                      Target name to also install
</pre>

As a first run let's choose option `"3) Cancel installation"` inorder to *pay attention* to the default settings <sup id="anchor_01"><a href="#footnote_01">[1]</a></sup> with not installation actions:

<pre style="font-size:80%;">
<b>&gt; c:\opt\rust-1.24.3\<a href="https://rust-lang.github.io/rustup/installation/index.html">rustup-init</a></b>

Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

It will add the cargo, rustc, rustup and other commands to
Cargo's bin directory, located at:

  <b>%USERPROFILE%\.cargo\bin</b>

This can be modified with the CARGO_HOME environment variable.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  <b>%USERPROFILE%\.rustup</b>

This can be modified with the RUSTUP_HOME environment variable.

This path will then be added to your PATH environment variable by
modifying the HKEY_CURRENT_USER/Environment/PATH registry key.

You can uninstall at any time with rustup self uninstall and
these changes will be reverted.

Current installation options:

   default host triple: x86_64-pc-windows-msvc
     default toolchain: stable
               profile: default
  modify PATH variable: yes

1) Proceed with installation (default)
2) Customize installation
3) Cancel installation
>3
</pre>

<pre style="font-size:80%;">
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> /r %USERPROFILE%\.cargo *.exe</b>
%USERPROFILE%\.cargo\bin\cargo-clippy.exe
%USERPROFILE%\.cargo\bin\cargo-fmt.exe
%USERPROFILE%\.cargo\bin\cargo-miri.exe
%USERPROFILE%\.cargo\bin\cargo.exe
%USERPROFILE%\.cargo\bin\clippy-driver.exe
%USERPROFILE%\.cargo\bin\rls.exe
%USERPROFILE%\.cargo\bin\rust-gdb.exe
%USERPROFILE%\.cargo\bin\rust-lldb.exe
%USERPROFILE%\.cargo\bin\rustc.exe
%USERPROFILE%\.cargo\bin\rustdoc.exe
%USERPROFILE%\.cargo\bin\rustfmt.exe
%USERPROFILE%\.cargo\bin\rustup.exe
&nbsp;
<b>&gt; <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin\<a href="https://doc.rust-lang.org/rustc/command-line-arguments.html">rustc.exe</a> --version</b>
rustc 1.56.0 (09c42c458 2021-10-18)
</pre>

## <span id="update">Installation update</span>

Command **`rustup update stable`** updates an existing [Rust][rust_lang] installation:

<pre style="font-size:80%;">
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> rustup</b>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin\rustup.exe
&nbsp;
<b>&gt; <a href="https://rust-lang.github.io/rustup/basics.html">rustup</a> update stable</b>
info: syncing channel updates for 'stable-x86_64-pc-windows-msvc'
info: latest update on 2021-09-09, rust version 1.55.0 (c8dfcfe04 2021-09-06)
[...]
 20.1 MiB /  20.1 MiB (100 %)   1.2 MiB/s in 17s ETA:  0s
info: downloading component 'rustc'
 75.4 MiB /  75.4 MiB (100 %)   1.2 MiB/s in  1m  6s ETA:  0s
info: downloading component 'rustfmt'
  2.1 MiB /   2.1 MiB (100 %)   1.2 MiB/s in  1s ETA:  0s
[...]
info: installing component 'rustc'
 75.4 MiB /  75.4 MiB (100 %)  12.0 MiB/s in  6s ETA:  0s
info: installing component 'rustfmt'
info: checking for self-updates

  stable-x86_64-pc-windows-msvc updated - rustc 1.55.0 (c8dfcfe04 2021-09-06) (from rustc 1.54.0 (a178d0322 2021-07-26))

info: cleaning up downloads & tmp directories
</pre>


## <span id="footnotes">Footnotes</span>

<span name="footnote_01">[1]</span> ***Installation settings*** [↩](#anchor_01)

<pre style="margin:0 0 1em 20px; font-size:80%;">
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/type">type</a> <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.rustup\settings.toml</b>
default_host_triple = "x86_64-pc-windows-msvc"
default_toolchain = "stable"
profile = "default"
version = "12"

[overrides]
</pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/October 2021* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[rust_lang]: https://www.rust-lang.org/
