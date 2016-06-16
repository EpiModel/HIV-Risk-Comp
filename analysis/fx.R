
## P1 functions

epi_stats <- function(sim, ir.base, incid.base,
                      time = 10 * 52, qnt.low = 0.025, qnt.high = 0.975,
                      return.val = NULL) {

  sim <- truncate_sim(sim, at = 2600)
  mn <- as.data.frame(sim)
  ql <- as.data.frame(sim, out = "qnt", qval = qnt.low)
  qu <- as.data.frame(sim, out = "qnt", qval = qnt.high)


  out.prev <- round(data.frame(mean = mn$i.prev[time],
                         ql = ql$i.prev[time], qu = qu$i.prev[time]), 3)
  # if (return.val == "prev") return(out.prev)

  out.incid <- round(data.frame(
    mean = (mean(tail(mn$incid, 100)) /
              ((1 - mean(tail(mn$i.prev, 100))) * mean(tail(mn$num, 100)))) * 52 * 100,
    ql = (mean(tail(ql$incid, 100)) /
            ((1 - mean(tail(ql$i.prev, 100))) * mean(tail(ql$num, 100)))) * 52 * 100,
    qu = (mean(tail(qu$incid, 100)) /
            ((1 - mean(tail(qu$i.prev, 100))) * mean(tail(qu$num, 100)))) * 52 * 100), 2)
  # if (return.val == "incid") return(out.incid)

  ir <- (colSums(sim$epi$incid)/
           sum((1 - mn$i.prev) * mn$num)) * 52 * 1e5
  vec.nia <- round(ir.base - unname(ir), 1)
  out.nia <- round(data.frame(mean = mean(vec.nia),
                         ql = quantile(vec.nia, qnt.low, names = FALSE),
                         qu = quantile(vec.nia, qnt.high, names = FALSE)), 0)
  # if (return.val == "nia") return(out.nia)


  vec.pia <- vec.nia/ir.base
  out.pia <- round(data.frame(mean = mean(vec.pia),
                         ql = quantile(vec.pia, qnt.low, names = FALSE),
                         qu = quantile(vec.pia, qnt.high, names = FALSE)), 3)
  # if (return.val == "pia") return(out.pia)

  py.on.prep <- unname(colSums(sim$epi$prepCurr))/52
  vec.nnt <- py.on.prep/(incid.base - unname(colSums(sim$epi$incid)))
  out.nnt <- round(data.frame(mean = mean(vec.nnt),
                         ql = quantile(vec.nnt, qnt.low, names = FALSE),
                         qu = quantile(vec.nnt, qnt.high, names = FALSE)), 0)
  # if (return.val == "nnt") return(out.nnt)

  cat("\nPrevalence:")
  print(out.prev)

  cat("Incidence:")
  print(out.incid)

  cat("NIA:")
  print(out.nia)

  cat("PIA:")
  print(out.pia)

  cat("NNT:")
  print(out.nnt)

}
