% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subprocess.R
\docType{data}
\name{spawn_process}
\alias{spawn_process}
\alias{print.process_handle}
\alias{is_process_handle}
\alias{TERMINATION_GROUP}
\alias{TERMINATION_CHILD_ONLY}
\title{Start a new child process.}
\format{\code{TERMINATION_GROUP} and \code{TERMINATION_CHILD_ONLY}
are single \code{character} values.}
\usage{
spawn_process(command, arguments = character(),
  environment = character(), workdir = "",
  termination_mode = TERMINATION_GROUP)

\method{print}{process_handle}(x, ...)

is_process_handle(x)

TERMINATION_GROUP

TERMINATION_CHILD_ONLY
}
\arguments{
\item{command}{Path to the executable.}

\item{arguments}{Optional arguments for the program.}

\item{environment}{Optional environment.}

\item{workdir}{Optional new working directory.}

\item{termination_mode}{Either \code{TERMINATION_GROUP} or
\code{TERMINATION_CHILD_ONLY}.}

\item{x}{Object to be printed or tested.}

\item{...}{Other parameters passed to the \code{print} method.}
}
\value{
\code{spawn_process()} returns an object of the
\emph{process handle} class.
}
\description{
In Linux, the usual combination of \code{fork()} and \code{exec()}
is used to spawn a new child process. Standard streams are redirected
over regular unnamed \code{pipe}s.

In Windows a new process is spawned with \code{CreateProcess()} and
streams are redirected over unnamed pipes obtained with
\code{CreatePipe()}. However, because non-blocking (\emph{overlapped}
in Windows-speak) read/write is not supported for unnamed pipes,
two reader threads are created for each new child process. These
threads never touch memory allocated by R and thus they will not
interfere with R interpreter's memory management (garbage collection).

\code{is_process_handle()} verifies that an object is a
valid \emph{process handle} as returned by \code{spawn_process()}.

\code{TERMINATION_GROUP}: \code{process_terminate(handle)}
and \code{process_kill(handle)} deliver the signal to the child
process pointed to by \code{handle} and all of its descendants.

\code{TERMINATION_CHILD_ONLY}:
\code{process_terminate(handle)} and \code{process_kill(handle)}
deliver the signal only to the child process pointed to by
\code{handle} but to none of its descendants.
}
\details{
\code{command} is always prepended to \code{arguments} so that the
child process can correcty recognize the name of its executable
via its \code{argv} vector. This is done automatically by
\code{spawn_process}.

\code{environment} can be passed as a \code{character} vector whose
elements take the form \code{"NAME=VALUE"}, a named \code{character}
vector or a named \code{list}.

\code{workdir} is the path to the directory where the new process is
ought to be started. \code{NULL} and \code{""} mean that working
directory is inherited from the parent.
}
\section{Termination}{


The \code{termination_mode} specifies what should happen when
\code{process_terminate()} or \code{process_kill()} is called on a
subprocess. If it is set to \code{TERMINATION_GROUP}, then the
termination signal is sent to the parent and all its descendants
(sub-processes). If termination mode is set to
\code{TERMINATION_CHILD_ONLY}, only the child process spawned
directly from the R session receives the signal.

In Windows this is implemented with the job API, namely
\code{CreateJobObject()}, \code{AssignProcessToJobObject()} and
\code{TerminateJobObject()}. In Linux, the child calls \code{setsid()}
after \code{fork()} but before \code{execve()}, and \code{kill()} is
called with the negate process id.
}

\keyword{datasets}
