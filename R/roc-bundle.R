#### ALL CODE BELOW IS BUNDLED FROM THE ROC PACKAGE (https://github.com/davidavdav/ROC)
#### Author and copyright holder: David A. van Leeuwen
#### License: GPL-2

as.cst <- function(x) {
  if ("cst" %in% class(x)) return(x)
  if ("roc" %in% class(x)) return(attr(x, "data"))
  stopifnot("data.frame" %in% class(x), c("score", "target") %in% names(x), is.logical(x$target), is.numeric(x$score) || is.ordered(x$score))
  class(x) <- c("cst", class(x))
  return(x)
}

train.logreg <- function(x, dep="score") {
  x <- as.cst(x)
  weights <- 1/table(x$target)
  f <- stats::formula(paste("target ~", dep))
  model <- stats::glm(f, x, family=binomial, weight=weights[1+x$target])
}

## pAUC: probability that a random non-target score is higher than a random target score
pAUC <- function(pfa, pmiss) {
  nt <- length(pfa)
  -sum((pmiss[-nt]+pmiss[-1]) * diff(pfa)) / 2
}

`rangecheck` <- function(x) {
  x[x<0]=0
  x[x>1]=1
  x
}

`opt.llr` <- function(x, laplace=T) {
  o <- order(x$score, !x$target)        # break ties in pessimistic order
  p.ideal <- as.numeric(x$target[o])    # ideal posterior
  if (is.null(x$weight)) x$weight=1 # did we have weights?
  w.ideal <- x$weight[o]
  nt <- sum(p.ideal)
  nn <- sum(1-p.ideal)
  if (laplace) {
    p.ideal <- c(1,0,p.ideal,1,0) ## lapace's rule of succession
    w.ideal <- c(1,1,w.ideal,1,1)
  }
  p.opt <- fdrtool::monoreg(p.ideal,w=w.ideal)$yf
  if (laplace)
    p.opt <- p.opt[3:(length(p.opt)-2)]
  post.log.odds <- log(p.opt)-log(1-p.opt)
  prior.log.odds <- log(nt/nn)
  llrs <- post.log.odds - prior.log.odds
  llrs[o] <- llrs
  transform(x, opt.llr=llrs)
}

`Cllr` <- function(x, opt=F) {
  if (opt) {                            # do we want optimum?
    if (is.null(x$opt.llr)) x <- opt.llr(x, F) # did we have optimum?
    x$score <- x$opt.llr
  }
  if (is.null(x$weight)) x$weight <- 1  # did we have weights?
  c.miss <- 1/log(2) * mean(log(1+exp(-x$score[x$target]))*x$weight[x$target])
  c.fa <- 1/log(2) * mean(log(1+exp(x$score[!x$target]))*x$weight[!x$target])
  (c.miss+c.fa)/2
}

## Function to compute the EER through the convex hull
eer <- function(pfa, pmiss, index=NULL) {
  if (is.null(index)) {
    ## first, add a "corner" (1.1,1.1)
    n <- length(pfa)                      # number of points
    pfa <- c(pfa, 1.1)
    miss <- c(pmiss, 1.1)
    index <- chull(pfa, pmiss)               # find convex hull data points
    index <- sort(index[index<=n])          # remove corner
  }
  i <- which(diff(sign(pfa[index]-pmiss[index]))!=0)[1] # in case there are multiple cases...
  if (i==length(index))                   # this should not happen
    return ((pfa[i]+pmiss[i])/2)
  ## intersect convex hull segment with y=x
  ax <- pfa[index][i]
  bx <- pfa[index][i+1]
  ay <- pmiss[index][i]
  by <- pmiss[index][i+1]
  ax + (ax-ay)*(bx-ax) / (ax-ay-bx+by)
}

## this should cover most cases of input data now
roc <- function(x, cond, laplace=T) {
  x <- as.cst(x)
  call <- match.call()
  ordered <- is.ordered(x$score)        #ordered factor
  if (!missing(cond)) {
    ct <- eval(substitute(cond.table(x, cond, target=TRUE)), x, parent.frame())
    nvar <- ncol(ct)-1
    mf <- tapply(ct$Freq, ct$target, mean)
    ct$weight <- as.vector(mf[ct$target]/ct$Freq)
    x <- merge(x, ct, by=names(ct)[1:nvar])
  } else {
    x$weight <- 1
  }
  o <- order(x$score, !x$target)        # order targets before nontargets
  xo <- x[o,]
  score <- xo$score
  w <- xo$weight
  discrete <- length(unique(score)) < 0.5 * length(score)
  t <- as.numeric(xo$target)             # targets, delta pmiss
  if (laplace & !ordered) {
    t <- c(1, 0, t, 1, 0)
    if (ordered) {                    # this shouldn't happen
      ls <- length(score)
      score <- score[c(1,1,1:ls,1,1)]
      score[1:2] <- min(score)
      score[ls+(1:2)] <- max(score)
    } else {
      score <- c(-Inf, -Inf, score, Inf, Inf)
    }
    w <- c(1, 1, w, 1, 1)
  }
  n <- 1-t                              # nontargtes, delta pfa
  nt <- sum(t*w)                        # number of target trials
  nn <- sum((1-t)*w)                    # number of non-target trials
  ## in the following, we group targets and non-targets with identical score
  ## we need to step carfully through them, as their cumulative counts need
  ## to be used to compute delta PFA and delta pmiss.
  dt <- c(1,diff(as.numeric(score))!=0,1)         # points where threshold changes
  changes <- which(dt!=0)
  if (ordered) {                        # can't append to a factor
    thres <- score[c(1:length(score),1)]
    thres[length(score)+1] <- NA
  }
  else
    thres <- c(score,NA)
  remove <- numeric(0)
  for (i in 1:(length(changes)-1)) {
    start <- changes[i]
    end <- changes[i+1]-1
    if (end>start) {
      t[start] <- sum(t[start:end])
      n[start] <- sum(n[start:end])
      remove <- c(remove, (start+1):end)           # mark range for removal
    }
  }
  if (length(remove)>0) {               # why 1 and not 0?  Seemed to be a major bug!
    t <- t[-remove]
    n <- n[-remove]
    thres <- thres[-remove]
    w <- w[-remove]
  }
  pmiss <- c(0,rangecheck(cumsum(t*w)/nt)) # the cummlative (weighted) probs
  pfa <- c(1,rangecheck(1 - cumsum(n*w)/nn))
  ## next we want to optimize the entries in the (PFA, pmiss, thres) table.
  ## entries where one of (PFA, pmiss) does not change, but the other one does.
  noch.pfa <- diff(pfa) == 0
  noch.pmiss <- diff(pmiss) == 0
  nch <- length(noch.pfa)
  if (nch>1) {
    changes <- c(T, ! (noch.pfa[1:(nch-1)] & noch.pfa[2:nch] | noch.pmiss[1:(nch-1)] & noch.pmiss[2:nch]), T)
    pfa <- pfa[changes]
    pmiss <- pmiss[changes]
    thres <- thres[changes]
  }
  roc <- data.frame(pfa, pmiss, thres)
  ## finally, compute the convex hull
  ## first, add a "corner" (1.1,1.1)
  n <- length(pfa)                      # number of points
  pfa <- c(pfa, 1.1)
  pmiss <- c(pmiss, 1.1)
  index <- chull(pfa, pmiss)               # find convex hull data points
  index <- sort(index[index<=n])          # remove corner
  roc$chull <- F
  roc$chull[index] <- T
  ## mind the abs( ) in the following expression, just to take care of 1/0=Inf (not -Inf)
  roc$opt.llr <- with(subset(roc, chull), log(abs(diff(pmiss) / diff(pfa))))[cumsum(roc$chull)]
  ## then, through isotonic regression---this should give identical answers
  x.opt <- attr(roc, "data") <- opt.llr(x, laplace)
  pauc <- pAUC(pfa[index], pmiss[index])
  ##eer
  if (ordered)
    stats <- list(Cllr=NA, Cllr.min=Cllr(x.opt, T), eer=100*eer(pfa, pmiss, index), pAUC=pauc,
                  mt=NA, mn=NA, nt=nt, nn=nn, n=nt+nn, discrete=T)
  else
    stats <- list(Cllr=Cllr(x), Cllr.min=Cllr(x.opt, T), eer=100*eer(pfa, pmiss, index), pAUC=pauc,
                  mt=mean(x$score[x$target]), mn=mean(x$score[!x$target]), nt=nt, nn=nn, n=nt+nn,
                  discrete=discrete)
  attr(roc, "call") <- call
  attr(roc, "stats") <- stats
  class(roc) <- c("roc", class(roc))
  roc
}

## this should cover roc.sre and roc.data.frame
#roc.default <- function(x) roc(as.cst(x))

summaryroc <- function(x) {
  data.frame(attr(x, "stats")[1:8])
}
