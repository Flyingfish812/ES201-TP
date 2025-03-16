## Q6 :

Paramètres par defaut :
(celles non commentées):

- Taille de cache: 131072 octets (128 KB) - ligne 5 avec -size (bytes) 131072
- Taille de bloc: 64 octets - ligne 27 avec -block size (bytes) 64
- Associativité: 2 - ligne 31 avec -associativity 2
- Technologie: 90 nm - ligne 45 avec -technology (u) 0.090

## Q7

| Processeur | Surface L1 | Surface L2 | % de la surface totale | Taille de coeur |
| ---------- | ---------- | ---------- | ---------------------- | --------------- |
| Cortex A15 | 0.046772   | 0.757472   | 2.338604               | 1.953228        |
| Cortex A7  | 0.046772   | 0.565270   | 10.393797              | 0.403228        |

## Q8: Varying L1 cache sizes

### Testing L1 cache size: 8KB

- A7 - L1 cache area: 0.022613 mm², Total area: 0.425841 mm²
- A15 - L1 cache area: 0.022613 mm², Total area: 1.975841 mm²

### Testing L1 cache size: 16KB

- A7 - L1 cache area: 0.030837 mm², Total area: 0.434065 mm²
- A15 - L1 cache area: 0.030837 mm², Total area: 1.984065 mm²

### Testing L1 cache size: 32KB

- A7 - L1 cache area: 0.046772 mm², Total area: 0.450000 mm²
- A15 - L1 cache area: 0.046772 mm², Total area: 2.000000 mm²

### Testing L1 cache size: 64KB

- A7 - L1 cache area: 0.079563 mm², Total area: 0.482791 mm²
- A15 - L1 cache area: 0.079563 mm², Total area: 2.032791 mm²

### Testing L1 cache size: 128KB

- A7 - L1 cache area: 0.155926 mm², Total area: 0.559154 mm²
- A15 - L1 cache area: 0.155926 mm², Total area: 2.109154 mm²

### Testing L1 cache size: 256KB

- A7 - L1 cache area: 0.284330 mm², Total area: 0.687558 mm²
- A15 - L1 cache area: 0.284330 mm², Total area: 2.237558 mm²

### Results

### Results

| L1 Cache Size (KB) | A7 L1 Area (mm²) | A15 L1 Area (mm²) | A7 Total Area (mm²) | A15 Total Area (mm²) |
| ------------------ | ---------------- | ----------------- | ------------------- | -------------------- |
| 8.0                | 0.022613         | 0.022613          | 0.425841            | 1.975841             |
| 16.0               | 0.030837         | 0.030837          | 0.434065            | 1.984065             |
| 32.0               | 0.046772         | 0.046772          | 0.450000            | 2.000000             |
| 64.0               | 0.079563         | 0.079563          | 0.482791            | 2.032791             |
| 128.0              | 0.155926         | 0.155926          | 0.559154            | 2.109154             |
| 256.0              | 0.284330         | 0.284330          | 0.687558            | 2.237558             |

## Q10: Power consumption at maximum frequency

- Cortex A7: 100.00 mW
- Cortex A15: 500.00 mW

![](cache_area_analysis.png)
