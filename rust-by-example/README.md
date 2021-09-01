# <span id="top">Book <i>Rust by Example</i></span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="https://www.rust-lang.org/static/images/rust-logo-blk.svg" width="120" alt="Rust logo"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples from the Book <a href="https://doc.rust-lang.org/rust-by-example/" rel="external">"Rust by Example"</a>.<br/>
  It also includes several <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a> for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on the <b>Microsoft Windows</b> platform.
  </td>
  </tr>
</table>

## `01_Display`

Command `cargo run` executes the Rust program [`main.rs`](./01_Display/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/">cargo</a> clean &amp; <a href="https://doc.rust-lang.org/cargo/commands/">cargo</a> run</b>
   Compiling _01_Display v1.0.0 (R:\rust-by-example\01_Display)
    Finished dev [unoptimized + debuginfo] target(s) in 2.81s
     Running `target\debug\main.exe`
Compare structures:
Display: (0, 14)
Debug: MinMax(0, 14)
The big range is (-300, 300) and the small is (-3, 3)
Compare points:
Display: x: 3.3, y: 7.2
Debug: Point2D { x: 3.3, y: 7.2 }
</pre>


## `01_HelloWorld`

Command `build run` executes the Rust program [`main.rs`](./01_Helloworld/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="./01_HelloWorld/build.bat">build</a> -verbose clean run</b>
Delete directory "target"
Compile 1 Rust source files to directory "target"
Hello World!
</pre>

## `02_Literals`

Command `cargo run` executes the Rust program [`main.rs`](./02_Literals/src/main.rs) :

<pre style="font-size:80%;">
<b>&gt; <a href="https://doc.rust-lang.org/cargo/commands/">cargo</a> clean && <a href="https://doc.rust-lang.org/cargo/commands/">cargo</a> run</b>
   Compiling _02_Primitives v1.0.0 (R:\rust-by-example\02_Literals)
    Finished dev [unoptimized + debuginfo] target(s) in 2.53s
     Running `target\debug\main.exe`
1 + 2 = 3
1 - 2 = -1
true AND false is false
true OR false is true
NOT true is false
0011 AND 0101 is 0001
0011 OR 0101 is 0111
0011 XOR 0101 is 0110
1 << 5 is 32
0x80 >> 2 is 0x20
One million is written as 1000000
</pre>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/September 2021* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
