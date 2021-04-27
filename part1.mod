model;

param M; # liczba maszyn
param N; # liczba czesci
param efficiency {1..M, 1..N}; # wydajnosc [szt/h]
param C {1..N};	# minimalne ilosci wypr. czesci
param R_exp {1..M};	# wartosci oczekiwane kosztow maszyn [pln/h]



var bool{1..M} binary; #okresla czy nadwyzka zostala przekroczona
var t_first {1..M, 1..N}; # czas 80% malej [maszyna,czesc]
var t_sec {1..M, 1..N};	# czas 100% wydajnosci [maszyna,czesc]
var gen_t {m in 1..M} = sum {n in 1..N} (t_first[m,n] + t_sec[m,n]); #ogolny czas pracy masz
var t_mach_comp {m in 1..M, n in 1..N} = t_first[m,n] + t_sec[m,n]; #czas pracy masz\czeszc
var c {n in 1..N} = sum {m in 1..M} efficiency[m,n] * (t_first[m,n] + t_sec[m,n]);


var total_cost = (sum{m in 1..M, n in 1..N} 0.8*t_first[m,n]*R_exp[m]) + (sum{m in 1..M, n in 1..N} t_sec[m,n]*R_exp[m]) + sum{m in 1..M} bool[m]*20*R_exp[m];



subject to c2: total_cost >= 0;

subject to c1 {n in 1..N}:
  c[n] >= C[n];

subject to t1 {m in 1..M}:
  sum {n in 1..N} (t_first[m,n] + t_sec[m,n]) <= 180;

subject to t2 {m in 1..M, n in 1..N}:
  t_first[m,n] >= 0;
  
subject to t3 {m in 1..M}:
  sum {n in 1..N} t_first[m,n] <= 100;

subject to t4 {m in 1..M, n in 1..N}:
  t_sec[m,n] >= 0;
  
subject to t5 {m in 1..M}:
  sum {n in 1..N} t_first[m,n] >= 100 * bool[m];

subject to t6 {m in 1..M}:
  sum {n in 1..N} t_sec[m,n] <= 180 * bool[m];
  

  
  
minimize model: total_cost;

