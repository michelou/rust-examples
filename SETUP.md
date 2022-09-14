# <span id="top">Rust Setup</span> <span style="size:30%;"><a href="README.md">↩</a></span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="../docs/images/rust-logo-blk.svg" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document presents some <a href="https://www.rust-lang.org/" rel="external">Rust</a> setup details on the Windows platform.
  </td>
  </tr>
</table>

In normal case we are facing one of the following situations:
- [Fresh installation](#installation).
- [Installation update](#update]).

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
<b>&gt; <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\downloads\<a href="https://rust-lang.github.io/rustup/installation/index.html">rustup-init</a></b>

Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

It will add the cargo, rustc, rustup and other commands to
Cargo's bin directory, located at:

  <b><a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin</b>

This can be modified with the CARGO_HOME environment variable.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  <b><a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.rustup</b>

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
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> /r <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo *.exe</b>
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
rustc 1.62.1 (e092d0b6b 2022-07-16)
</pre>

## <span id="update">Installation update</span>[**&#x25B4;**](#top)

Command **`rustup update stable`** updates an existing [Rust][rust_lang] installation:

<pre style="font-size:80%;">
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> rustup</b>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin\rustup.exe
&nbsp;
<b>&gt; <a href="https://rust-lang.github.io/rustup/basics.html" rel="external">rustup</a> update stable</b>
info: syncing channel updates for 'stable-x86_64-pc-windows-msvc'
info: latest update on 2022-08-11, rust version 1.63.0 (4b91a6ea7 2022-08-08
[...]
info: downloading component 'rustc'
 56.7 MiB /  56.7 MiB (100 %)   1.2 MiB/s in 52s ETA:  0s
info: downloading component 'rustfmt'
  2.2 MiB /   2.2 MiB (100 %)   1.2 MiB/s in  1s ETA:  0s
[...]
info: installing component 'rustc'
 65.2 MiB /  65.2 MiB (100 %)  12.4 MiB/s in  5s ETA:  0s
info: installing component 'rustfmt'
info: checking for self-updates

  stable-x86_64-pc-windows-msvc updated - rustc 1.63.0 (4b91a6ea7 2022-08-08) (from rustc 1.62.1 (e092d0b6b 2022-07-16))

info: cleaning up downloads & tmp directories
</pre>

> **:mag_right:** We can execute the following command to print an overview of what is installed on our system.
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://rust-lang.github.io/rustup/basics.html" rel="externale">rustup</a> toolchain list</a></b>
> stable-x86_64-pc-windows-msvc (default)
> </pre>

## <span id="cargo-audit">`cargo-audit`</span>

Command [`cargo audit`][cargo_audit] does audit `Cargo.lock` files for crates with security vulnerabilities (based on [`rustsec/advisory-db`](https://github.com/RustSec/advisory-db/)).

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo.html" rel="external">cargo</a> install cargo-audit</b>
    Updating crates.io index
  Downloaded cargo-audit v0.16.0
  Downloaded 1 crate (35.7 KB) in 0.73s
  Installing cargo-audit v0.16.0
  Downloaded fixedbitset v0.4.1
  [...]
  Downloaded libgit2-sys v0.12.26+1.3.0
  Downloaded 100 crates (10.4 MB) in 1m 11s (largest was `libgit2-sys` at 1.5 MB)
   Compiling proc-macro2 v1.0.36
   [...]
   Compiling cargo-audit v0.16.0
    Finished release [optimized] target(s) in 13m 36s
  Installing %CARGO_HOME%\bin\cargo-audit.exe
   Installed package `cargo-audit v0.16.0` (executable `cargo-audit.exe`)
&nbsp;
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo.html" rel="external">cargo</a> audit</b>
    Fetching advisory database from `https://github.com/RustSec/advisory-db.git`
      Loaded 400 security advisories (from %CARGO_HOME%\advisory-db)
    Updating crates.io index
    Scanning Cargo.lock for vulnerabilities (9 crate dependencies)
</pre>

## <span id="footnotes">Footnotes</span>[**&#x25B4;**](#top)

<span id="footnote_01">[1]</span> ***Installation settings*** [↩](#anchor_01)

<dl><dd>
<pre style="font-size:80%;">
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/type">type</a> <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.rustup\settings.toml</b>
default_host_triple = "x86_64-pc-windows-msvc"
default_toolchain = "stable"
profile = "default"
version = "12"
&nbsp;
[overrides]
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/September 2022* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_audit]: https://lib.rs/crates/cargo-audit
[rust_lang]: https://www.rust-lang.org/
[rustc_cli]: https://man.archlinux.org/man/rustc.1.en
