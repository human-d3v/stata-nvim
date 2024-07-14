## Syntax

`graph matrix`
[varlist](http://www.stata.com/help.cgi?varlist)
_\[`if`\] \[`in`\]_ \[`weight`\] \[`,`
`options`\]

|                                                                                                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `options`                                                                                                                                           | Description {p2line None}                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `half`                                                                                                                                              | draw lower triangle only                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `marker_options`                                                                                                                                    | look of markers                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `marker_label_options`                                                                                                                              | include labels on markers                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `jitter(relativesize)`                                                                                                                          | perturb location of markers                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `jitterseed(#)`                                                                                                                                 | random-number seed for `jitter()`                                                                                                                                                                                                                                                                                                                                                                                                            |
| `diagonal:(stringlist,` ...`)`                                                                                                                  | override text on diagonal                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `diagopts(textbox_options)`                                                                                                                     | rendition of text on diagonal                                                                                                                                                                                                                                                                                                                                                                                                                |
| [<strong>scale(</strong><var class="command">#</var><strong>)</strong>](http://www.stata.com/help.cgi?scale_option)      | overall size of symbols, labels, etc.                                                                                                                                                                                                                                                                                                                                                                                                        |
| `iscale(`\[`*`\]`#)`                                                                                                                              | size of symbols, labels, within plots                                                                                                                                                                                                                                                                                                                                                                                                        |
| `maxes:(axis_scale_options`                                                                                                                       |                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `axis_label_options)`                                                                                                                             | labels, ticks, grids, log scales, etc.                                                                                                                                                                                                                                                                                                                                                                                                       |
| `axis_label_options`                                                                                                                                | axis-by-axis control                                                                                                                                                                                                                                                                                                                                                                                                                         |
| [<strong>by(</strong><var class="command">varlist</var><strong>, ...)</strong>](http://www.stata.com/help.cgi?by_option) | repeat for subgroups                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `std_options`                                                                                                                                       | titles, aspect ratio, saving to disk {p2line None} {phang None} All options allowed by `graph twoway scatter` are also allowed, but they are ignored. {phang None} `half`, `diagonal()`, `scale()`, and `iscale()` are `unique`; `jitter()` and `jitterseed()` are `rightmost` and `maxes()` is `merged-implicit`; see [<strong>repeated options</strong>](http://www.stata.com/help.cgi?repeated%20options). |

`stringlist,` ..., the argument allowed by `diagonal()`, is defined

\[{`.`\|`"string"`<span
options=")-">{c )-}_\] \[ <span options="-(">{c
-(}_`.`\|`"string"`} ... \]
\[`, textbox_options`\]

`aweight`s, `fweight`s, and `pweight`s are allowed; see
[<strong>weight</strong>](http://www.stata.com/help.cgi?weight).
Weights affect the size of the markers. See `Weighted markers` in
[<strong>[G-2]</strong> graph twoway scatter](http://www.stata.com/help.cgi?scatter).