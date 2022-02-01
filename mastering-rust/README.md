# <span id="top">Book <i>Mastering Rust</i></span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="https://www.rust-lang.org/static/images/rust-logo-blk.svg" width="120" alt="Rust logo"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">Directory <code>mastering-rust\</code> gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples from the Book <a href="https://www.packtpub.com/product/mastering-rust-second-edition/9781789346572" rel="external">"Mastering Rust"</a>.<br/>
  It also includes several <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a> for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on the <b>Microsoft Windows</b> platform.
  </td>
  </tr>
</table>

Let's choose example [**`Chapter01`**](Chapter01) to demonstrate the usage of the build tools we do support:

<pre style="font-size:80%;">
<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cd">cd</a></b>
R:\mastering-rust\Chapter01
</pre>

Build tools rely on one or more configuration files to achieve their tasks. In our case we created the following configuration files for [**`Chapter01`**](Chapter01):

| Build tool                    | Configuration file(s)                    |
|-------------------------------|------------------------------------------|
[**`build.bat`**](./Chapter01/build.bat) | [**`build.properties`**](./Chapter01/build.properties)<sup><b>1)</b></sup> |
| [**`cargo.exe`**][cargo_cli]      | [**`Cargo.toml`**](Chapter01/Cargo.toml) |
<div style="font-size:90%;margin:-10px 0 10px 8px;"><sup><b>1)</b></sup> Optional.</div>

## <b id="build">`build.bat`</b>

The default main program [`arrays.rs`](Chapter01/src/arrays.rs) is defined in configuration file [`build.ini`](Chapter01/build.ini):

<pre style="font-size:80%;">
<b>&gt; <a href="Chapter01/build.bat">build</a> -verbose clean run</b>
Delete directory "target"
Compile 1 Rust source files to directory "target"
Execute program "target\arrays.exe"
Number: 7
Float: 0.3
</pre>

We can select another main program with option `-main:<name>`, e.g.

<pre style="font-size:80%;">
<b>&gt; <a href="Chapter01/build.bat">build</a> -verbose -main:closures clean run</b>
Delete directory "target"
Compile 1 Rust source files to directory "target"
Execute program "target\closures.exe"
5 doubled is 10
Result from closure: 30
</pre>

## <b id="cargo">`cargo.exe`</b>

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

***

*[mics](https://lampwww.epfl.ch/~michelou/)/February 2022* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_book]: https://doc.rust-lang.org/cargo/
[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
[cargo_run]: https://doc.rust-lang.org/cargo/commands/cargo-run.html#target-selection
