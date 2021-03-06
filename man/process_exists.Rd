% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subprocess.R
\name{process_exists}
\alias{process_exists}
\title{Check if process with a given id exists.}
\usage{
process_exists(x)
}
\arguments{
\item{x}{A process handle returned by \link{spawn_process} or a OS-level process id.}
}
\value{
\code{TRUE} if process exists, \code{FALSE} otherwise.
}
\description{
Check if process with a given id exists.
}
