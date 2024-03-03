# <span id="top">Rust Setup</span> <span style="size:30%;"><a href="README.md">↩</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="./docs/images/rust-logo-blk.svg" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This document presents some <a href="https://www.rust-lang.org/" rel="external">Rust</a> setup details on the Windows platform.
  </td>
  </tr>
</table>

In normal case we are facing one of the following situations:
- [Fresh installation](#installation).
- [Installation update](#update).
- [Some useful crates](#crates).

## <span id="installation">Fresh Installation</span> [**&#x25B4;**](#top)

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

As a first run let's choose option `"3) Cancel installation"` inorder to *pay attention* to the default settings <sup id="anchor_01">[1](#footnote_01)</sup> with not installation actions:

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
rustc 1.74.0 (79e9716c9 2023-11-13)
</pre>

## <span id="update">Installation update</span> [**&#x25B4;**](#top)

Command **`rustup update stable`** <sup id="anchor_02">[2](#footnote_02)</sup>  updates an existing [Rust][rust_lang] installation:

<pre style="font-size:80%;">
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1">where</a> rustup</b>
<a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\.cargo\bin\rustup.exe
&nbsp;
<b>&gt; <a href="https://rust-lang.github.io/rustup/basics.html" rel="external">rustup</a> update stable</b>
info: syncing channel updates for 'stable-x86_64-pc-windows-msvc'
info: latest update on 2024-02-08, rust version 1.76.0 (07dca489a 2024-02-04)
[...]
info: downloading component 'rustc'
 62.8 MiB /  62.8 MiB (100 %)   1.3 MiB/s in 50s ETA:  0s
info: downloading component 'rustfmt'
  1.5 MiB /   1.5 MiB (100 %)   1.3 MiB/s in  1s ETA:  0s
[...]
info: installing component 'rustc'
 62.8 MiB /  62.8 MiB (100 %)  13.4 MiB/s in  4s ETA:  0s
info: installing component 'rustfmt'

  stable-x86_64-pc-windows-msvc updated - rustc 1.76.0 (07dca489a 2024-02-04) (from rustc 1.75.0 (82e1608df 2023-12-21))

info: checking for self-updates
</pre>

> **:mag_right:** The following command prints an overview of what is installed on our system.
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://rust-lang.github.io/rustup/basics.html" rel="externale">rustup</a> toolchain list</a></b>
> stable-x86_64-pc-windows-msvc (default)
> </pre>
> The following command lists only installed components :
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://rust-lang.github.io/rustup/basics.html" rel="externale">rustup</a> component list --installed</b>
> cargo-x86_64-pc-windows-msvc
> clippy-x86_64-pc-windows-msvc
> rust-docs-x86_64-pc-windows-msvc
> rust-std-x86_64-pc-windows-gnu
> rust-std-x86_64-pc-windows-msvc
> rustc-x86_64-pc-windows-msvc
> rustfmt-x86_64-pc-windows-msvc
> </pre>

Command **`rustup component add rustfmt`** installs the formatting tool [`rustfmt`](https://github.com/rust-lang/rustfmt) into the `CARGO_HOME` directory:

<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/where" rel="external">where</a> rustfmt</b>
%CARGO_HOME%\bin\rustfmt.exe

<b>&gt; <a href="https://linuxcommandlibrary.com/man/rustfmt">rustfmt</a> --version</b>
rustfmt 1.6.0-stable (5680fa18 2023-10-03)
</pre>

<!--=======================================================================-->

## <span id="crates">Some useful crates</span> [**&#x25B4;**](#top)

### <span id="cargo-audit">`cargo-audit` crate</span>

Command [**`cargo audit`**][cargo_audit] <sup id="anchor_03">[3](#footnote_03)</sup> does audit `Cargo.lock` files for crates with security vulnerabilities (based on [`rustsec/advisory-db`](https://github.com/RustSec/advisory-db/)).

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo.html" rel="external">cargo</a> install <a href="https://crates.io/crates/cargo-audit" rel="external">cargo-audit</a></b>
    Updating crates.io index
  Downloaded cargo-audit v0.17.5
  Downloaded 1 crate (35.7 KB) in 0.73s
  Installing cargo-audit v0.17.5
  Downloaded fixedbitset v0.4.2
  [...]
  Downloaded libgit2-sys v0.14.0+1.5.0
  Downloaded 100 crates (10.4 MB) in 1m 11s (largest was `libgit2-sys` at 1.5 MB)
   Compiling proc-macro2 v1.0.47
   [...]
   Compiling cargo-audit v0.17.5
    Finished release [optimized] target(s) in 13m 36s
  Installing %CARGO_HOME%\bin\cargo-audit.exe
   Installed package `cargo-audit v0.17.5` (executable `cargo-audit.exe`)
&nbsp;
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo.html" rel="external">cargo</a> audit</b>
    Fetching advisory database from `https://github.com/RustSec/advisory-db.git`
      Loaded 487 security advisories (from %CARGO_HOME%\advisory-db)
    Updating crates.io index
    Scanning Cargo.lock for vulnerabilities (9 crate dependencies)
</pre>

### <span id="crates_windows">`windows`/`windows-sys` crates</span>

The [`windows`](https://crates.io/crates/windows)/[`windows-sys`](https://crates.io/crates/windows-sys) crates provide a natural and idiomatic way for [Rust][rust_lang] developers to call Windows APIs.

<!--=======================================================================-->

## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

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

<span id="footnote_02">[2]</span> **`rustup` *command options*** [↩](#anchor_02)

<dl><dd>
Option <code>--installed</code> displays the list of <i>installed</i> (instead of <i>available</i>) Rust components :
<pre style="font-size:80%">
<b>&gt; <a href="https://rust-lang.github.io/rustup/basics.html" rel="external">rustup</a> component list --installed</b>
cargo-x86_64-pc-windows-msvc
clippy-x86_64-pc-windows-msvc
rust-docs-x86_64-pc-windows-msvc
rust-std-x86_64-pc-windows-gnu
rust-std-x86_64-pc-windows-msvc
rustc-x86_64-pc-windows-msvc
rustfmt-x86_64-pc-windows-msvc
</pre>
</dd></dl>

<span id="footnote_03">[3]</span> ***Cargo command options*** [↩](#anchor_03)

<dl><dd>
Option <code>--list</code> displays the list of available Cargo commands :
<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo.html" rel="external">cargo</a> --list</b>
Installed Commands:
    [...]
    b                    alias: build
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-bench.html"><b>bench</b></a>                Execute all benchmarks of a local package
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-build.html"><b>build</b></a>                Compile a local package and all of its dependencies
    c                    alias: check
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-check.html"><b>check</b></a>                Check a local package and all of its dependencies for errors
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-clean.html"><b>clean</b></a>                Remove artifacts that cargo has generated in the past
    d                    alias: doc
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-doc.html"><b>doc</b></a>                  Build a package's documentation
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-fetch.html"><b>fetch</b></a>                Fetch dependencies of a package from the network
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-fix.html"><b>fix</b></a>                  Automatically fix lint warnings reported by rustc
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-help.html"><b>help</b></a>                 Displays help for a cargo subcommand
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-init.html"><b>init</b></a>                 Create a new cargo package in an existing directory
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-install.html"><b>install</b></a>              Install a Rust binary. Default location is $HOME/.cargo/bin
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-locate-project.html"><b>locate-project</b></a>       Print a JSON representation of a Cargo.toml file's location
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-new.html"><b>new</b></a>                  Create a new cargo package at &lt;path&gt;
    r                    alias: run
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html"><b>run</b></a>                  Run a binary or example of the local package
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-rustc.html"><b>rustc</b></a>                Compile a package, and pass extra options to the compiler
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-rustdoc.html"><b>rustdoc</b></a>              Build a package's documentation, using specified custom flags.
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-search.html"><b>search</b></a>               Search packages in crates.io
    t                    alias: test
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-test.html"><b>test</b></a>                 Execute all unit and integration tests and build examples of a local package
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-tree.html"><b>tree</b></a>                 Display a tree visualization of a dependency graph
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-uninstall.html"><b>uninstall</b></a>            Remove a Rust binary
    <a href="https://doc.rust-lang.org/cargo/commands/cargo-update.html"><b>update</b></a>               Update dependencies as recorded in the local lock file
    [...]
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/March 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_audit]: https://lib.rs/crates/cargo-audit
[rust_lang]: https://www.rust-lang.org/
[rustc_cli]: https://man.archlinux.org/man/rustc.1.en
