## -XNoDerivingVia GC Stats

```plaintext
  65,238,676,200 bytes allocated in the heap
  13,349,324,608 bytes copied during GC
   1,038,523,608 bytes maximum residency (22 sample(s))
      10,322,728 bytes maximum slop
             990 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      7919 colls,  7882 par   174.418s  27.383s     0.0035s    0.1160s
  Gen  1        22 colls,    17 par   16.442s   1.697s     0.0772s    0.2675s

  Parallel GC work balance: 41.11% (serial 0%, perfect 100%)

  TASKS: 37 (1 bound, 36 peak workers (36 total), using -N12)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time   45.126s  ( 42.532s elapsed)
  GC      time  190.860s  ( 29.080s elapsed)
  EXIT    time    0.001s  (  0.008s elapsed)
  Total   time  235.987s  ( 71.620s elapsed)

  Alloc rate    1,445,698,412 bytes per MUT second

  Productivity  19.1% of total user, 59.4% of total elapsed
```

## -XDerivingVia GC Stats

```plaintext
  98,804,135,064 bytes allocated in the heap
  18,163,296,232 bytes copied during GC
   1,484,323,576 bytes maximum residency (22 sample(s))
      11,715,848 bytes maximum slop
            1415 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     10414 colls, 10377 par   244.454s  38.339s     0.0037s    0.0930s
  Gen  1        22 colls,    17 par   21.327s   2.186s     0.0994s    0.3817s

  Parallel GC work balance: 40.22% (serial 0%, perfect 100%)

  TASKS: 38 (1 bound, 37 peak workers (37 total), using -N12)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time   63.641s  ( 60.166s elapsed)
  GC      time  265.780s  ( 40.525s elapsed)
  EXIT    time    0.002s  (  0.009s elapsed)
  Total   time  329.425s  (100.700s elapsed)

  Alloc rate    1,552,512,610 bytes per MUT second

  Productivity  19.3% of total user, 59.7% of total elapsed
```

## -XDerivingVia GC Stats with -h

```plaintext
  98,836,106,608 bytes allocated in the heap
 505,964,462,096 bytes copied during GC
   1,685,746,768 bytes maximum residency (628 sample(s))
      14,393,736 bytes maximum slop
            1607 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      4060 colls,  4023 par   190.524s  30.964s     0.0076s    0.1490s
  Gen  1       628 colls,   623 par   4265.310s  373.021s     0.5940s    1.3825s

  Parallel GC work balance: 95.98% (serial 0%, perfect 100%)

  TASKS: 37 (1 bound, 36 peak workers (36 total), using -N12)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.001s elapsed)
  MUT     time   68.136s  ( 61.394s elapsed)
  GC      time  4455.835s  (403.985s elapsed)
  EXIT    time    0.000s  (  0.001s elapsed)
  Total   time  4523.971s  (465.380s elapsed)

  Alloc rate    1,450,566,564 bytes per MUT second

  Productivity   1.5% of total user, 13.2% of total elapsed
```

![heap.png](./images/heap.png)

