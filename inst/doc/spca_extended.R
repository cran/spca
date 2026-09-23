## ----setup, include = FALSE-----------------------------------------
knitr::opts_chunk$set(
  prompt = TRUE,
  comment = NA,
  fig.path = "figures/",
  fig.width = 6,
  fig.height = 4.5
)
old_opt <- options(
  prompt = "R> ",
  continue = "+  ",
  width = 70,
  useFancyQuotes = FALSE
)
options(prompt = "R> ", continue = "+  ", width = 70, useFancyQuotes = FALSE)

library("spca")
source("Extended_vignette_material/spca_utilities_for_vignettes.R")

## ----load_all, include = FALSE--------------------------------------
load("Extended_vignette_material/spca_vignette_results.rda")

## ----workflow_load_ho-----------------------------------------------
data("holzinger")
dim(holzinger)
data("holzinger_scales")

## ----workflow_pca_scree, fig.cap = "Screeplot."---------------------
ho_pca = pca(holzinger, screeplot = TRUE, qq_plot = FALSE)

## ----workflow_pca_qq------------------------------------------------
mp_qqplot(ho_pca, n_fitline = -4)

## ----workflow_pca_plot, fig.cap = "Contributions to the first four PCs."----
plot(ho_pca, n_plot = 4, variable_groups = holzinger_scales)

## ----workflow_spcadef, eval = FALSE---------------------------------
#  ho_spcadef = spca(
#    M = holzinger,
#    n_comps = 4,          # four components
#    alpha = 0.95,         # 95% CVEXP
#    method = "c",         # cSPCA
#    var_selection = "f", # forward selection
#    objective = "cvexp", # stop by CVEXP
#    intensive = FALSE     # select by R-squared
#  )

## ----workflow_summary-----------------------------------------------
summary(ho_spcadef)

## ----workflow_corcomps----------------------------------------------
show_correlations(ho_spcadef)

## ----workflow_comp_pca_call-----------------------------------------
compare_spca(
  list(ho_pca, ho_spcadef),
  variable_groups = holzinger_scales,
  print_weights = TRUE,
  print_summary = TRUE,
  methods_names = c("PCA", "cSPCA")
)

## ----workflow_pca_aggr----------------------------------------------
aggregate_by_group(
  ho_spcadef,
  variable_groups = holzinger_scales,
  only_nonzero = FALSE
)

## ----workflow_print_spca--------------------------------------------
ho_spcadef

## ----workflow_bar_plot, fig.cap = "Contributions to each sPC."------
plot(ho_spcadef, controls = list(variable_names = "auto"))

## ----workflow_circplot, fig.cap = "Circular plots of the contributions to the first three sPCs."----
plot(
  ho_spcadef,
  n_plot = 3,
  plot_type = "c",
  controls = list(
    color_scale = "printsafe",
    variable_names = "auto"
  )
)

## ----workflow_heatmap, fig.cap = "Heat maps comparing cSPCA and PCA contributions."----
plot(
  ho_spcadef,
  pc_weights = ho_pca$contributions,
  plot_type = "h",
  controls = list(variable_names = "none")
)

## ----workflow_ispca_fit, eval = FALSE-------------------------------
#  ho_cspcai = spca(
#    holzinger,
#    n_comps = 4,
#    alpha = 0.95,
#    method = "c",
#    objective = "cvexp",
#    intensive = TRUE
#  )

## ----workflow_compispca_summary-------------------------------------
compare_spca(
  list(ho_spcadef, ho_cspcai),
  plot_weights = FALSE,
  variable_groups = holzinger_scales,
  print_weights = FALSE,
  print_summary = TRUE,
  col_short_names = TRUE,
  methods_names = c("cSPCA", "Intensive")
)

## ----workflow_compispca_weights-------------------------------------
compare_spca(
  list(ho_spcadef, ho_cspcai),
  plot_weights = FALSE,
  variable_groups = holzinger_scales,
  print_weights = TRUE,
  print_summary = FALSE,
  col_short_names = TRUE,
  methods_names = c("cSPCA", "Intensive")
)

## ----workflow_compispca_plot, fig.cap = "Contributions from default cSPCA and cSPCA with intensive selection."----
compare_spca(
  list(ho_spcadef, ho_cspcai),
  plot_weights = TRUE,
  variable_groups = holzinger_scales,
  col_grouplines = "firebrick2",
  color_scale = "cbb",
  print_weights = FALSE,
  print_summary = FALSE,
  col_short_names = TRUE,
  methods_names = c("cSPCA", "Intensive")
)

## ----workflow_fixed_fit, eval = FALSE-------------------------------
#  ho_spcafixed = spca(
#    holzinger,
#    alpha = 0.95,
#    n_comps = 4,
#    fixed_index_list = holzinger_scales
#  )

## ----workflow_fixed_weights-----------------------------------------
ho_spcafixed

## ----workflow_fixed_summary-----------------------------------------
summary(ho_spcafixed, cor_with_pc = TRUE)

## ----workflow_change_sign-------------------------------------------
ho_spcafixed = change_sign(ho_spcafixed, index_to_change = 2:3)
show_correlations(ho_spcafixed, type = "pcs")

## ----workflow_new_spca, eval = FALSE--------------------------------
#  A = cbind(ho_spcadef$weights[, 1], ho_cspcai$weights[, 2])
#  ho_spcahyb = new_spca(A, X = holzinger, method_name = "hybrid")

## ----workflow_check_new_spca----------------------------------------
is.spca(ho_spcahyb)

## ----workflow_mss_fit, eval = FALSE---------------------------------
#  mss_cspca95 = spca(mss, n_comps = 4)
#  mss_cspca90 = spca(mss, n_comps = 4, alpha = 0.90)

## ----workflow_mss_summary-------------------------------------------
compare_spca(
  list(mss_cspca95, mss_cspca90),
  methods_names = c("95%", "90%"),
  col_short_names = FALSE,
  plot_weights = FALSE
)

## ----workflow_mss_plot, fig.cap = "MSSCQ contributions computed with alpha equal to 0.95 and 0.90."----
compare_spca(
  list(mss_cspca95, mss_cspca90),
  x_axis_var_names = FALSE,
  methods_names = c("95%", "90%"),
  col_short_names = FALSE,
  print_tables = FALSE
)

## ----workflow_mss_correlations--------------------------------------
mss_cors

## ----workflow_isolet_fit, eval = FALSE------------------------------
#  is_cspca95 = spca(iss, n_comps = 4)
#  is_cspca90 = spca(iss, n_comps = 4, alpha = 0.90)

## ----workflow_isolet_summary----------------------------------------
compare_spca(
  list(is_cspca95, is_cspca90),
  methods_names = c("95%", "90%"),
  col_short_names = FALSE,
  plot_weights = FALSE
)

## ----workflow_isolet_plot, fig.cap = "Isolet contributions computed with alpha equal to 0.95 and 0.90."----
compare_spca(
  list(is_cspca95, is_cspca90),
  x_axis_var_names = FALSE,
  methods_names = c("95%", "90%"),
  col_short_names = FALSE,
  print_tables = FALSE
)

## ----workflow_isolet_correlations-----------------------------------
is_cors

## ----workflow_colon_fit, eval = FALSE-------------------------------
#  cos_cspca95 = spca(cos, n_comps = 4)
#  cos_cspca90 = spca(cos, n_comps = 4, alpha = 0.90)

## ----workflow_colon_summary-----------------------------------------
compare_spca(
  list(cos_cspca95, cos_cspca90),
  methods_names = c("95%", "90%"),
  col_short_names = FALSE,
  plot_weights = FALSE
)

## ----workflow_colon_plot, fig.cap = "Colon-data contributions computed with alpha equal to 0.95 and 0.90."----
compare_spca(
  list(cos_cspca95, cos_cspca90),
  x_axis_var_names = FALSE,
  methods_names = c("95%", "90%"),
  col_short_names = FALSE,
  print_tables = FALSE
)

## ----workflow_colon_correlations------------------------------------
cos_cors

## ----load_msc, include = FALSE--------------------------------------
    load("Extended_vignette_material/msc.rda", verbose = FALSE)
    load("Extended_vignette_material/ms_scalesh_fac.rda", verbose = FALSE)
     mss = scale(msc, center = FALSE, scale = TRUE)

## ----comp_methods, echo = FALSE, eval = FALSE-----------------------
#  met = c("uspca", "cspca", "pspca")
#  mss_met_spca = vector("list", 3)
#  
#  for(i in 1:3){
#    mss_met_spca[[i]] = spca(mss, n_comps = 4, method = met[i])
#  }
#  
#  mss_met_table = make_comparative_table(L = mss_met_spca, ind = 1:3,
#                                         pRAM = NULL, par_name = "method",
#                                         par_values = met)

## ----comp_meth, echo = FALSE----------------------------------------
mss_met_table

## ----comp_varsel, echo = FALSE--------------------------------------
mss_varsel_table

## ----comp_alpha, echo = FALSE, echo = FALSE-------------------------
mss_alpha_table

## ----conv_sum, echo = FALSE-----------------------------------------
compare_spca(list(mss_spcadef, mss_en_spcadef_obj),
             methods_names = c("ls", "el"),  col_short_names = FALSE,
             print_weights = FALSE, plot_weights = FALSE, print_tables = TRUE, return_tables = FALSE)

## ----mss_aggr, echo = FALSE-----------------------------------------
print(mss_agg_by_scale_print, quote = FALSE)

## ----gas_print, echo = FALSE----------------------------------------
compare_spca(list(gas_lsspca, gas_enspca_obj, gas_abspca_obj),
             x_axis_var_names = FALSE,
             methods_names = c("ls", "en", "ab"),
             col_short_names = FALSE,
             plot_weights = FALSE, print_weights = FALSE)

## ----cleanup, include = FALSE-------------------------------------------------
options(old_opt)

