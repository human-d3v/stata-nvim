## Syntax

`varlmar` \[`, options`\]

| Options                                                                                                                                                                                                                                             |                      | Description                                                               |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|---------------------------------------------------------------------------|
|                                                                                                                                                                                                                                                     | `mlag(#)`            | use `#` for the maximum order of autocorrelation; default is `mlag(2)`    |
|                                                                                                                                                                                                                                                     | `estimates(estname)` | use previously stored results `estname`; default is to use active results |
|                                                                                                                                                                                                                                                     | `separator(#)`       | draw separator line after every `#` rows                                  |
| `varlmar` can be used only after `var` or `svar`; see [<strong>[TS] var</strong>](http://www.stata.com/help.cgi?var) or [<strong>[TS] var svar</strong>](http://www.stata.com/help.cgi?svar). |                      |                                                                           |
| You must `tsset` your data before using `varlmar`; [<strong>[TS] tsset</strong>](http://www.stata.com/help.cgi?tsset).                                                                                                   |                      |                                                                           |