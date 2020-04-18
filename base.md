## -XNoDerivingVia GC Stats

```plaintext
  63,580,560,024 bytes allocated in the heap
  12,508,100,280 bytes copied during GC
     406,780,976 bytes maximum residency (33 sample(s))
       6,427,600 bytes maximum slop
             387 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      9357 colls,  9302 par   151.905s  22.715s     0.0024s    0.0363s
  Gen  1        33 colls,    28 par   14.887s   1.523s     0.0461s    0.1048s

  Parallel GC work balance: 40.42% (serial 0%, perfect 100%)

  TASKS: 38 (1 bound, 37 peak workers (37 total), using -N12)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time   50.173s  ( 30.503s elapsed)
  GC      time  166.792s  ( 24.238s elapsed)
  EXIT    time    0.002s  (  0.009s elapsed)
  Total   time  216.968s  ( 54.750s elapsed)

  Alloc rate    1,267,222,934 bytes per MUT second

  Productivity  23.1% of total user, 55.7% of total elapsed
```

## -XNoDerivingVia GC Stats with -h

```plaintext
  65,263,743,936 bytes allocated in the heap
 241,523,316,616 bytes copied during GC
   1,093,642,496 bytes maximum residency (435 sample(s))
      10,806,584 bytes maximum slop
            1042 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0      2229 colls,  2192 par   142.943s  23.194s     0.0104s    0.1554s
  Gen  1       435 colls,   430 par   1997.415s  172.001s     0.3954s    0.8719s

  Parallel GC work balance: 95.49% (serial 0%, perfect 100%)

  TASKS: 38 (1 bound, 37 peak workers (37 total), using -N12)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.001s elapsed)
  MUT     time   45.510s  ( 42.142s elapsed)
  GC      time  2140.358s  (195.195s elapsed)
  EXIT    time    0.004s  (  0.003s elapsed)
  Total   time  2185.872s  (237.340s elapsed)

  Alloc rate    1,434,044,786 bytes per MUT second

  Productivity   2.1% of total user, 17.8% of total elapsed
```

![no-deriving-via-heap.png](images/no-deriving-via-heap.png)


## -XDerivingVia GC Stats

```plaintext
  87,996,517,096 bytes allocated in the heap
  16,946,626,560 bytes copied during GC
     548,909,120 bytes maximum residency (35 sample(s))
       6,749,120 bytes maximum slop
             523 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0     10606 colls, 10549 par   199.264s  30.222s     0.0028s    0.0563s
  Gen  1        35 colls,    30 par   20.379s   2.016s     0.0576s    0.1676s

  Parallel GC work balance: 40.94% (serial 0%, perfect 100%)

  TASKS: 38 (1 bound, 37 peak workers (37 total), using -N12)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time   64.916s  ( 40.979s elapsed)
  GC      time  219.642s  ( 32.238s elapsed)
  EXIT    time    0.002s  (  0.003s elapsed)
  Total   time  284.561s  ( 73.220s elapsed)

  Alloc rate    1,355,542,492 bytes per MUT second

  Productivity  22.8% of total user, 56.0% of total elapsed
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

![deriving-via-heap.png](images/deriving-via-heap.png)

