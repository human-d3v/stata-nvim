## Syntax

Basic syntax

`irtgraph iif`
\[[varlist](http://www.stata.com/help.cgi?varlist)\]
\[`, options`\]

Full syntax

`irtgraph iif`
`(`[varlist](http://www.stata.com/help.cgi?varlist)
\[`, line_options`\]`)`
`(`[varlist](http://www.stata.com/help.cgi?varlist)
\[`, line_options`\]`)` \[...\] \[`, options`\]

`varlist` is a list of items from the currently fitted IRT model.

| Options                                                                                                                                                                                                                                              |                                     | Description                                                                                                                                                           |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Plots                                                                                                                                                                                                                                                |                                     |                                                                                                                                                                       |
|                                                                                                                                                                                                                                                      | `range(# #)`                        | plot over theta = `#` to `#`                                                                                                                                          |
| Line                                                                                                                                                                                                                                                 |                                     |                                                                                                                                                                       |
|                                                                                                                                                                                                                                                      | `line_options`                      | affect rendition of the plotted IIFs                                                                                                                                  |
| Add plots                                                                                                                                                                                                                                            |                                     |                                                                                                                                                                       |
|                                                                                                                                                                                                                                                      | `addplot(plot)`                     | add other plots to the IIF plot                                                                                                                                       |
| Y axis, X axis, Titles, Legend, Overall                                                                                                                                                                                                              |                                     |                                                                                                                                                                       |
|                                                                                                                                                                                                                                                      | `twoway_options`                    | any options other than `by()` documented in [<strong>[G-3]</strong> <em>twoway_options</em>](http://www.stata.com/help.cgi?twoway_options) |
| Data                                                                                                                                                                                                                                                 |                                     |                                                                                                                                                                       |
|                                                                                                                                                                                                                                                      | `n(#)`                              | evaluate IIFs at `#` points; default is `n(300)`                                                                                                                      |
|                                                                                                                                                                                                                                                      | `data(filename`\[`, replace`\]`)` | save plot data to a file                                                                                                                                              |
| `line_options` in `(varlist, line_options)` override the same options specified in `options`. <span options="menu_irt">{marker menu\_irt}_{nobreak None} {title None:Menu} {phang None} **Statistics &gt; IRT (item response theory)** |                                     |                                                                                                                                                                       |