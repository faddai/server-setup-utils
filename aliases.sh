# list top 10 processes ordered by memory usage
alias top10="ps -eo pmem,pcpu,vsize,pid,cmd | sort -k 1 -nr | head -10"