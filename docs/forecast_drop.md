## Syntax

`forecast drop` \[`, options`\]

| Options                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                  | Description                           |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------|---------------------------------------|
| \*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `prefix(string)` | specify prefix for forecast variables |
| \*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | `suffix(string)` | specify suffix for forecast variables |
| \* You can specify `prefix()` or `suffix()` but not both. <span options="description">{marker description}_{nobreak None} {title None:Description} {pstd None} `forecast drop` drops variables previously created by `forecast solve`. <span options="linkspdf">{marker linkspdf}_{nobreak None} {title None:Links to PDF documentation} [Quick start](http://www.stata.com/manuals14/tsforecastdropquickstart.pdf) [Remarks and examples](http://www.stata.com/manuals14/tsforecastdropremarksandexamples.pdf) {pstd None} The above sections are not included in this help file. <span options="options">{marker options}_{nobreak None} {title None:Options} {phang None} `prefix(string)` and `suffix(string)` specify either a name prefix or a name suffix that will be used to identify forecast variables to be dropped. You may specify `prefix()` or `suffix()` but not both. By default, `forecast drop` removes all forecast variables produced by the previous invocation of `forecast solve`. {pmore None} Suppose, however, that you previously specified the `simulate()` option with `forecast solve` and wish to remove variables containing simulation results but retain the variables containing the point forecasts. Then you can use the `prefix()` or `suffix()` option to identify the simulation variables you want dropped. <span options="example">{marker example}_{nobreak None} {title None:Example} {pstd None} `forecast drop` safely removes variables previously created using `forecast solve`. Say you previously solved your model and created forecast variables that were suffixed with `_f`. Do not type {phang2 None} `. drop *_f` {pstd None} to remove those variables from the dataset. Rather, type {phang2 None} `. forecast drop` {pstd None} The former command is dangerous: Suppose you were given the dataset and asked to produce the forecast. The person who previously worked with the dataset created other variables that ended with `_f`. Using `drop` would remove those variables as well. `forecast drop` removes only those variables that were previously created by `forecast solve` based on the model in memory. |                  |                                       |