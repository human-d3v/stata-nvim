## Syntax

`poisson`
[depvar](http://www.stata.com/help.cgi?depvar)
\[[indepvars](http://www.stata.com/help.cgi?indepvars)\]
_\[`if`\] \[`in`\]_ \[`weight`\] \[`,`
`options`\]

| Options                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |                                | Description                                                                                                                                      |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Model                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |                                |                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `noconstant`                   | suppress constant term                                                                                                                           |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `exposure(varname_e)`          | include ln(`varname_e`) in model with coefficient constrained to 1                                                                               |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `offset(varname_o)`            | include `varname_o` in model with coefficient constrained to 1                                                                                   |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `constraints(constraints)` | apply specified linear constraints                                                                                                               |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `collinear`                    | keep collinear variables                                                                                                                         |
| SE/Robust                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |                                |                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `vce(vcetype)`                 | `vcetype` may be `oim`, `robust`, `cluster clustvar`, `opg`, `bootstrap`, or `jackknife`                                                       |
| Reporting                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |                                |                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `level(#)`                     | set confidence level; default is `level(95)`                                                                                                     |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `irr`                          | report incidence-rate ratios                                                                                                                     |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `nocnsreport`                  | do not display constraints                                                                                                                       |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `display_options`              | control columns and column formats, row spacing, line width, display of omitted variables and base and empty cells, and factor-variable labeling |
| Maximization                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                |                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `maximize_options`             | control the maximization process; seldom used                                                                                                    |
|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `coeflegend`                   | display legend instead of statistics                                                                                                             |
| `indepvars` may contain factor variables; see [<strong>fvvarlist</strong>](http://www.stata.com/help.cgi?fvvarlist).                                                                                                                                                                                                                                                                                                                                                          |                                |                                                                                                                                                  |
| `depvar`, `indepvars`, `varname_e`, and `varname_o` may contain time-series operators; see [<strong>tsvarlist</strong>](http://www.stata.com/help.cgi?tsvarlist).                                                                                                                                                                                                                                                                                                             |                                |                                                                                                                                                  |
| `bayes`, `bootstrap`, `by`, `fmm`, `fp`, `jackknife`, `mfp`, `mi estimate`, `nestreg`, `rolling`, `statsby`, `stepwise`, and `svy` are allowed; see [<strong>prefix</strong>](http://www.stata.com/help.cgi?prefix). For more details, see [<strong>[BAYES]</strong> bayes: poisson](http://www.stata.com/help.cgi?bayes_poisson) and [<strong>[FMM]</strong> fmm: poisson](http://www.stata.com/help.cgi?fmm_poisson). |                                |                                                                                                                                                  |
| `vce(bootstrap)` and `vce(jackknife)` are not allowed with the [<strong>mi estimate</strong>](http://www.stata.com/help.cgi?mi%20estimate) prefix.                                                                                                                                                                                                                                                                                                                            |                                |                                                                                                                                                  |
| Weights are not allowed with the [<strong>bootstrap</strong>](http://www.stata.com/help.cgi?bootstrap) prefix.                                                                                                                                                                                                                                                                                                                                                                |                                |                                                                                                                                                  |
| `vce()` and weights are not allowed with the [<strong>svy</strong>](http://www.stata.com/help.cgi?svy) prefix.                                                                                                                                                                                                                                                                                                                                                                |                                |                                                                                                                                                  |
| `fweight`s, `iweight`s, and `pweight`s are allowed; see [<strong>weight</strong>](http://www.stata.com/help.cgi?weight).                                                                                                                                                                                                                                                                                                                                                      |                                |                                                                                                                                                  |
| `coeflegend` does not appear in the dialog box.                                                                                                                                                                                                                                                                                                                                                                                                                                                          |                                |                                                                                                                                                  |
| See [<strong>[R]</strong> poisson postestimation](http://www.stata.com/help.cgi?poisson_postestimation) for features available after estimation.                                                                                                                                                                                                                                                                                                                              |                                |                                                                                                                                                  |