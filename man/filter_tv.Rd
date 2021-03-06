\name{filter_tv}
\alias{filter_tv}
\title{ Recursive filter with time-varying coefficient }
\description{
  This is simply an AR(1) recursive filter with a time-varying recession rate.
}
\usage{
filter_tv(x, a, init = 0)
}
\arguments{
  \item{x}{ numeric vector or time series. }
  \item{a}{ numeric vector the same length as \code{x}, giving the filter coefficient at each time step. }
  \item{init}{ value for \code{x[0]}. }
}
\note{
	If there are internal missing values, these are skipped over in the calculation,
	maintaining the "state": the value of \code{y[i-1]} after any missing values
	is the value from just before them. This behaviour is different from
	\code{\link{filter}}, which drops the state back to 0.
}
\value{
 a numeric vector or time series, like \code{x}.
}
\author{ Felix Andrews \email{felix@nfrac.org} }
\seealso{ \code{\link{filter}} }
\examples{
## The non-compiled function is this simple, if there are no NAs:
ftv2 <- function(x, a, init=0)
{
	y <- x
	y[1] <- x[1] + a[1] * init
	for (i in 2:length(x)) {
		y[i] <- x[i] + a[i] * y[i-1]
	}
	return(y)
}
## make a sine wave filter
a <- sin(pi * seq(0, 3*pi, length=100)) * 0.2 + 0.9
plot.ts(a, ylim=c(0, 1.2))
## response to a unit impluse
x <- c(1,rep(0,99))
y <- filter_tv(x, a)
plot.ts(y, log="y")
stopifnot(isTRUE(all.equal(y, ftv2(x, a))))
## treatment of missing values
x[15:20] <- NA
plot.ts(filter_tv(x, a), log="y")
}
\keyword{ ts }

