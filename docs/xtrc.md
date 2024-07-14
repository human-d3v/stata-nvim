## Syntax

`xtrc`
[depvar](http://www.stata.com/help.cgi?depvar)
[indepvars](http://www.stata.com/help.cgi?indepvars)
_\[`if`\] \[`in`\]_ \[`, options`\]

| Options                                                                                                                                                                       |                   | Description                                                                                                                                      |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Main                                                                                                                                                                          |                   |                                                                                                                                                  |
|                                                                                                                                                                               | `noconstant`      | suppress constant term                                                                                                                           |
|                                                                                                                                                                               | `offset(varname)` | include `varname` in model with coefficient constrained to 1                                                                                     |
| SE                                                                                                                                                                            |                   |                                                                                                                                                  |
|                                                                                                                                                                               | `vce(vcetype)`    | `vcetype` may be `conventional`, `bootstrap`, or `jackknife`                                                                                     |
| Reporting                                                                                                                                                                     |                   |                                                                                                                                                  |
|                                                                                                                                                                               | `level(#)`        | set confidence level; default is `level(95)`                                                                                                     |
|                                                                                                                                                                               | `betas`           | display group-specific best linear predictors                                                                                                    |
|                                                                                                                                                                               | `display_options` | control columns and column formats, row spacing, line width, display of omitted variables and base and empty cells, and factor-variable labeling |
|                                                                                                                                                                               | `coeflegend`      | display legend instead of statistics                                                                                                             |
| A panel variable must be specified; use [<strong>xtset</strong>](http://www.stata.com/help.cgi?xtset).                                             |                   |                                                                                                                                                  |
| `indepvars` may contain factor variables; see [<strong>fvvarlist</strong>](http://www.stata.com/help.cgi?fvvarlist).                               |                   |                                                                                                                                                  |
| `by`, `mi estimate`, and `statsby` are allowed; see [<strong>prefix</strong>](http://www.stata.com/help.cgi?prefix).                               |                   |                                                                                                                                                  |
| `vce(bootstrap)` and `vce(jackknife)` are not allowed with the [<strong>mi estimate</strong>](http://www.stata.com/help.cgi?mi%20estimate) prefix. |                   |                                                                                                                                                  |
| `coeflegend` does not appear in the dialog box.                                                                                                                               |                   |                                                                                                                                                  |
| See [<strong>[XT]</strong> xtrc postestimation](http://www.stata.com/help.cgi?xtrc_postestimation) for features available after estimation.        |                   |                                                                                                                                                  |