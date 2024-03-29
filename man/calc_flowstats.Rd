% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_flowstats.R
\name{calc_flowstats}
\alias{calc_flowstats}
\title{Calculate a suite of long-term and seasonal flow statistics for one or more sites.}
\usage{
calc_flowstats(data = data, site_col = "flow_site_id", date_col = "date", flow_col = "flow", ref_col = NULL)
}
\arguments{
\item{data}{Name of data frame or tibble containing the flow data to be processed.
Must be in long format and contain columns for flow site id, date and flow (see output from import_flows).}

\item{date_col}{Name of column in 'data' containing date of flow record.  Default = "date".}

\item{flow_col}{Name of column in 'data' containing flow data for processing. Default = "flow".}

\item{ref_col}{Name of column in 'data' containing flow data for reference scenario against which flow statistics are standardised. Default: NULL.}

\item{sites_col}{Name of column in 'data' containing unique flow site id. Default = "flow_site_id".}
}
\value{
calc_flowstats returns a list of two data frames. The first data frame contains a suite of time-varying flow statistics for every 6 month winter/summer period at every site. The columns are as follows:
\itemize{
\item flow_site_id (a unique site id; this is the standardised column header for flow sites)
\item season (S = summer, W = winter)
\item water_year (year starting 1st October; e.g. 2018 = 01/10/2018 to 30/09/2019)
\item Q10: the unstandardised Q10 flow in a 6-month winter or summer period.
\item Q30: the unstandardised Q30 flow in a 6-month winter or summer period.
\item Q50: the unstandardised Q50 flow in a 6-month winter or summer period.
\item Q70: the unstandardised Q70 flow in a 6-month winter or summer period.
\item Q90: the unstandardised Q70 flow in a 6-month winter or summer period.
\item Q95: the unstandardised Q95 flow in a 6-month winter or summer period.
\item Q99: the unstandardised Q99 flow in a 6-month winter or summer period.
\item Q10mean: the seasonal (winter or summer) Q10 flow, averaged across years.
\item Q10sd: the standard deviation of the seasonal (winter or summer) Q10 flows.
\item Q10z: the Q10 flow in a six month period, standardised using the above mean and sd. If ref_col = NULL, then the mean and sd parameters are calculated using the same flow time series (i.e. Q10z = (Q10 - Q10mean) / Q10sd); if not, the mean and sd parameters are calculated from the ref_col flow time series (i.e. Q10z = (Q10 - Q10mean_ref) / Q10sd_ref).
\item Q30mean: (as for Q10)
\item Q30sd: (as for Q10)
\item Q30z: (as for Q10)
\item Q50mean: (as for Q10)
\item Q50sd: (as for Q10)
\item Q50z: (as for Q10)
\item Q70mean: (as for Q10)
\item Q70sd: (as for Q10)
\item Q70z: (as for Q10)
\item Q95: (as for Q10)
\item Q95mean: (as for Q10)
\item Q95sd: (as for Q10)
\item Q95z: (as for Q10)
\item zero:	Number of zero flow days
\item mean:	mean flow
\item sd: standard deviation of flows
\item lsd: standard deviation of the log flow series
\item n:	number of days (182 or 183)
\item e3: number of events when flows exceed 3 x the long-term median (Q50) flow
\item e5: number of events when flows exceed 5 x the long-term median (Q50) flow
\item e7: number of events when flows exceed 7 x the long-term median (Q50) flow
\item missing: number of missing records (NAs)
\item durationAbove: number of records above the long-term Q70
\item nEventsAbove: number of events when flows exceed the long-term Q70
\item durationBelow: number of records below the long-term Q95
\item nEventsBelow: number of events when flows exceed the long-term Q95
\item e3mean: e3, averaged across years
\item e5mean: e5, averaged across years
\item e7mean: e7, averaged across years
\item durationAboveMean: durationAbove, averaged across years
\item durationBelowMean: durationBelow, averaged across years
\item nEventsAboveMean: nEventsAbove, averaged across years
\item nEventsBelowMean: nEventsBelow, averaged across years
}

The second data table contains long-term flow statistics. The data are arranged in long format, with the following columns:
\itemize{
\item flow_site_id (a unique site id)
\item season (S = summer, W = winter, A = all)
\item parameter (base flow index (bfi), flow duration curve percentiles (p1 to p99), and seasonal means and standard deviations for Q10, Q30, Q50, Q75 and Q95).
\item value (calculated statistic)
}
}
\description{
calc_flowstats uses a time series of measured or modeled flows to calculate a suite of long-term and seasonal (winter and summer) flow statistics for one or more sites (stations). It is primarily designed to work with mean daily flows (e.g. as produced by import_flow), but can also be applied to time series data on a longer (e.g. monthly) time step. Regardless, the data should be regularly spaced and the same time step should be used for all sites.
}
\details{
The function is hard-wired to exclude any flow data before 1st April 1985.  Must be in long format and contain columns named "flow_site_id", "Date" and "Flow" (see output from import_flows).

Winter is defined as 1st October to 31st March, and Summer as 1st April to 30th September. There is no minimum number of records required in each 6 month period; if desired, the outputs can be filtered afterwards to eliminate potentially unreliable results based on sparse data.

Selected flow percentiles (Q10, Q30, Q50, Q70 and Q95) are calculated for each 6 month winter/summer, and then standardized using the long-term mean and standard deviation of these statistics. If calculating flow statistics for two different flow scenarios (e.g. historical and naturalised), then the function includes the facility to standardise the flow percentile statistics for one scenario (specified via flow_col) using mean and standard deviation of flow statistics from the other scenario (specified via ref_col). For example, if flow_col = naturalised flows and ref_col = historical flows, then the resulting statistics can be input into a hydro-ecological model calibrated using historical flow data and used to make predictions of ecological status under naturalised flows.
}
\examples{
## Calculate a suite of long-term and seasonal flow statistics for all sites listed in site_col:
calc_flowstats(data = flow_data,
                site_col = "flow_site_id",
                date_col = "date",
                flow_col = "flow")

## Calculate a suite of long-term and seasonal flow statistics for all sites listed in site_col, and standardise QXX flow statistics using flow data specified in ref_col:
calc_flowstats(data = data,
               site_col = "flow_site_id",
               date_col = "date",
               flow_col = "HistoricalFlow",
               ref_col = "NaturalisedFlow")
}
