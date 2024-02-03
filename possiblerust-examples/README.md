# <span id="top">Website <i>Possible Rust</i></span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="https://www.rust-lang.org/static/images/rust-logo-blk.svg" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples from the website <a href="https://www.possiblerust.com/" rel="external"><i>Possible Rust</i></a>.<br/>
  It also includes several <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a> for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on a Windows machine.
  </td>
  </tr>
</table>

## <span id="trait_objects">Trait Objects</a>

Code example [`src\main.rs`](./TraitObjects/src/main.rs)

<pre style="font-size:80%;">
<b>&gt; <a href="TraitObjects/build.bat">build</a> -verbose clean run</b>
Delete directory "target"
Compile 1 Rust source file to directory "target"
6
50.26548245743669
</pre>

## <span id="inner_functions">Inner Functions</a> [**&#x25B4;**](#top)

This code example is adapted from the article "[Non-Generic Inner Functions](https://www.possiblerust.com/pattern/non-generic-inner-functions)" by Andrew Brinker, October 2020.

Source file is [`src\main.rs`](./InnerFunctions/src/main.rs) and project files are [`build.bat`](./InnerFunctions/build.bat) and [`Cargo.toml`](./InnerFunctions/Cargo.toml).

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html" rel="external">cargo</a> clean & <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html" rel="external">cargo</a> run</b>
   Compiling Trait_Objects v1.0.0 (R:\possiblerust-examples\InnerFunctions)
    Finished dev [unoptimized + debuginfo] target(s) in 0.44s
     Running `target\debug\main.exe`
path: C:\temp\file.txt
Hello John
path: some\path\with\a
Error: Os { code: 3, kind: NotFound, message: "The system cannot find the path specified." }
error: process didn't exit successfully: `target\debug\main.exe` (exit code: 1)
</pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/February 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
[rustc_cli]: https://man.archlinux.org/man/rustc.1.en
