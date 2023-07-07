# <span id="top">Rust Examples</span> <span style="size:30%;"><a href="../README.md">⬆</a></span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://www.rust-lang.org/" rel="external"><img src="../docs/images/rust-logo-blk.svg"" width="120" alt="Rust project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://www.rust-lang.org/" rel="external">Rust</a> code examples from various websites.<br/>
  It also includes several build scripts (<a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting">batch files</a>) for experimenting with <a href="https://www.rust-lang.org/" rel="external">Rust</a> on a Windows machine.
  </td>
  </tr>
</table>

### <span id="diceroller">`diceroller` Example</span>

Example [`diceroller`](./diceroller/) is presented by Nicolas Fränkel in his blog post ["diceroller, a sample Rust project"](https://blog.frankel.ch/start-rust/8/) (July 2021).

Project file is [`Cargo.toml`](./diceroller/Cargo.toml) and source files are [`src\main.rs`](./diceroller/src/main.rs), [`src\droller\damage.rs`](./diceroller/src/droller/damage.rs), [`src\droller\dice.rs`](./diceroller/src/droller/dice.rs), [`src\droller\mod.rs`](./diceroller/src/droller/mod.rs).

<pre style="font-size:80%;">
<b>diceroller&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html" rel="external">cargo</a> -q run</b>
normal damage: stun: 2, body: 1
killing damage: stun: 8, body: 4 (mult: 2)
killing damage (half): stun: 1, body: 1 (mult: 1)
killing damage (pip): stun: 5, body: 1 (mult: 5)
</pre>

### <span id="rust_ui_druid">`rust-ui-druid` Example</span>

Example [`rust-ui-druid`](./rust-ui-druid/) illustrates the usage of [Druid], a data-oriented Rust UI design toolkit.

Project files are: [`Cargo.toml`](./rust-ui-druid/Cargo.toml), [`src\main.rs`](./rust-ui-druid/src/main.rs).

<pre style="font-size:80%;">
<b>rust-ui-druid&gt; <a href="https://doc.rust-lang.org/cargo/commands/cargo-run.html" rel="external">cargo</a> -q run</b>
</pre>

<img src="images/rust-ui-druid.png" width="300px"/>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/July 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[cargo_cli]: https://doc.rust-lang.org/cargo/commands/cargo.html
[druid]: https://crates.io/crates/druid
