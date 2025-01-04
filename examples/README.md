# <span id="top">Rust Examples</span> <span style="font-size:90%;">[⬆](../README.md#top)</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="../docs/images/rust-logo-blk.svg"" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples from various websites.<br/>
  It also includes several build scripts (<a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a>, <a href="https://doc.rust-lang.org/cargo/reference/manifest.html">Cargo files</a>) for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on a Windows machine.
  </td>
  </tr>
</table>

### <span id="diceroller">`diceroller` Example</span>

Example [`diceroller`](./diceroller/) is presented by Nicolas Fränkel in his blog post ["diceroller, a sample Rust project"](https://blog.frankel.ch/start-rust/8/) (July 2021). The project has the following directory structure :
<pre style="font-size:80%;margin-top:-16px;">
<b>diceroller&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree" rel="external">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr" rel="external">findstr</a> /v /b [A-Z]</b>
|   <a href="./diceroller/00download.txt">00download.txt</a>
|   <a href="./diceroller/Cargo.toml">Cargo.toml</a>
\---<b>src</b>
    |   <a href="./diceroller/src/main.rs">main.rs</a>
    \---<b>droller</b>
            <a href="./diceroller/src/droller/damage.rs">damage.rs</a>
            <a href="./diceroller/src/droller/dice.rs">dice.rs</a>
            <a href="./diceroller/src/droller/mod.rs">mod.rs</a>
</pre>

We get the following output when executing the [`cargo`][cargo_cli] command :
<pre style="font-size:80%; margin-top:-16px;">
<b>diceroller&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html" rel="external">cargo</a> -q run</b>
normal damage: stun: 2, body: 1
killing damage: stun: 8, body: 4 (mult: 2)
killing damage (half): stun: 1, body: 1 (mult: 1)
killing damage (pip): stun: 5, body: 1 (mult: 5)
</pre>

<!--=======================================================================-->

### <span id="factorials">`factorials` Example</span> [**&#x25B4;**](#top)

Example [`factorials`](./factorials/) is presented by Oopscene in his blog post ["C++ vs.Rust: Factorial"](https://oopscenities.net/2023/02/22/factorial-in-rust-vs-factorial-in-c/) (February 2023). The project is organized as follows :
<pre style="font-size:80%;margin-top:-16px;">
<b>factorials&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /v /b [A-Z]</b>
|   <a href="./factorials/00download.txt">00download.txt</a>
|   <a href="./factorials/build.bat">build.bat</a>
|   <a href="./factorials/Cargo.toml">Cargo.toml</a>
\---<b>src</b>
    \---<b>main</b>
        \---<b>rust</b>
                <a href="./factorials/src/main/rust/main.rs">main.rs</a>
</pre>

We get the following output when executing the [`cargo`][cargo_cli] command :
<pre style="font-size:80%;margin-top:16px;">
<b>factorials&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html" rel="external">cargo</a> run</b>
   Compiling factorials v0.1.0 (K:\examples\factorials)
    Finished dev [unoptimized + debuginfo] target(s) in 0.38s
     Running `target\debug\main.exe`
factorial(10) = 3628800
non_recursive_factorial(10) = 3628800
factorial_with_for(10) = 3628800
</pre>

And with command [`build.bat`](./factorials/build.bat) we get the following output :
<pre style="font-size:80%;margin-top:16px;">
<b>factorials&gt; <a href="./factorials/build.bat">build</a> -verbose run</b>
Compile 1 Rust source file to directory "target"
factorial(10) = 3628800
non_recursive_factorial(10) = 3628800
factorial_with_for(10) = 3628800
</pre>

<!--=======================================================================-->

### <span id="rust_ui_druid">`rust-ui-druid` Example</span> [**&#x25B4;**](#top)

Example [`rust-ui-druid`](./rust-ui-druid/) illustrates the usage of [Druid], a data-oriented Rust UI design toolkit. The project is organized as follows :
<pre style="font-size:80%;margin-top:-16px;">
<b>rust-ui-druid&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree">tree</a> /a /f . | <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr">findstr</a> /v /b [A-Z]</b>
|   <a href="./rust-ui-druid/00download.txt">00download.txt</a>
|   <a href="./rust-ui-druid/Cargo.toml">Cargo.toml</a>
\---<b>src</b>
        <a href="./rust-ui-druid/src/main.rs">main.rs</a>
</pre>

We get the following output when executing the [`cargo`][cargo_cli] command :
<pre style="font-size:80%;margin-top:-16px;">
<b>rust-ui-druid&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html" rel="external">cargo</a> -q run</b>
</pre>

<img src="images/rust-ui-druid.png" width="300px"/>

<!--=======================================================================-->

### <span id="sorter">`sorter` Example</span> [**&#x25B4;**](#top)

This project has the following directory structure :

<pre style="font-size:80%;">
<b>sorter&gt; <a href="">tree</a> /f /a . | <a href="">findstr</a> /v /b [A-Z]</b>
|   <a href="./sorter/build.bat">build.bat</a>
|   <a href="./sorter/Cargo.toml">Cargo.toml</a>
\---<b>src</b>
    \---<b>main</b>
        \---<b>rust</b>
                <a href="./sorter/src/main/rust/main.rs">main.rs</a>
</pre>

Command [**`cargo`**][cargo_cli]`run` genrated and execute the Rust program `target\debug\main.exe` :

<pre style="font-size:80%;">
<b>sorter&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo-clean.html">cargo clean</a> &amp; <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html">cargo run</a></b>
     Removed 884 files, 148.1MiB total
    Updating crates.io index
     Locking 22 packages to latest compatible versions
      Adding wasi v0.11.0+wasi-snapshot-preview1 (latest: v0.13.2+wasi-0.2.1)
   [...]
   Compiling rayon v1.10.0
   [...]
   Compiling rand v0.9.0-alpha.2
   Compiling sorter v0.1.0 (F:\examples\sorter)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 8.33s
     Running `target\debug\main.exe`
random numbers: [-105, 108, -84, -75, 45, 26, 29, -106, 83, 16]
sorted numbers: [-106, -105, -84, -75, 16, 26, 29, 45, 83, 108]
</pre>

Command [**`build.bat`**](./sorter/build.bat)`-verbose clean run` generates and executes the Rust program `target\main.exe` :

<pre style="font-size:80%;">
<b>sorter&gt; <a href="./sorter/build.bat">build</a> -verbose clean run</b>
Download library "rand-0.9.0-alpha.2.zip" to directory "target"
Download library "rayon-1.10.0.zip" to directory "target"
Build library dependency in directory "target\rand-0.9.0-alpha.2"
Build library dependency in directory "target\rayon-1.10.0"
Compile 1 Rust source file to directory "target"
random numbers: [94, -79, -93, 123, 77, 99, -18, 35, -92, -72]
sorted numbers: [-93, -92, -79, -72, -18, 35, 77, 94, 99, 123]
</pre>

> **:mag_right:** Output files in directory <code>target\\</code> are generated as follows when running batch file <a href="./sorter/build.bat"><code>build.bat</code></a> :
> <ol>
> <li>we download the library source archives our program depends on, namely <a href="https://crates.io/crates/rand" rel="external"><code>rand-0.9.0-alpha.2.zip</code></a> and <a href="https://crates.io/crates/rayon" rel="external"><code>rayon-1.10.0.zip</code></a>.</li>
> <li>we build both libraries with command <code>cargo build</code>.</li>
> <li>we copy <code>.dll</code> and <code>.rlib</code> files from <code>rand-0.9.0-alpha.2\target\debug\deps\</code> and <code>rayon-1.10.0\target\debug\deps\</code> to subdirectory <code>deps\</code>.</li>
> <li>we generate the Rust program <code>main.exe</code>.</li>
> </ol>
> For instance :
> <pre style="font-size:80%;">
> <b>&gt; <a href="">dir</a> /s /b target\deps | <a href="">sed</a> -e 's/^.*target\\\//g'& dir /b target</b>
> deps\libbyteorder.rlib
> deps\libcfg_if.rlib
> deps\libcrossbeam_deque.rlib
> deps\libcrossbeam_epoch.rlib
> deps\libcrossbeam_utils.rlib
> deps\libeither.rlib
> deps\libgetrandom.rlib
> deps\libppv_lite86.rlib
> deps\libproc_macro2.rlib
> deps\libquote.rlib
> deps\librand.rlib
> deps\librand_chacha.rlib
> deps\librand_core.rlib
> deps\librayon.rlib
> deps\librayon_core.rlib
> deps\libsyn.rlib
> deps\libunicode_ident.rlib
> deps\libzerocopy.rlib
> deps\zerocopy_derive.dll
> deps
> main.exe
> rand-0.9.0-alpha.2
> rand-0.9.0-alpha.2.zip
> rayon-1.10.0
> rayon-1.10.0.zip
> </pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/January 2025* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
[druid]: https://crates.io/crates/druid
