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

## Time

| Stage                          | -XNoDerivingVia Time | -XDerivingVia Time | Diff      |
| ------------------------------ | -------------------- | ------------------ | --------- |
| Parser 1                       | 0.08s                | 0.049s             | -0.031    |
| Renamer/typechecker 1          | 10.086s              | 13.426s            | +3.34s    |
| Desugar 1                      | 0.29s                | 0.269s             | -0.021    |
| Simplifier 1                   | 10.92s               | 26.697s            | +15.776s  |
| Specialise 1                   | 1.933s               | 4.633s             | +2.7s     |
| Float out 1                    | 4.535s               | 6.124s             | +1.589s   |
| Simplifier 2                   | 50.879s              | 67.449s            | +16.569s  |
| Simplifier 3                   | 89.825s              | 121.334s           | +31.509s  |
| Simplifier 4                   | 83.293s              | 103.967s           | +20.674s  |
| Float inwards 1                | 0.0s                 | 0.0s               | +0.0s     |
| Called arity analysis 1        | 0.0s                 | 0.0s               | -0.0      |
| Simplifier 5                   | 75.801s              | 92.826s            | +17.025s  |
| Demand analysis 1              | 10.729s              | 16.558s            | +5.828s   |
| Worker Wrapper binds 1         | 1.377s               | 0.895s             | -0.482    |
| Simplifier 6                   | 63.525s              | 86.922s            | +23.397s  |
| Exitification transformation 1 | 0.0s                 | 0.0s               | +0.0s     |
| Float out 2                    | 20.235s              | 27.78s             | +7.545s   |
| Common sub-expression 1        | 0.0s                 | 0.0s               | -0.0      |
| Float inwards 2                | 0.0s                 | 0.0s               | -0.0      |
| Simplifier 7                   | 81.041s              | 102.338s           | +21.297s  |
| Demand analysis 2              | 8.95s                | 15.716s            | +6.766s   |
| CoreTidy 1                     | 1.021s               | 1.753s             | +0.733s   |
| CorePrep 1                     | 0.0s                 | 0.0s               | -0.0      |
| CodeGen 1                      | 7.509s               | 13.68s             | +6.172s   |
| CorePrep 2                     | 0.0s                 | 0.0s               | -0.0      |
| CodeGen 2                      | 10.22s               | 13.238s            | +3.018s   |
| Total                          | 532.25s              | 715.652s           | +183.402s |

## Time, sorted by diff

| Stage                          | -XNoDerivingVia Time | -XDerivingVia Time | Diff      |
| ------------------------------ | -------------------- | ------------------ | --------- |
| Total                          | 532.25s              | 715.652s           | +183.402s |
| Simplifier 3                   | 89.825s              | 121.334s           | +31.509s  |
| Simplifier 6                   | 63.525s              | 86.922s            | +23.397s  |
| Simplifier 7                   | 81.041s              | 102.338s           | +21.297s  |
| Simplifier 4                   | 83.293s              | 103.967s           | +20.674s  |
| Simplifier 5                   | 75.801s              | 92.826s            | +17.025s  |
| Simplifier 2                   | 50.879s              | 67.449s            | +16.569s  |
| Simplifier 1                   | 10.92s               | 26.697s            | +15.776s  |
| Float out 2                    | 20.235s              | 27.78s             | +7.545s   |
| Demand analysis 2              | 8.95s                | 15.716s            | +6.766s   |
| CodeGen 1                      | 7.509s               | 13.68s             | +6.172s   |
| Demand analysis 1              | 10.729s              | 16.558s            | +5.828s   |
| Renamer/typechecker 1          | 10.086s              | 13.426s            | +3.34s    |
| CodeGen 2                      | 10.22s               | 13.238s            | +3.018s   |
| Specialise 1                   | 1.933s               | 4.633s             | +2.7s     |
| Float out 1                    | 4.535s               | 6.124s             | +1.589s   |
| CoreTidy 1                     | 1.021s               | 1.753s             | +0.733s   |
| Exitification transformation 1 | 0.0s                 | 0.0s               | +0.0s     |
| Float inwards 1                | 0.0s                 | 0.0s               | +0.0s     |
| Common sub-expression 1        | 0.0s                 | 0.0s               | -0.0      |
| Float inwards 2                | 0.0s                 | 0.0s               | -0.0      |
| Called arity analysis 1        | 0.0s                 | 0.0s               | -0.0      |
| CorePrep 1                     | 0.0s                 | 0.0s               | -0.0      |
| CorePrep 2                     | 0.0s                 | 0.0s               | -0.0      |
| Desugar 1                      | 0.29s                | 0.269s             | -0.021    |
| Parser 1                       | 0.08s                | 0.049s             | -0.031    |
| Worker Wrapper binds 1         | 1.377s               | 0.895s             | -0.482    |

## Allocation

| Stage                          | -XNoDerivingVia Allocation | -XDerivingVia Allocation | Diff          |
| ------------------------------ | -------------------------- | ------------------------ | ------------- |
| Parser 1                       | 35.051 MB                  | 32.948 MB                | -2.103        |
| Renamer/typechecker 1          | 698.728 MB                 | 1330.049 MB              | +631.321 MB   |
| Desugar 1                      | 22.449 MB                  | 25.76 MB                 | +3.312 MB     |
| Simplifier 1                   | 1254.692 MB                | 3028.437 MB              | +1773.745 MB  |
| Specialise 1                   | 196.157 MB                 | 1009.708 MB              | +813.551 MB   |
| Float out 1                    | 342.7 MB                   | 505.041 MB               | +162.341 MB   |
| Simplifier 2                   | 5323.286 MB                | 7422.371 MB              | +2099.085 MB  |
| Simplifier 3                   | 10241.209 MB               | 13633.87 MB              | +3392.661 MB  |
| Simplifier 4                   | 8698.237 MB                | 11112.988 MB             | +2414.752 MB  |
| Float inwards 1                | 0.162 MB                   | 0.162 MB                 | 0.0           |
| Called arity analysis 1        | 0.176 MB                   | 0.176 MB                 | 0.0           |
| Simplifier 5                   | 7963.713 MB                | 10345.508 MB             | +2381.795 MB  |
| Demand analysis 1              | 1643.384 MB                | 2198.509 MB              | +555.125 MB   |
| Worker Wrapper binds 1         | 43.757 MB                  | 57.143 MB                | +13.386 MB    |
| Simplifier 6                   | 7199.82 MB                 | 9320.079 MB              | +2120.259 MB  |
| Exitification transformation 1 | 0.171 MB                   | 0.171 MB                 | 0.0           |
| Float out 2                    | 1612.035 MB                | 2223.416 MB              | +611.382 MB   |
| Common sub-expression 1        | 0.163 MB                   | 0.163 MB                 | 0.0           |
| Float inwards 2                | 0.162 MB                   | 0.162 MB                 | 0.0           |
| Simplifier 7                   | 8982.909 MB                | 11950.616 MB             | +2967.707 MB  |
| Demand analysis 2              | 1486.519 MB                | 2047.257 MB              | +560.738 MB   |
| CoreTidy 1                     | 168.548 MB                 | 229.185 MB               | +60.637 MB    |
| CorePrep 1                     | 0.142 MB                   | 0.142 MB                 | 0.0           |
| CodeGen 1                      | 1583.906 MB                | 2624.815 MB              | +1040.909 MB  |
| CorePrep 2                     | 0.142 MB                   | 0.142 MB                 | 0.0           |
| CodeGen 2                      | 1650.152 MB                | 2769.932 MB              | +1119.779 MB  |
| Total                          | 59148.37 MB                | 81868.75 MB              | +22720.381 MB |

## Allocation, sorted by diff

| Stage                          | -XNoDerivingVia Allocation | -XDerivingVia Allocation | Diff          |
| ------------------------------ | -------------------------- | ------------------------ | ------------- |
| Total                          | 59148.37 MB                | 81868.75 MB              | +22720.381 MB |
| Simplifier 3                   | 10241.209 MB               | 13633.87 MB              | +3392.661 MB  |
| Simplifier 7                   | 8982.909 MB                | 11950.616 MB             | +2967.707 MB  |
| Simplifier 4                   | 8698.237 MB                | 11112.988 MB             | +2414.752 MB  |
| Simplifier 5                   | 7963.713 MB                | 10345.508 MB             | +2381.795 MB  |
| Simplifier 6                   | 7199.82 MB                 | 9320.079 MB              | +2120.259 MB  |
| Simplifier 2                   | 5323.286 MB                | 7422.371 MB              | +2099.085 MB  |
| Simplifier 1                   | 1254.692 MB                | 3028.437 MB              | +1773.745 MB  |
| CodeGen 2                      | 1650.152 MB                | 2769.932 MB              | +1119.779 MB  |
| CodeGen 1                      | 1583.906 MB                | 2624.815 MB              | +1040.909 MB  |
| Specialise 1                   | 196.157 MB                 | 1009.708 MB              | +813.551 MB   |
| Renamer/typechecker 1          | 698.728 MB                 | 1330.049 MB              | +631.321 MB   |
| Float out 2                    | 1612.035 MB                | 2223.416 MB              | +611.382 MB   |
| Demand analysis 2              | 1486.519 MB                | 2047.257 MB              | +560.738 MB   |
| Demand analysis 1              | 1643.384 MB                | 2198.509 MB              | +555.125 MB   |
| Float out 1                    | 342.7 MB                   | 505.041 MB               | +162.341 MB   |
| CoreTidy 1                     | 168.548 MB                 | 229.185 MB               | +60.637 MB    |
| Worker Wrapper binds 1         | 43.757 MB                  | 57.143 MB                | +13.386 MB    |
| Desugar 1                      | 22.449 MB                  | 25.76 MB                 | +3.312 MB     |
| Float inwards 1                | 0.162 MB                   | 0.162 MB                 | 0.0           |
| Called arity analysis 1        | 0.176 MB                   | 0.176 MB                 | 0.0           |
| Exitification transformation 1 | 0.171 MB                   | 0.171 MB                 | 0.0           |
| Common sub-expression 1        | 0.163 MB                   | 0.163 MB                 | 0.0           |
| Float inwards 2                | 0.162 MB                   | 0.162 MB                 | 0.0           |
| CorePrep 1                     | 0.142 MB                   | 0.142 MB                 | 0.0           |
| CorePrep 2                     | 0.142 MB                   | 0.142 MB                 | 0.0           |
| Parser 1                       | 35.051 MB                  | 32.948 MB                | -2.103        |

