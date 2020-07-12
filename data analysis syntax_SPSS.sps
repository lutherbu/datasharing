
RMV /GDP_per_capital_1=SMEAN(GDP_per_capital).

COMPUTE Population_inflow_from_Wuhan_Ln=LN(Population_inflow_from_Wuhan).
EXECUTE.

DESCRIPTIVES VARIABLES=Population_inflow_from_Wuhan_Ln Retirement
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

COMPUTE interaction_term=ZPopulation_inflow_from_Wuhan_Ln * ZRetirement.
EXECUTE.

COMPUTE confirmed_cases_increase_from_25Jan_to_08Feb=confirmed_cases_08_Feb - 
    confirmed_cases_25_Jan.
EXECUTE.

COMPUTE virus_spread_rate_14_day=confirmed_cases_increase_from_25Jan_to_08Feb / 14.
EXECUTE.

COMPUTE confirmed_cases_increase_from_25Jan_to_15Feb=confirmed_cases_15_Feb - 
    confirmed_cases_25_Jan.
EXECUTE.

COMPUTE virus_spread_rate_21_day=confirmed_cases_increase_from_25Jan_to_15Feb / 21.
EXECUTE.

COMPUTE confirmed_cases_increase_from_25Jan_to_21Mar=confirmed_cases_21_Mar - 
    confirmed_cases_25_Jan.
EXECUTE.

COMPUTE predicted_infection_cases_increase_from_25Jan_to_21Mar=predicted_infection_cases_21_Mar - 
    predicted_infection_cases_25_Jan.
EXECUTE.

COMPUTE normalized_difference_56_day=(predicted_infection_cases_increase_from_25Jan_to_21Mar - 
    confirmed_cases_increase_from_25Jan_to_21Mar) / 
    predicted_infection_cases_increase_from_25Jan_to_21Mar.
EXECUTE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS BCOV R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT virus_spread_rate_14_day
  /METHOD=ENTER Education Position_tenure GDP_per_capital_replace ZPopulation_inflow_from_Wuhan_Ln 
    ZRetirement
  /METHOD=ENTER interaction_term.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS BCOV R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT virus_spread_rate_21_day
  /METHOD=ENTER Education Position_tenure GDP_per_capital_replace ZPopulation_inflow_from_Wuhan_Ln 
    ZRetirement
  /METHOD=ENTER interaction_term.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS BCOV R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Curve_flattening_period
  /METHOD=ENTER Education Position_tenure GDP_per_capital_replace ZPopulation_inflow_from_Wuhan_Ln 
    ZRetirement
  /METHOD=ENTER interaction_term.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS BCOV R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT normalized_difference_56_day
  /METHOD=ENTER Education Position_tenure GDP_per_capital_replace ZPopulation_inflow_from_Wuhan_Ln 
    ZRetirement
  /METHOD=ENTER interaction_term.

