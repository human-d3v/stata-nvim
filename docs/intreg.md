## Syntax

`intreg depvar1 depvar2`
\[[indepvars](http://www.stata.com/help.cgi?indepvars)\]
_\[`if`\] \[`in`\]_ \[`weight`\] \[`,`
`options`\]

`depvar1` and `depvar2` should have the following form:

<span options="16">{space 16}_`depvar1depvar2`

------------------------------------------------------------------------

<span options="10">{space 10}_`aaa`<span options="4">{space
4}_`a`<span options="8">{space 8}_`a`<span
options="11">{space 11}_`ab`<span options="4">{space
4}_`a`<span options="8">{space 8}_`b`<span
options="3">{space 3}_`b`<span options="4">{space
4}_`.`<span options="8">{space 8}_`b`<span
options="3">{space 3}_`a`<span options="4">{space
4}_`a`<span options="8">{space 8}_`.`<span
options="26">{space 26}_`.`<span options="8">{space 8}_`.`

------------------------------------------------------------------------

| Options                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |                                                                                                           | Description                                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Model                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |                                                                                                           |                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `noconstant`                                                                                              | suppress constant term                                                                                                                           |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `het(`[varlist](http://www.stata.com/help.cgi?varlist) \[`, noconstant`\]`)` | independent variables to model the variance; use `noconstant` to suppress constant term                                                          |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `offset(varname)`                                                                                         | include `varname` in model with coefficient constrained to 1                                                                                     |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `constraints(constraints)`                                                                            | apply specified linear constraints                                                                                                               |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `collinear`                                                                                               | keep collinear variables                                                                                                                         |
| SE/Robust                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                           |                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `vce(vcetype)`                                                                                            | `vcetype` may be `oim`, `robust`, `cluster clustvar`, `opg`, `bootstrap`, or `jackknife`                                                       |
| Reporting                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                           |                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `level(#)`                                                                                                | set confidence level; default is `level(95)`                                                                                                     |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `nocnsreport`                                                                                             | do not display constraints                                                                                                                       |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `display_options`                                                                                         | control columns and column formats, row spacing, line width, display of omitted variables and base and empty cells, and factor-variable labeling |
| Maximization                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |                                                                                                           |                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `maximize_options`                                                                                        | control the maximization process; seldom used                                                                                                    |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `coeflegend`                                                                                              | display legend instead of statistics                                                                                                             |
| `indepvars` and `varlist` may contain factor variables; see [<strong>fvvarlist</strong>](http://www.stata.com/help.cgi?fvvarlist).                                                                                                                                                                                                                                                                                                                         |                                                                                                           |                                                                                                                                                  |
| `depvar1`, `depvar2`, `indepvars`, and `varlist` may contain time-series operators; see [<strong>tsvarlist</strong>](http://www.stata.com/help.cgi?tsvarlist).                                                                                                                                                                                                                                                                                             |                                                                                                           |                                                                                                                                                  |
| `bayes`, `bootstrap`, `by`, `fmm`, `fp`, `jackknife`, `mfp`, `nestreg`, `rolling`, `statsby`, `stepwise`, and `svy` are allowed; see [<strong>prefix</strong>](http://www.stata.com/help.cgi?prefix). For more details, see [<strong>[BAYES]</strong> bayes: intreg](http://www.stata.com/help.cgi?bayes_intreg) and [<strong>[FMM]</strong> fmm: intreg](http://www.stata.com/help.cgi?fmm_intreg). |                                                                                                           |                                                                                                                                                  |
| Weights are not allowed with the [<strong>bootstrap</strong>](http://www.stata.com/help.cgi?bootstrap) prefix.                                                                                                                                                                                                                                                                                                                                             |                                                                                                           |                                                                                                                                                  |
| `aweight`s are not allowed with the [<strong>jackknife</strong>](http://www.stata.com/help.cgi?jackknife) prefix.                                                                                                                                                                                                                                                                                                                                          |                                                                                                           |                                                                                                                                                  |
| `vce()` and weights are not allowed with the [<strong>svy</strong>](http://www.stata.com/help.cgi?svy) prefix.                                                                                                                                                                                                                                                                                                                                             |                                                                                                           |                                                                                                                                                  |
| `aweight`s, `fweight`s, `iweight`s, and `pweight`s are allowed; see [<strong>weight</strong>](http://www.stata.com/help.cgi?weight).                                                                                                                                                                                                                                                                                                                       |                                                                                                           |                                                                                                                                                  |
| `coeflegend` does not appear in the dialog box.                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                                                                                           |                                                                                                                                                  |
| See [<strong>[R]</strong> intreg postestimation](http://www.stata.com/help.cgi?intreg_postestimation) for features available after estimation.                                                                                                                                                                                                                                                                                                             |                                                                                                           |                                                                                                                                                  |